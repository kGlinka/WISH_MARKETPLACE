/**
 * Escrow Service - Manages escrow payment lifecycle
 *
 * This service handles the complete escrow flow:
 * 1. Create payment intent with authorization hold
 * 2. Capture funds to platform account (escrow funded)
 * 3. Release funds when conditions met
 * 4. Handle refunds and disputes
 */

import * as admin from 'firebase-admin';
import Stripe from 'stripe';
import { stripe, calculatePlatformFee, DEFAULT_CURRENCY } from '../config/stripe.config';
import {
  EscrowStatus,
  TransactionStatus,
  TransactionType,
  EscrowRecord,
  TransactionRecord,
} from '../types/payment.types';

const db = admin.firestore();

/**
 * Creates a Stripe PaymentIntent with manual capture for escrow
 *
 * This creates an authorization hold on the customer's card.
 * Funds are not captured until explicitly confirmed.
 * Authorization holds expire after 7 days (Stripe limit).
 *
 * @param buyerId - User ID of the buyer
 * @param sellerId - User ID of the seller
 * @param wishId - ID of the wish being fulfilled
 * @param bidId - ID of the accepted bid
 * @param amount - Amount in cents
 * @param description - Payment description
 * @returns PaymentIntent client secret and IDs
 */
export async function createEscrowPaymentIntent(
  buyerId: string,
  sellerId: string,
  wishId: string,
  bidId: string,
  amount: number,
  description?: string
): Promise<{
  clientSecret: string;
  paymentIntentId: string;
  transactionId: string;
  escrowId: string;
}> {
  try {
    // Validate amount
    if (amount < 50) {
      throw new Error('Amount must be at least $0.50 (50 cents)');
    }

    // Calculate platform fee
    const platformFee = calculatePlatformFee(amount);
    const sellerAmount = amount - platformFee;

    // Create PaymentIntent with manual capture (authorization hold)
    // This authorizes the charge but doesn't capture funds yet
    const paymentIntent = await stripe.paymentIntents.create({
      amount,
      currency: DEFAULT_CURRENCY,
      capture_method: 'manual', // KEY: Manual capture enables escrow pattern
      description: description || `Payment for wish ${wishId}`,
      metadata: {
        buyerId,
        sellerId,
        wishId,
        bidId,
        platformFee: platformFee.toString(),
        sellerAmount: sellerAmount.toString(),
        type: 'escrow_deposit',
      },
      // Enable automatic payment methods based on currency
      automatic_payment_methods: {
        enabled: true,
      },
    });

    // Create transaction record
    const transactionRef = db.collection('transactions').doc();
    const transactionData: Partial<TransactionRecord> = {
      id: transactionRef.id,
      userId: buyerId,
      wishId,
      bidId,
      type: TransactionType.ESCROW_DEPOSIT,
      status: TransactionStatus.PENDING,
      amount,
      fee: platformFee,
      netAmount: sellerAmount,
      currency: DEFAULT_CURRENCY,
      paymentMethod: 'card',
      paymentIntentId: paymentIntent.id,
      description: description || `Escrow payment for wish ${wishId}`,
      metadata: {
        sellerId,
        bidId,
      },
      createdAt: new Date(),
    };

    // Create escrow record
    const escrowRef = db.collection('escrows').doc();
    const escrowData: Partial<EscrowRecord> = {
      id: escrowRef.id,
      transactionId: transactionRef.id,
      buyerId,
      sellerId,
      wishId,
      bidId,
      amount,
      status: EscrowStatus.PENDING,
      paymentIntentId: paymentIntent.id,
      releaseConditions: 'Payment held until service delivery confirmed',
      createdAt: new Date(),
    };

    // Use batch write for atomicity
    const batch = db.batch();
    batch.set(transactionRef, transactionData);
    batch.set(escrowRef, escrowData);

    // Update transaction reference in escrow
    transactionData.escrowId = escrowRef.id;
    batch.update(transactionRef, { escrowId: escrowRef.id });

    await batch.commit();

    return {
      clientSecret: paymentIntent.client_secret!,
      paymentIntentId: paymentIntent.id,
      transactionId: transactionRef.id,
      escrowId: escrowRef.id,
    };
  } catch (error) {
    console.error('Error creating escrow payment intent:', error);
    throw error;
  }
}

