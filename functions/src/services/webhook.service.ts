/**
 * Webhook Service - Processes Stripe webhook events
 *
 * Handles asynchronous payment events from Stripe:
 * - payment_intent.succeeded: Payment authorized successfully
 * - payment_intent.payment_failed: Payment authorization failed
 * - charge.refunded: Refund processed
 * - charge.dispute.created: Dispute filed
 * - charge.dispute.closed: Dispute resolved
 */

import * as admin from 'firebase-admin';
import Stripe from 'stripe';
import { TransactionStatus, EscrowStatus } from '../types/payment.types';

const db = admin.firestore();

/**
 * Processes Stripe webhook events
 *
 * @param event - Verified Stripe webhook event
 */
export async function processWebhookEvent(event: Stripe.Event): Promise<void> {
  console.log(`Processing webhook event: ${event.type}`);

  try {
    switch (event.type) {
      case 'payment_intent.succeeded':
        await handlePaymentIntentSucceeded(event.data.object as Stripe.PaymentIntent);
        break;

      case 'payment_intent.payment_failed':
        await handlePaymentIntentFailed(event.data.object as Stripe.PaymentIntent);
        break;

      case 'payment_intent.canceled':
        await handlePaymentIntentCanceled(event.data.object as Stripe.PaymentIntent);
        break;

      case 'charge.refunded':
        await handleChargeRefunded(event.data.object as Stripe.Charge);
        break;

      case 'charge.dispute.created':
        await handleDisputeCreated(event.data.object as Stripe.Dispute);
        break;

      case 'charge.dispute.closed':
        await handleDisputeClosed(event.data.object as Stripe.Dispute);
        break;

      case 'charge.succeeded':
        await handleChargeSucceeded(event.data.object as Stripe.Charge);
        break;

      default:
        console.log(`Unhandled event type: ${event.type}`);
    }
  } catch (error) {
    console.error(`Error processing webhook event ${event.type}:`, error);
    throw error;
  }
}

/**
 * Handles successful payment intent
 * Updates transaction status when payment is authorized
 */
async function handlePaymentIntentSucceeded(
  paymentIntent: Stripe.PaymentIntent
): Promise<void> {
  try {
    const transactionQuery = await db
      .collection('transactions')
      .where('paymentIntentId', '==', paymentIntent.id)
      .limit(1)
      .get();

    if (transactionQuery.empty) {
      console.warn(`Transaction not found for payment intent: ${paymentIntent.id}`);
      return;
    }

    const transactionDoc = transactionQuery.docs[0];
    const transaction = transactionDoc.data();

    const batch = db.batch();

    // Update transaction status
    batch.update(transactionDoc.ref, {
      status: TransactionStatus.PROCESSING,
      updatedAt: new Date(),
    });

    // Update escrow status to authorized
    if (transaction.escrowId) {
      const escrowRef = db.collection('escrows').doc(transaction.escrowId);
      batch.update(escrowRef, {
        status: EscrowStatus.AUTHORIZED,
        updatedAt: new Date(),
      });
    }

    await batch.commit();

    console.log(`Payment intent succeeded: ${paymentIntent.id}`);
  } catch (error) {
    console.error('Error handling payment_intent.succeeded:', error);
    throw error;
  }
}

/**
 * Handles failed payment intent
 * Updates transaction with failure reason
 */
async function handlePaymentIntentFailed(
  paymentIntent: Stripe.PaymentIntent
): Promise<void> {
  try {
    const transactionQuery = await db
      .collection('transactions')
      .where('paymentIntentId', '==', paymentIntent.id)
      .limit(1)
      .get();

    if (transactionQuery.empty) {
      console.warn(`Transaction not found for payment intent: ${paymentIntent.id}`);
      return;
    }

    const transactionDoc = transactionQuery.docs[0];
    const transaction = transactionDoc.data();

    const failureReason =
      paymentIntent.last_payment_error?.message || 'Payment failed';

    const batch = db.batch();

    // Update transaction status
    batch.update(transactionDoc.ref, {
      status: TransactionStatus.FAILED,
      failureReason,
      updatedAt: new Date(),
    });

    // Update escrow status
    if (transaction.escrowId) {
      const escrowRef = db.collection('escrows').doc(transaction.escrowId);
      batch.update(escrowRef, {
        status: EscrowStatus.CANCELLED,
        updatedAt: new Date(),
      });
    }

    await batch.commit();

    console.log(`Payment intent failed: ${paymentIntent.id} - ${failureReason}`);
  } catch (error) {
    console.error('Error handling payment_intent.payment_failed:', error);
    throw error;
  }
}

