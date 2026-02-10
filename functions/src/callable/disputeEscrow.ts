import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { disputeEscrow as disputeEscrowService } from '../services/escrow.service';
import { DisputeEscrowData } from '../types/payment.types';

const db = admin.firestore();

/**
 * Marks an escrow as disputed
 *
 * This function:
 * 1. Validates the transaction exists and can be disputed
 * 2. Verifies the caller has permission (buyer or seller)
 * 3. Marks escrow as disputed (freezes any automatic release)
 * 4. Flags for manual admin review
 *
 * Should be called when there's a disagreement about service/product quality
 */
export const disputeEscrow = functions.https.onCall(
  async (data: DisputeEscrowData, context) => {
    // Authentication check
    if (!context.auth) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'Authentication required to dispute escrow'
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
        'Dispute reason is required'
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

      // Permission check: Buyer or seller can dispute
      const isBuyer = escrow?.buyerId === userId;
      const isSeller = escrow?.sellerId === userId;

      if (!isBuyer && !isSeller) {
        throw new functions.https.HttpsError(
          'permission-denied',
          'Only the buyer or seller can dispute escrow'
        );
      }

      // Validate escrow status
      if (escrow?.status !== 'funded') {
        throw new functions.https.HttpsError(
          'failed-precondition',
          `Cannot dispute escrow with status: ${escrow?.status}`
        );
      }

      // Mark escrow as disputed
      const result = await disputeEscrowService(data.transactionId, data.reason);

      // Create dispute record for admin review
      const disputeRef = db.collection('disputes').doc();
      await disputeRef.set({
        id: disputeRef.id,
        transactionId: data.transactionId,
        escrowId: transaction.escrowId,
        wishId: escrow.wishId,
        bidId: escrow.bidId,
        initiatedBy: userId,
        initiatorRole: isBuyer ? 'buyer' : 'seller',
        buyerId: escrow.buyerId,
        sellerId: escrow.sellerId,
        amount: escrow.amount,
        reason: data.reason,
        evidence: data.evidence || {},
        status: 'open',
        createdAt: new Date(),
      });

      // TODO: Send notifications to both parties and admin
      // TODO: Create admin task for dispute resolution

      return {
        success: true,
        disputeId: disputeRef.id,
        escrowId: result.id,
        status: result.status,
        message: 'Escrow marked as disputed. Admin will review.',
      };
    } catch (error: any) {
      console.error('Error disputing escrow:', error);

      // Re-throw HttpsError as-is
      if (error instanceof functions.https.HttpsError) {
        throw error;
      }

      // Generic error
      throw new functions.https.HttpsError(
        'internal',
        error.message || 'Failed to dispute escrow'
      );
    }
  }
);