/**
 * Confirms and captures a payment intent (funds escrow)
 *
 * This captures the authorized funds to the platform account.
 * Must be done within 7 days of authorization.
 *
 * @param paymentIntentId - Stripe PaymentIntent ID
 * @returns Captured PaymentIntent
 */
export async function captureEscrowPayment(
  paymentIntentId: string
): Promise<Stripe.PaymentIntent> {
  try {
    // Capture the authorized payment
    // This moves funds from customer to platform account
    const paymentIntent = await stripe.paymentIntents.capture(paymentIntentId);

    // Update transaction and escrow status
    const transactionQuery = await db
      .collection('transactions')
      .where('paymentIntentId', '==', paymentIntentId)
      .limit(1)
      .get();

    if (transactionQuery.empty) {
      throw new Error('Transaction not found for payment intent');
    }

    const transactionDoc = transactionQuery.docs[0];
    const transaction = transactionDoc.data() as TransactionRecord;

    const batch = db.batch();

    // Update transaction
    batch.update(transactionDoc.ref, {
      status: TransactionStatus.COMPLETED,
      chargeId: paymentIntent.charges.data[0]?.id,
      receiptUrl: paymentIntent.charges.data[0]?.receipt_url,
      completedAt: new Date(),
      updatedAt: new Date(),
    });

    // Update escrow status to funded
    if (transaction.escrowId) {
      const escrowRef = db.collection('escrows').doc(transaction.escrowId);
      batch.update(escrowRef, {
        status: EscrowStatus.FUNDED,
        chargeId: paymentIntent.charges.data[0]?.id,
        fundedAt: new Date(),
        updatedAt: new Date(),
      });
    }

    await batch.commit();

    return paymentIntent;
  } catch (error) {
    console.error('Error capturing escrow payment:', error);
    throw error;
  }
}

/**
 * Releases escrow funds to seller
 *
 * This should be called when service/product delivery is confirmed.
 * Creates a payout record for the seller.
 *
 * @param transactionId - Transaction ID
 * @param releaseReason - Reason for release (e.g., "Service completed")
 * @returns Updated escrow record
 */
export async function releaseEscrow(
  transactionId: string,
  releaseReason?: string
): Promise<EscrowRecord> {
  try {
    // Get transaction and escrow records
    const transactionDoc = await db.collection('transactions').doc(transactionId).get();

    if (!transactionDoc.exists) {
      throw new Error('Transaction not found');
    }

    const transaction = transactionDoc.data() as TransactionRecord;

    if (!transaction.escrowId) {
      throw new Error('Transaction does not have an associated escrow');
    }

    const escrowDoc = await db.collection('escrows').doc(transaction.escrowId).get();

    if (!escrowDoc.exists) {
      throw new Error('Escrow not found');
    }

    const escrow = escrowDoc.data() as EscrowRecord;

    // Validate escrow status
    if (escrow.status !== EscrowStatus.FUNDED) {
      throw new Error(`Cannot release escrow with status: ${escrow.status}`);
    }

    // Create release transaction record
    const releaseTransactionRef = db.collection('transactions').doc();
    const releaseTransactionData: Partial<TransactionRecord> = {
      id: releaseTransactionRef.id,
      userId: escrow.sellerId,
      wishId: escrow.wishId,
      bidId: escrow.bidId,
      escrowId: escrow.id,
      type: TransactionType.ESCROW_RELEASE,
      status: TransactionStatus.COMPLETED,
      amount: transaction.netAmount || 0,
      currency: transaction.currency,
      paymentMethod: transaction.paymentMethod,
      description: releaseReason || 'Escrow funds released',
      metadata: {
        originalTransactionId: transactionId,
        buyerId: escrow.buyerId,
      },
      createdAt: new Date(),
      completedAt: new Date(),
    };

    // Create payout record (for future processing)
    const payoutRef = db.collection('payouts').doc();
    const payoutData = {
      id: payoutRef.id,
      sellerId: escrow.sellerId,
      amount: transaction.netAmount || 0,
      currency: transaction.currency,
      status: 'pending',
      transactionIds: [transactionId, releaseTransactionRef.id],
      createdAt: new Date(),
    };

    // Update records atomically
    const batch = db.batch();

    // Update escrow to released
    batch.update(escrowDoc.ref, {
      status: EscrowStatus.RELEASED,
      releasedAt: new Date(),
      updatedAt: new Date(),
      resolutionNotes: releaseReason,
    });

    // Add release transaction
    batch.set(releaseTransactionRef, releaseTransactionData);

    // Add payout record
    batch.set(payoutRef, payoutData);

    await batch.commit();

    return {
      ...escrow,
      status: EscrowStatus.RELEASED,
      releasedAt: new Date(),
      updatedAt: new Date(),
      resolutionNotes: releaseReason,
    };
  } catch (error) {
    console.error('Error releasing escrow:', error);
    throw error;
  }
}

