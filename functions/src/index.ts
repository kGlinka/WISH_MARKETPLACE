import * as admin from 'firebase-admin';

// Initialize Firebase Admin
admin.initializeApp();

// Export Cloud Functions

// Triggers
export * from './triggers/onWishCreated';
export * from './triggers/onBidSubmitted';

// Callable Functions - Bidding
export * from './callable/rankBids';

// Callable Functions - Payments & Escrow
export * from './callable/createPaymentIntent';
export * from './callable/capturePayment';
export * from './callable/releaseEscrow';
export * from './callable/refundEscrow';
export * from './callable/disputeEscrow';

// HTTP Functions - Webhooks
export * from './http/stripeWebhook';

// Scheduled Functions
// export * from './scheduled/cleanupExpiredWishes';

// Utility exports for shared functionality
export { sendNotification } from './utils/notifications';
