import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { releaseEscrow as releaseEscrowService } from '../services/escrow.service';
import { ReleaseEscrowData } from '../types/payment.types';

const db = admin.firestore();

/**
 * Releases escrow funds to the seller
 *
 * This function:
 * 1. Validates the transaction exists and is in escrow
 * 2. Verifies the caller has permission (buyer or admin)
 * 3. Releases funds to seller
 * 4. Creates payout record
 *
 * Should be called when service/product delivery is confirmed
 */
export const releaseEscrow = functions.https.onCall(
  async (data: ReleaseEscrowData, context) => {
    // Authentication check
    if (!context.auth) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'Authentication required to release escrow'
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

      // Permission check: Must be buyer (wish owner) or admin
      // Buyer confirms delivery, which triggers release
      if (escrow?.buyerId !== userId) {
        // Check if user is admin
        const userDoc = await db.collection('users').doc(userId).get();
        const isAdmin = userDoc.data()?.role === 'admin';

        if (!isAdmin) {
          throw new functions.https.HttpsError(
            'permission-denied',
            'Only the buyer or admin can release escrow'
          );
        }
      }

      // Validate escrow status
      if (escrow?.status !== 'funded') {
        throw new functions.https.HttpsError(
          'failed-precondition',
          `Cannot release escrow with status: ${escrow?.status}`
        );
      }

      // Release escrow
      const result = await releaseEscrowService(
        data.transactionId,
        data.reason || 'Service/product delivery confirmed by buyer'
      );

      // Update wish status to completed
      if (escrow.wishId) {
        await db.collection('wishes').doc(escrow.wishId).update({
          status: 'completed',
          completedAt: new Date(),
          updatedAt: new Date(),
        });
      }

      // Update bid status
      if (escrow.bidId) {
        await db.collection('bids').doc(escrow.bidId).update({
          status: 'won',
          updatedAt: new Date(),
        });
      }

      // TODO: Send notification to seller about payout

      return {
        success: true,
        escrowId: result.id,
        status: result.status,
        releasedAt: result.releasedAt,
        message: 'Escrow funds released successfully',
      };
    } catch (error: any) {
      console.error('Error releasing escrow:', error);

      // Re-throw HttpsError as-is
      if (error instanceof functions.https.HttpsError) {
        throw error;
      }

      // Generic error
      throw new functions.https.HttpsError(
        'internal',
        error.message || 'Failed to release escrow'
      );
    }
  }
);
