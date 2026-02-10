/**
 * Stripe configuration and initialization
 *
 * This module initializes the Stripe SDK with proper error handling
 * and environment-specific configuration.
 */

import Stripe from 'stripe';
import * as functions from 'firebase-functions';

// Get Stripe secret key from Firebase Functions config
// Set this using: firebase functions:config:set stripe.secret_key="sk_test_..."
const stripeSecretKey = functions.config().stripe?.secret_key;

if (!stripeSecretKey) {
  console.warn(
    'Stripe secret key not configured. Set it using: ' +
    'firebase functions:config:set stripe.secret_key="sk_test_..."'
  );
}

// Initialize Stripe with API version and typescript support
export const stripe = new Stripe(stripeSecretKey || 'sk_test_placeholder', {
  apiVersion: '2024-12-18.acacia',
  typescript: true,
  // Add telemetry to help Stripe identify integration issues
  appInfo: {
    name: 'WishMarketplace',
    version: '1.0.0',
  },
});

// Webhook signing secret for verifying webhook signatures
// Set this using: firebase functions:config:set stripe.webhook_secret="whsec_..."
export const webhookSecret = functions.config().stripe?.webhook_secret || '';

// Platform fee percentage (e.g., 10 = 10%)
export const PLATFORM_FEE_PERCENT = 10;

// Stripe authorization hold time limit (7 days in milliseconds)
export const AUTHORIZATION_HOLD_LIMIT = 7 * 24 * 60 * 60 * 1000;

// Default currency
export const DEFAULT_CURRENCY = 'usd';

// Minimum charge amount in cents (Stripe requirement: $0.50 minimum)
export const MINIMUM_CHARGE_AMOUNT = 50;

/**
 * Calculate platform fee based on amount
 * @param amount Amount in cents
 * @returns Platform fee in cents
 */
export function calculatePlatformFee(amount: number): number {
  return Math.floor((amount * PLATFORM_FEE_PERCENT) / 100);
}

/**
 * Validate amount is above Stripe minimum
 * @param amount Amount in cents
 * @returns true if valid
 */
export function validateAmount(amount: number): boolean {
  return amount >= MINIMUM_CHARGE_AMOUNT;
}
