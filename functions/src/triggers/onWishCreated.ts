import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import { sendNotification } from '../utils/notifications';

export const onWishCreated = functions.firestore
  .document('wishes/{wishId}')
  .onCreate(async (snapshot, context) => {
    const wish = snapshot.data();
    const { wishId } = context.params;

    try {
      // Get nearby providers based on wish category and location
      const providersSnapshot = await admin
        .firestore()
        .collection('users')
        .where('role', 'in', ['provider', 'both'])
        .where('providerInfo.categories', 'array-contains', wish.category)
        .where('providerInfo.verificationStatus', '==', 'verified')
        .limit(50)
        .get();

      // Send notifications to matching providers
      const notificationPromises = providersSnapshot.docs.map((providerDoc) => {
        return sendNotification({
          userId: providerDoc.id,
          type: 'new_wish_nearby',
          title: 'New Wish Available!',
          body: `${wish.title} - Budget: $${wish.budget.min}-$${wish.budget.max}`,
          data: {
            wishId,
            category: wish.category,
            deepLink: `/wishes/${wishId}`,
          },
        });
      });

      await Promise.all(notificationPromises);

      console.log(
        `Notified ${providersSnapshot.size} providers about new wish ${wishId}`
      );
    } catch (error) {
      console.error('Error in onWishCreated:', error);
      throw error;
    }
  });
