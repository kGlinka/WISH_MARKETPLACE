import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { sendNotification } from '../utils/notifications';

export const onBidSubmitted = functions.firestore
  .document('wishes/{wishId}/bids/{bidId}')
  .onCreate(async (snapshot, context) => {
    const bid = snapshot.data();
    const { wishId, bidId } = context.params;

    try {
      // Get wish to find creator
      const wishDoc = await admin
        .firestore()
        .collection('wishes')
        .doc(wishId)
        .get();

      if (!wishDoc.exists) {
        console.error(`Wish ${wishId} not found`);
        return;
      }

      const wish = wishDoc.data();

      // Increment bid count
      await wishDoc.ref.update({
        bidCount: admin.firestore.FieldValue.increment(1),
        updatedAt: admin.firestore.FieldValue.serverTimestamp(),
      });

      // Send notification to wish creator
      await sendNotification({
        userId: wish!.userId,
        type: 'new_bid',
        title: 'New Bid Received!',
        body: `${bid.providerName} bid $${bid.price} for "${wish!.title}"`,
        data: {
          wishId,
          bidId,
          deepLink: `/wishes/${wishId}`,
        },
      });

      console.log(`Notified user ${wish!.userId} about new bid ${bidId}`);
    } catch (error) {
      console.error('Error in onBidSubmitted:', error);
      throw error;
    }
  });