/**
 * Refunds an escrow payment to the buyer
 *
 * This processes a full or partial refund through Stripe.
 * Should be used for disputes, cancellations, or service failures.
 *
 * @param transactionId - Transaction ID
 * @param refundAmount - Amount to refund in cents (optional, defaults to full)
 * @param reason - Reason for refund
 * @returns Refund result
 */
export async function refundEscrow(
  transactionId: string,
  refundAmount?: number,
  reason?: string
): Promise<Stripe.Refund> {
  try {
    // Get transaction and escrow records
    const transactionDoc = await db.collection('transactions').doc(transactionId).get();

    if (!transactionDoc.exists) {
      throw new Error('Transaction not found');
    }

    const transaction = transactionDoc.data() as TransactionRecord;

    if (!transaction.chargeId) {
      throw new Error('Transaction does not have a charge ID');
    }

    if (!transaction.escrowId) {
      throw new Error('Transaction does not have an associated escrow');
    }

    const escrowDoc = await db.collection('escrows').doc(transaction.escrowId).get();

    if (!escrowDoc.exists) {
      throw new Error('Escrow not found');
    }

    const escrow = escrowDoc.data() as EscrowRecord;

    // Validate escrow can be refunded
    if (![EscrowStatus.FUNDED, EscrowStatus.DISPUTED].includes(escrow.status)) {
      throw new Error(`Cannot refund escrow with status: ${escrow.status}`);
    }

    // Process refund through Stripe
    const refund = await stripe.refunds.create({
      charge: transaction.chargeId,
      amount: refundAmount, // undefined = full refund
      reason: 'requested_by_customer',
      metadata: {
        transactionId,
        escrowId: escrow.id,
        refundReason: reason || 'Escrow refund',
      },
    });

    // Create refund transaction record
    const refundTransactionRef = db.collection('transactions').doc();
    const refundTransactionData: Partial<TransactionRecord> = {
      id: refundTransactionRef.id,
      userId: escrow.buyerId,
      wishId: escrow.wishId,
      bidId: escrow.bidId,
      escrowId: escrow.id,
      type: TransactionType.ESCROW_REFUND,
      status: TransactionStatus.COMPLETED,
      amount: -(refundAmount || transaction.amount),
      currency: transaction.currency,
      paymentMethod: transaction.paymentMethod,
      description: reason || 'Escrow refund',
      metadata: {
        originalTransactionId: transactionId,
        refundId: refund.id,
      },
      createdAt: new Date(),
      completedAt: new Date(),
    };

    // Update records atomically
    const batch = db.batch();

    // Update escrow to refunded
    batch.update(escrowDoc.ref, {
      status: EscrowStatus.REFUNDED,
      refundedAt: new Date(),
      updatedAt: new Date(),
      resolutionNotes: reason,
    });

    // Update original transaction
    batch.update(transactionDoc.ref, {
      status: TransactionStatus.REFUNDED,
      refundedAt: new Date(),
      updatedAt: new Date(),
    });

    // Add refund transaction
    batch.set(refundTransactionRef, refundTransactionData);

    await batch.commit();

    return refund;
  } catch (error) {
    console.error('Error refunding escrow:', error);
    throw error;
  }
}

