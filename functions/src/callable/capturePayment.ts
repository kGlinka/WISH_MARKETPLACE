import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { captureEscrowPayment } from '../services/escrow.service';

const db = admin.firestore();

/**
 * Captures an authorized payment (moves from authorization to funded escrow)
 *
 * This function:
 * 1. Validates the payment intent exists and is authorized
 * 2. Captures the funds to platform account
 * 3. Updates escrow status to funded
 *
 * Note: This happens automatically via webhook in most cases.
 * This callable function is provided as a backup/manual trigger.
 */
export const capturePayment = functions.https.onCall(
  async (data: { paymentIntentId: string }, context) => {
    // Authentication check
    if (!context.auth) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'Authentication required to capture payment'
      );
    }

    const userId = context.auth.uid;

    // Validate input
    if (!data.paymentIntentId) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Missing required field: paymentIntentId'
      );
    }

    try {
      // Get transaction by payment intent ID
      const transactionQuery = await db
        .collection('transactions')
        .where('paymentIntentId', '==', data.paymentIntentId)
        .limit(1)
        .get();

      if (transactionQuery.empty) {
        throw new functions.https.HttpsError(
          'not-found',
          'Transaction not found for this payment intent'
        );
      }

      const transactionDoc = transactionQuery.docs[0];
      const transaction = transactionDoc.data();

      // Get escrow details to verify permissions
      if (!transaction.escrowId) {
        throw new functions.https.HttpsError(
          'failed-precondition',
          'Transaction does not have an associated escrow'
        );
      }

      const escrowDoc = await db
        .collection('escrows')
        .doc(transaction.escrowId)
        .get();

      if (!escrowDoc.exists) {
        throw new functions.https.HttpsError('not-found', 'Escrow not found');
      }

      const escrow = escrowDoc.data();

      // Permission check: Must be buyer or admin
      const userDoc = await db.collection('users').doc(userId).get();
      const isAdmin = userDoc.data()?.role === 'admin';
      const isBuyer = escrow?.buyerId === userId;

      if (!isBuyer && !isAdmin) {
        throw new functions.https.HttpsError(
          'permission-denied',
          'Only the buyer or admin can capture payment'
        );
      }

      // Validate escrow status
      if (!['pending', 'authorized'].includes(escrow?.status)) {
        throw new functions.https.HttpsError(
          'failed-precondition',
          `Cannot capture payment for escrow with status: ${escrow?.status}`
        );
      }

      // Capture payment
      const paymentIntent = await captureEscrowPayment(data.paymentIntentId);

      return {
        success: true,
        paymentIntentId: paymentIntent.id,
        status: paymentIntent.status,
        amount: paymentIntent.amount,
        message: 'Payment captured successfully',
      };
    } catch (error: any) {
      console.error('Error capturing payment:', error);

      // Re-throw HttpsError as-is
      if (error instanceof functions.https.HttpsError) {
        throw error;
      }

      // Handle Stripe errors
      if (error.type) {
        throw new functions.https.HttpsError(
          'internal',
          error.message || 'Stripe capture failed'
        );
      }

      // Generic error
      throw new functions.https.HttpsError(
        'internal',
        error.message || 'Failed to capture payment'
      );
    }
  }
);
