import * as functions from 'firebase-functions';
import { stripe, webhookSecret } from '../config/stripe.config';
import { processWebhookEvent } from '../services/webhook.service';
import Stripe from 'stripe';

/**
 * Stripe Webhook Handler
 *
 * This HTTP endpoint receives and processes webhook events from Stripe.
 *
 * CRITICAL SECURITY REQUIREMENTS:
 * 1. Always verify webhook signature before processing
 * 2. Return 200 status quickly (process asynchronously if needed)
 * 3. Handle events idempotently (same event may arrive multiple times)
 * 4. Log all events with sufficient context for debugging
 *
 * Setup Instructions:
 * 1. Deploy this function
 * 2. In Stripe Dashboard, add webhook endpoint: https://your-region-your-project.cloudfunctions.net/stripeWebhook
 * 3. Select events to listen for (see list below)
 * 4. Copy webhook signing secret and set: firebase functions:config:set stripe.webhook_secret="whsec_..."
 *
 * Events handled:
 * - payment_intent.succeeded: Payment authorized successfully
 * - payment_intent.payment_failed: Payment authorization failed
 * - payment_intent.canceled: Payment intent canceled
 * - charge.succeeded: Funds captured successfully
 * - charge.refunded: Refund processed
 * - charge.dispute.created: Dispute filed by customer
 * - charge.dispute.closed: Dispute resolved
 */
export const stripeWebhook = functions.https.onRequest(async (req, res) => {
  // Only accept POST requests
  if (req.method !== 'POST') {
    console.warn(`Webhook received ${req.method} request, expected POST`);
    res.status(405).send('Method Not Allowed');
    return;
  }

  const sig = req.headers['stripe-signature'];

  if (!sig) {
    console.error('Missing stripe-signature header');
    res.status(400).send('Missing signature');
    return;
  }

  let event: Stripe.Event;

  try {
    // Verify webhook signature
    // This ensures the event actually came from Stripe and hasn't been tampered with
    event = stripe.webhooks.constructEvent(
      req.rawBody,
      sig,
      webhookSecret
    );
  } catch (error: any) {
    console.error('Webhook signature verification failed:', error.message);
    res.status(400).send(`Webhook Error: ${error.message}`);
    return;
  }

  // Log event receipt
  console.log(`Webhook received: ${event.type} [${event.id}]`);

  try {
    // Process the event
    await processWebhookEvent(event);

    // Return 200 success response quickly
    // Stripe expects a response within 5 seconds
    res.status(200).json({ received: true, eventId: event.id });
  } catch (error: any) {
    console.error(`Error processing webhook ${event.type}:`, error);

    // Still return 200 to prevent Stripe from retrying
    // Log the error for manual review
    res.status(200).json({
      received: true,
      eventId: event.id,
      error: 'Processing failed - logged for review',
    });

    // TODO: Send alert to admin about webhook processing failure
  }
});

/**
 * Test webhook handler (for development/testing)
 *
 * This endpoint can be used to manually trigger webhook event processing
 * for testing purposes. Should be disabled or protected in production.
 */
export const testWebhook = functions.https.onCall(
  async (data: { eventType: string; paymentIntentId?: string }, context) => {
    // Only allow in development or for admins
    if (!context.auth) {
      throw new functions.https.HttpsError(
        'unauthenticated',
        'Authentication required'
      );
    }

    // Check if user is admin
    const admin = require('firebase-admin');
    const db = admin.firestore();
    const userDoc = await db.collection('users').doc(context.auth.uid).get();

    if (userDoc.data()?.role !== 'admin') {
      throw new functions.https.HttpsError(
        'permission-denied',
        'Admin access required'
      );
    }

    try {
      let event: Stripe.Event;

      // Create mock event based on type
      switch (data.eventType) {
        case 'payment_intent.succeeded':
          if (!data.paymentIntentId) {
            throw new Error('paymentIntentId required for this event type');
          }
          const pi = await stripe.paymentIntents.retrieve(data.paymentIntentId);
          event = {
            id: `evt_test_${Date.now()}`,
            type: 'payment_intent.succeeded',
            data: { object: pi },
            created: Math.floor(Date.now() / 1000),
          } as any;
          break;

        default:
          throw new Error(`Unsupported test event type: ${data.eventType}`);
      }

      await processWebhookEvent(event);

      return {
        success: true,
        eventId: event.id,
        message: 'Test webhook processed successfully',
      };
    } catch (error: any) {
      console.error('Error processing test webhook:', error);
      throw new functions.https.HttpsError(
        'internal',
        error.message || 'Failed to process test webhook'
      );
    }
  }
);