/**
 * Marks an escrow as disputed
 *
 * Pauses any automatic release and flags for manual review.
 *
 * @param transactionId - Transaction ID
 * @param disputeReason - Reason for dispute
 * @returns Updated escrow record
 */
export async function disputeEscrow(
  transactionId: string,
  disputeReason: string
): Promise<EscrowRecord> {
  try {
    const transactionDoc = await db.collection('transactions').doc(transactionId).get();

    if (!transactionDoc.exists) {
      throw new Error('Transaction not found');
    }

    const transaction = transactionDoc.data() as TransactionRecord;

    if (!transaction.escrowId) {
      throw new Error('Transaction does not have an associated escrow');
    }

    const escrowDoc = await db.collection('escrows').doc(transaction.escrowId).get();

    if (!escrowDoc.exists) {
      throw new Error('Escrow not found');
    }

    const escrow = escrowDoc.data() as EscrowRecord;

    // Validate escrow can be disputed
    if (escrow.status !== EscrowStatus.FUNDED) {
      throw new Error(`Cannot dispute escrow with status: ${escrow.status}`);
    }

    // Update escrow and transaction
    const batch = db.batch();

    batch.update(escrowDoc.ref, {
      status: EscrowStatus.DISPUTED,
      disputedAt: new Date(),
      disputeReason,
      updatedAt: new Date(),
    });

    batch.update(transactionDoc.ref, {
      status: TransactionStatus.DISPUTED,
      updatedAt: new Date(),
    });

    await batch.commit();

    return {
      ...escrow,
      status: EscrowStatus.DISPUTED,
      disputedAt: new Date(),
      disputeReason,
      updatedAt: new Date(),
    };
  } catch (error) {
    console.error('Error disputing escrow:', error);
    throw error;
  }
}

/**
 * Cancels an uncaptured payment intent
 *
 * Use this to cancel authorization holds that are no longer needed.
 *
 * @param paymentIntentId - Stripe PaymentIntent ID
 * @returns Cancelled PaymentIntent
 */
export async function cancelPaymentIntent(
  paymentIntentId: string
): Promise<Stripe.PaymentIntent> {
  try {
    // Cancel the payment intent (releases authorization hold)
    const paymentIntent = await stripe.paymentIntents.cancel(paymentIntentId);

    // Update transaction and escrow status
    const transactionQuery = await db
      .collection('transactions')
      .where('paymentIntentId', '==', paymentIntentId)
      .limit(1)
      .get();

    if (!transactionQuery.empty) {
      const transactionDoc = transactionQuery.docs[0];
      const transaction = transactionDoc.data() as TransactionRecord;

      const batch = db.batch();

      batch.update(transactionDoc.ref, {
        status: TransactionStatus.CANCELLED,
        cancelledAt: new Date(),
        updatedAt: new Date(),
      });

      if (transaction.escrowId) {
        const escrowRef = db.collection('escrows').doc(transaction.escrowId);
        batch.update(escrowRef, {
          status: EscrowStatus.CANCELLED,
          updatedAt: new Date(),
        });
      }

      await batch.commit();
    }

    return paymentIntent;
  } catch (error) {
    console.error('Error cancelling payment intent:', error);
    throw error;
  }
}

/**
 * Gets escrow details by transaction ID
 */
export async function getEscrowByTransactionId(
  transactionId: string
): Promise<EscrowRecord | null> {
  try {
    const transactionDoc = await db.collection('transactions').doc(transactionId).get();

    if (!transactionDoc.exists) {
      return null;
    }

    const transaction = transactionDoc.data() as TransactionRecord;

    if (!transaction.escrowId) {
      return null;
    }

    const escrowDoc = await db.collection('escrows').doc(transaction.escrowId).get();

    if (!escrowDoc.exists) {
      return null;
    }

    return escrowDoc.data() as EscrowRecord;
  } catch (error) {
    console.error('Error getting escrow:', error);
    return null;
  }
}
