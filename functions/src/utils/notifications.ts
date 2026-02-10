import * as admin from 'firebase-admin';

export interface NotificationData {
  userId: string;
  type: string;
  title: string;
  body: string;
  data?: Record<string, any>;
}

export async function sendNotification(
  notification: NotificationData
): Promise<void> {
  try {
    // Get user's FCM token
    const userDoc = await admin
      .firestore()
      .collection('users')
      .doc(notification.userId)
      .get();

    if (!userDoc.exists) {
      console.error(`User ${notification.userId} not found`);
      return;
    }

    const userData = userDoc.data();
    const fcmToken = userData?.fcmToken;

    if (!fcmToken) {
      console.log(`No FCM token for user ${notification.userId}`);
      return;
    }

    // Send FCM notification
    const message: admin.messaging.Message = {
      notification: {
        title: notification.title,
        body: notification.body,
      },
      data: notification.data || {},
      token: fcmToken,
    };

    await admin.messaging().send(message);

    // Store notification in Firestore
    await admin
      .firestore()
      .collection('users')
      .doc(notification.userId)
      .collection('notifications')
      .add({
        type: notification.type,
        title: notification.title,
        body: notification.body,
        data: notification.data || {},
        isRead: false,
        timestamp: admin.firestore.FieldValue.serverTimestamp(),
        expiresAt: admin.firestore.Timestamp.fromDate(
          new Date(Date.now() + 30 * 24 * 60 * 60 * 1000) // 30 days
        ),
      });

    console.log(`Notification sent to user ${notification.userId}`);
  } catch (error) {
    console.error('Error sending notification:', error);
    throw error;
  }
}