/**
 * Handles canceled payment intent
 */
async function handlePaymentIntentCanceled(
  paymentIntent: Stripe.PaymentIntent
): Promise<void> {
  try {
    const transactionQuery = await db
      .collection('transactions')
      .where('paymentIntentId', '==', paymentIntent.id)
      .limit(1)
      .get();

    if (transactionQuery.empty) {
      console.warn(`Transaction not found for payment intent: ${paymentIntent.id}`);
      return;
    }

    const transactionDoc = transactionQuery.docs[0];
    const transaction = transactionDoc.data();

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

    console.log(`Payment intent canceled: ${paymentIntent.id}`);
  } catch (error) {
    console.error('Error handling payment_intent.canceled:', error);
    throw error;
  }
}

/**
 * Handles successful charge (funds captured)
 */
async function handleChargeSucceeded(charge: Stripe.Charge): Promise<void> {
  try {
    const transactionQuery = await db
      .collection('transactions')
      .where('paymentIntentId', '==', charge.payment_intent)
      .limit(1)
      .get();

    if (transactionQuery.empty) {
      console.warn(`Transaction not found for charge: ${charge.id}`);
      return;
    }

    const transactionDoc = transactionQuery.docs[0];
    const transaction = transactionDoc.data();

    const batch = db.batch();

    // Update transaction with charge details
    batch.update(transactionDoc.ref, {
      status: TransactionStatus.COMPLETED,
      chargeId: charge.id,
      receiptUrl: charge.receipt_url,
      completedAt: new Date(),
      updatedAt: new Date(),
    });

    // Update escrow to funded
    if (transaction.escrowId) {
      const escrowRef = db.collection('escrows').doc(transaction.escrowId);
      batch.update(escrowRef, {
        status: EscrowStatus.FUNDED,
        chargeId: charge.id,
        fundedAt: new Date(),
        updatedAt: new Date(),
      });
    }

    await batch.commit();

    console.log(`Charge succeeded: ${charge.id}`);
  } catch (error) {
    console.error('Error handling charge.succeeded:', error);
    throw error;
  }
}

/**
 * Handles refunded charge
 * Updates transaction and escrow status
 */
async function handleChargeRefunded(charge: Stripe.Charge): Promise<void> {
  try {
    const transactionQuery = await db
      .collection('transactions')
      .where('chargeId', '==', charge.id)
      .limit(1)
      .get();

    if (transactionQuery.empty) {
      console.warn(`Transaction not found for charge: ${charge.id}`);
      return;
    }

    const transactionDoc = transactionQuery.docs[0];
    const transaction = transactionDoc.data();

    const batch = db.batch();

    // Check if fully refunded
    const isFullyRefunded = charge.amount_refunded === charge.amount;

    batch.update(transactionDoc.ref, {
      status: isFullyRefunded
        ? TransactionStatus.REFUNDED
        : TransactionStatus.COMPLETED,
      refundedAt: new Date(),
      updatedAt: new Date(),
      metadata: {
        ...transaction.metadata,
        amountRefunded: charge.amount_refunded,
        isFullyRefunded,
      },
    });

    if (transaction.escrowId && isFullyRefunded) {
      const escrowRef = db.collection('escrows').doc(transaction.escrowId);
      batch.update(escrowRef, {
        status: EscrowStatus.REFUNDED,
        refundedAt: new Date(),
        updatedAt: new Date(),
      });
    }

    await batch.commit();

    console.log(
      `Charge refunded: ${charge.id} - Amount: ${charge.amount_refunded}/${charge.amount}`
    );
  } catch (error) {
    console.error('Error handling charge.refunded:', error);
    throw error;
  }
}

