import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { createEscrowPaymentIntent } from '../services/escrow.service';
import { CreatePaymentIntentData } from '../types/payment.types';

const db = admin.firestore();

/**
 * Creates a Stripe PaymentIntent for escrow payment
 *
 * This function:
 * 1. Validates the bid is accepted
 * 2. Validates the user is the wish owner (buyer)
 * 3. Creates a PaymentIntent with manual capture (authorization hold)
 * 4. Creates transaction and escrow records
 *
 * Client receives clientSecret to complete payment on frontend
 */
export const createPaymentIntent = functions.https.onCall(
  async (data: CreatePaymentIntentData, context) => {
    // Authentication check
    if (!context.auth) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'Authentication required to create payment intent'
      );
    }

    const userId = context.auth.uid;

    // Validate input
    if (!data.bidId || !data.wishId || !data.amount) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Missing required fields: bidId, wishId, amount'
      );
    }

    // Validate amount is positive
    if (data.amount <= 0) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Amount must be greater than 0'
      );
    }

    // Validate amount meets Stripe minimum ($0.50)
    if (data.amount < 50) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Amount must be at least $0.50 (50 cents)'
      );
    }

    try {
      // Get wish details
      const wishDoc = await db.collection('wishes').doc(data.wishId).get();

      if (!wishDoc.exists) {
        throw new functions.https.HttpsError('not-found', 'Wish not found');
      }

      const wish = wishDoc.data();

      // Verify user is the wish owner (buyer)
      if (wish?.userId !== userId) {
        throw new functions.https.HttpsError(
          'permission-denied',
          'Only the wish owner can create payment for this wish'
        );
      }

      // Get bid details
      const bidDoc = await db.collection('bids').doc(data.bidId).get();

      if (!bidDoc.exists) {
        throw new functions.https.HttpsError('not-found', 'Bid not found');
      }

      const bid = bidDoc.data();

      // Verify bid is for this wish
      if (bid?.listingId !== data.wishId) {
        throw new functions.https.HttpsError(
          'invalid-argument',
          'Bid does not belong to this wish'
        );
      }

      // Verify bid status is winning or won
      if (!['winning', 'won'].includes(bid?.status)) {
        throw new functions.https.HttpsError(
          'failed-precondition',
          'Bid must be in winning or won status'
        );
      }

      // Verify amount matches bid amount
      if (data.amount !== bid?.amount) {
        throw new functions.https.HttpsError(
          'invalid-argument',
          'Payment amount must match bid amount'
        );
      }

      const sellerId = bid.bidderId;

      // Create escrow payment intent
      const result = await createEscrowPaymentIntent(
        userId, // buyerId
        sellerId,
        data.wishId,
        data.bidId,
        data.amount,
        data.description || `Payment for wish: ${wish?.title || data.wishId}`
      );

      // Update bid with payment info
      await db.collection('bids').doc(data.bidId).update({
        paymentIntentId: result.paymentIntentId,
        transactionId: result.transactionId,
        updatedAt: new Date(),
      });

      return {
        success: true,
        clientSecret: result.clientSecret,
        paymentIntentId: result.paymentIntentId,
        transactionId: result.transactionId,
        escrowId: result.escrowId,
      };
    } catch (error: any) {
      console.error('Error creating payment intent:', error);

      // Re-throw HttpsError as-is
      if (error instanceof functions.https.HttpsError) {
        throw error;
      }

      // Handle Stripe-specific errors
      if (error.type) {
        const errorMessage = error.message || 'Payment processing error';
        throw new functions.https.HttpsError('internal', errorMessage);
      }

      // Generic error
      throw new functions.https.HttpsError(
        'internal',
        'Failed to create payment intent'
      );
    }
  }
);
