import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { refundEscrow as refundEscrowService } from '../services/escrow.service';
import { RefundEscrowData } from '../types/payment.types';

const db = admin.firestore();

/**
 * Refunds an escrow payment to the buyer
 *
 * This function:
 * 1. Validates the transaction exists and can be refunded
 * 2. Verifies the caller has permission (buyer, seller, or admin)
 * 3. Processes refund through Stripe
 * 4. Updates transaction and escrow records
 *
 * Can be used for disputes, cancellations, or service failures
 */
export const refundEscrow = functions.https.onCall(
  async (data: RefundEscrowData, context) => {
    // Authentication check
    if (!context.auth) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'Authentication required to refund escrow'
      );
    }

    const userId = context.auth.uid;

    // Validate input
    if (!data.transactionId) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Missing required field: transactionId'
      );
    }

    if (!data.reason) {
      throw new functions.https.HttpsError(
        'invalid-argument',
        'Refund reason is required'
      );
    }

    try {
      // Get transaction details
      const transactionDoc = await db
        .collection('transactions')
        .doc(data.transactionId)
        .get();

      if (!transactionDoc.exists) {
        throw new functions.https.HttpsError(
          'not-found',
          'Transaction not found'
        );
      }

      const transaction = transactionDoc.data();

      // Get escrow details
      if (!transaction?.escrowId) {
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

      // Permission check: Buyer, seller, or admin can initiate refund
      const userDoc = await db.collection('users').doc(userId).get();
      const isAdmin = userDoc.data()?.role === 'admin';
      const isBuyer = escrow?.buyerId === userId;
      const isSeller = escrow?.sellerId === userId;

      if (!isBuyer && !isSeller && !isAdmin) {
        throw new functions.https.HttpsError(
          'permission-denied',
          'Only the buyer, seller, or admin can refund escrow'
        );
      }

      // Validate escrow can be refunded
      if (!['funded', 'disputed'].includes(escrow?.status)) {
        throw new functions.https.HttpsError(
          'failed-precondition',
          `Cannot refund escrow with status: ${escrow?.status}`
        );
      }

      // Validate refund amount if provided
      if (data.refundAmount !== undefined) {
        if (data.refundAmount <= 0 || data.refundAmount > transaction.amount) {
          throw new functions.https.HttpsError(
            'invalid-argument',
            'Invalid refund amount'
          );
        }
      }

      // Process refund
      const refund = await refundEscrowService(
        data.transactionId,
        data.refundAmount,
        data.reason
      );

      // Update wish status to cancelled if full refund
      const isFullRefund = !data.refundAmount || data.refundAmount === transaction.amount;

      if (isFullRefund && escrow.wishId) {
        await db.collection('wishes').doc(escrow.wishId).update({
          status: 'cancelled',
          cancelledAt: new Date(),
          updatedAt: new Date(),
        });
      }

      // Update bid status
      if (escrow.bidId) {
        await db.collection('bids').doc(escrow.bidId).update({
          status: 'cancelled',
          cancelledAt: new Date(),
          cancellationReason: data.reason,
          updatedAt: new Date(),
        });
      }

      // TODO: Send notifications to buyer and seller

      return {
        success: true,
        refundId: refund.id,
        amount: refund.amount,
        status: refund.status,
        message: 'Escrow refunded successfully',
      };
    } catch (error: any) {
      console.error('Error refunding escrow:', error);

      // Re-throw HttpsError as-is
      if (error instanceof functions.https.HttpsError) {
        throw error;
      }

      // Handle Stripe errors
      if (error.type) {
        throw new functions.https.HttpsError(
          'internal',
          error.message || 'Stripe refund failed'
        );
      }

      // Generic error
      throw new functions.https.HttpsError(
        'internal',
        error.message || 'Failed to refund escrow'
      );
    }
  }
);