/**
 * Handles dispute creation
 * Marks escrow as disputed and freezes release
 */
async function handleDisputeCreated(dispute: Stripe.Dispute): Promise<void> {
  try {
    const transactionQuery = await db
      .collection('transactions')
      .where('chargeId', '==', dispute.charge)
      .limit(1)
      .get();

    if (transactionQuery.empty) {
      console.warn(`Transaction not found for disputed charge: ${dispute.charge}`);
      return;
    }

    const transactionDoc = transactionQuery.docs[0];
    const transaction = transactionDoc.data();

    const batch = db.batch();

    batch.update(transactionDoc.ref, {
      status: TransactionStatus.DISPUTED,
      updatedAt: new Date(),
      metadata: {
        ...transaction.metadata,
        disputeId: dispute.id,
        disputeReason: dispute.reason,
        disputeAmount: dispute.amount,
      },
    });

    if (transaction.escrowId) {
      const escrowRef = db.collection('escrows').doc(transaction.escrowId);
      batch.update(escrowRef, {
        status: EscrowStatus.DISPUTED,
        disputedAt: new Date(),
        disputeReason: dispute.reason,
        updatedAt: new Date(),
      });
    }

    await batch.commit();

    console.log(`Dispute created: ${dispute.id} - Reason: ${dispute.reason}`);

    // TODO: Send notification to seller and platform admin
  } catch (error) {
    console.error('Error handling charge.dispute.created:', error);
    throw error;
  }
}

/**
 * Handles dispute closure
 * Updates escrow based on dispute outcome
 */
async function handleDisputeClosed(dispute: Stripe.Dispute): Promise<void> {
  try {
    const transactionQuery = await db
      .collection('transactions')
      .where('chargeId', '==', dispute.charge)
      .limit(1)
      .get();

    if (transactionQuery.empty) {
      console.warn(`Transaction not found for disputed charge: ${dispute.charge}`);
      return;
    }

    const transactionDoc = transactionQuery.docs[0];
    const transaction = transactionDoc.data();

    const batch = db.batch();

    // Dispute won by merchant (funds retained)
    if (dispute.status === 'won') {
      batch.update(transactionDoc.ref, {
        status: TransactionStatus.COMPLETED,
        updatedAt: new Date(),
        metadata: {
          ...transaction.metadata,
          disputeStatus: 'won',
          disputeClosedAt: new Date().toISOString(),
        },
      });

      if (transaction.escrowId) {
        const escrowRef = db.collection('escrows').doc(transaction.escrowId);
        batch.update(escrowRef, {
          status: EscrowStatus.FUNDED,
          resolutionNotes: 'Dispute resolved in favor of seller',
          updatedAt: new Date(),
        });
      }
    }
    // Dispute lost (funds returned to customer)
    else if (dispute.status === 'lost') {
      batch.update(transactionDoc.ref, {
        status: TransactionStatus.REFUNDED,
        refundedAt: new Date(),
        updatedAt: new Date(),
        metadata: {
          ...transaction.metadata,
          disputeStatus: 'lost',
          disputeClosedAt: new Date().toISOString(),
        },
      });

      if (transaction.escrowId) {
        const escrowRef = db.collection('escrows').doc(transaction.escrowId);
        batch.update(escrowRef, {
          status: EscrowStatus.REFUNDED,
          refundedAt: new Date(),
          resolutionNotes: 'Dispute resolved in favor of buyer - funds refunded',
          updatedAt: new Date(),
        });
      }
    }

    await batch.commit();

    console.log(`Dispute closed: ${dispute.id} - Status: ${dispute.status}`);
  } catch (error) {
    console.error('Error handling charge.dispute.closed:', error);
    throw error;
  }
}
