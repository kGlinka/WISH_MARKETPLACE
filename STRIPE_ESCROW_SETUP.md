# Stripe Escrow Payment System - Setup Guide

## Overview

This marketplace uses a complete Stripe escrow payment system to securely handle payments between buyers and sellers. Funds are held in escrow until service/product delivery is confirmed, protecting both parties.

## Architecture

### Payment Flow

1. **Payment Intent Creation** (Authorization Hold)
   - Buyer initiates payment for accepted bid
   - Stripe creates PaymentIntent with `capture_method: 'manual'`
   - Funds are authorized but not captured (7-day hold window)
   - Transaction and escrow records created in Firestore

2. **Payment Capture** (Escrow Funded)
   - Buyer completes payment on frontend (Stripe Elements)
   - Payment is captured to platform account
   - Escrow status changes to `funded`
   - Funds held securely until release conditions met

3. **Escrow Release** (Payout to Seller)
   - Buyer confirms delivery/service completion
   - Funds released to seller (minus platform fee)
   - Payout record created for seller
   - Wish marked as completed

4. **Alternative Flows**
   - **Refund**: Buyer or seller can request refund (admin approval may be required)
   - **Dispute**: Either party can dispute, freezing funds for admin review
   - **Cancellation**: Uncaptured payments can be cancelled (releases authorization)

### Security Features

- **Webhook Signature Verification**: All Stripe webhooks verified before processing
- **Idempotency**: Payment operations use idempotency keys to prevent duplicates
- **Authorization Holds**: Funds authorized before capture (can be cancelled within 7 days)
- **Role-Based Access**: Permission checks on all payment operations
- **Atomic Transactions**: Firestore batch writes ensure data consistency

## Setup Instructions

### 1. Stripe Account Setup

1. Create a Stripe account at https://dashboard.stripe.com
2. Get your API keys from Dashboard > Developers > API keys
   - Use **test mode** keys during development (sk_test_...)
   - Switch to **live mode** for production (sk_live_...)

### 2. Configure Firebase Functions

Set Stripe API keys in Firebase Functions config:

```bash
# Set Stripe secret key
firebase functions:config:set stripe.secret_key="sk_test_your_key_here"

# Set webhook signing secret (get this after step 3)
firebase functions:config:set stripe.webhook_secret="whsec_your_secret_here"
```

Verify configuration:
```bash
firebase functions:config:get
```

### 3. Deploy Cloud Functions

```bash
cd functions
npm install
npm run build
firebase deploy --only functions
```

### 4. Configure Stripe Webhooks

1. Go to Stripe Dashboard > Developers > Webhooks
2. Click "Add endpoint"
3. Enter your webhook URL:
   ```
   https://[region]-[project-id].cloudfunctions.net/stripeWebhook
   ```
   Example: `https://us-central1-wishmarketplace.cloudfunctions.net/stripeWebhook`

4. Select events to listen for:
   - `payment_intent.succeeded`
   - `payment_intent.payment_failed`
   - `payment_intent.canceled`
   - `charge.succeeded`
   - `charge.refunded`
   - `charge.dispute.created`
   - `charge.dispute.closed`

5. Copy the webhook signing secret (`whsec_...`)
6. Update Firebase config with the secret:
   ```bash
   firebase functions:config:set stripe.webhook_secret="whsec_your_secret_here"
   ```
7. Redeploy functions:
   ```bash
   firebase deploy --only functions:stripeWebhook
   ```

### 5. Test the Integration

#### Test Payment Flow

1. Use Stripe test cards (https://stripe.com/docs/testing):
   - **Success**: 4242 4242 4242 4242
   - **Decline**: 4000 0000 0000 0002
   - **Requires authentication**: 4000 0025 0000 3155

2. Test the flow:
   ```
   Create Wish → Submit Bid → Accept Bid → Create Payment → Complete Payment → Release Escrow
   ```

3. Monitor in Stripe Dashboard > Payments (test mode)

#### Test Webhooks Locally

Use Stripe CLI for local testing:

```bash
# Install Stripe CLI
# https://stripe.com/docs/stripe-cli

# Forward webhooks to local functions
stripe listen --forward-to http://localhost:5001/[project-id]/[region]/stripeWebhook

# Trigger test events
stripe trigger payment_intent.succeeded
```

## Cloud Functions Reference

### Callable Functions

#### `createPaymentIntent`
Creates a payment intent with escrow for a bid.

**Input:**
```typescript
{
  bidId: string;
  wishId: string;
  amount: number;      // Amount in cents (minimum 50)
  currency?: string;   // Default: 'usd'
  description?: string;
}
```

**Output:**
```typescript
{
  success: boolean;
  clientSecret: string;      // For Stripe Elements
  paymentIntentId: string;
  transactionId: string;
  escrowId: string;
}
```

**Permissions:** Must be wish owner (buyer)

---

#### `capturePayment`
Manually captures an authorized payment (usually automatic via webhook).

**Input:**
```typescript
{
  paymentIntentId: string;
}
```

**Output:**
```typescript
{
  success: boolean;
  paymentIntentId: string;
  status: string;
  amount: number;
}
```

**Permissions:** Buyer or admin

---

#### `releaseEscrow`
Releases escrowed funds to seller.

**Input:**
```typescript
{
  transactionId: string;
  reason?: string;
}
```

**Output:**
```typescript
{
  success: boolean;
  escrowId: string;
  status: string;
  releasedAt: Date;
}
```

**Permissions:** Buyer or admin

**Effects:**
- Funds released to seller
- Payout record created
- Wish marked as completed
- Bid marked as won

---

#### `refundEscrow`
Refunds payment to buyer (full or partial).

**Input:**
```typescript
{
  transactionId: string;
  refundAmount?: number;  // Optional, defaults to full refund
  reason: string;
}
```

**Output:**
```typescript
{
  success: boolean;
  refundId: string;
  amount: number;
  status: string;
}
```

**Permissions:** Buyer, seller, or admin

**Effects:**
- Refund processed through Stripe
- Escrow marked as refunded
- Wish marked as cancelled (if full refund)
- Bid marked as cancelled

---

#### `disputeEscrow`
Marks escrow as disputed for admin review.

**Input:**
```typescript
{
  transactionId: string;
  reason: string;
  evidence?: Record<string, any>;
}
```

**Output:**
```typescript
{
  success: boolean;
  disputeId: string;
  escrowId: string;
  status: string;
}
```

**Permissions:** Buyer or seller

**Effects:**
- Escrow frozen (prevents automatic release)
- Dispute record created
- Admin notification sent
- Manual review required

---

### HTTP Endpoints

#### `stripeWebhook` (POST)
Receives and processes Stripe webhook events.

**URL:** `https://[region]-[project-id].cloudfunctions.net/stripeWebhook`

**Headers Required:**
- `stripe-signature`: Webhook signature for verification

**Events Handled:**
- `payment_intent.succeeded`: Updates escrow to authorized
- `payment_intent.payment_failed`: Marks payment as failed
- `charge.succeeded`: Updates escrow to funded
- `charge.refunded`: Processes refund
- `charge.dispute.created`: Marks escrow as disputed
- `charge.dispute.closed`: Resolves dispute based on outcome

## Database Schema

### Collections

#### `transactions`
```typescript
{
  id: string;
  userId: string;              // Buyer ID
  wishId: string;
  bidId: string;
  escrowId: string;
  type: 'escrowDeposit' | 'escrowRelease' | 'escrowRefund';
  status: 'pending' | 'processing' | 'completed' | 'failed' | 'cancelled' | 'disputed' | 'refunded';
  amount: number;              // Amount in cents
  fee: number;                 // Platform fee in cents
  netAmount: number;           // Amount after fees
  currency: string;
  paymentMethod: string;
  paymentIntentId: string;     // Stripe payment intent ID
  chargeId: string;            // Stripe charge ID
  receiptUrl: string;
  failureReason?: string;
  description: string;
  metadata: Record<string, any>;
  createdAt: Date;
  completedAt?: Date;
  cancelledAt?: Date;
  refundedAt?: Date;
}
```

#### `escrows`
```typescript
{
  id: string;
  transactionId: string;
  buyerId: string;
  sellerId: string;
  wishId: string;
  bidId: string;
  amount: number;
  status: 'pending' | 'authorized' | 'funded' | 'released' | 'refunded' | 'disputed' | 'cancelled';
  paymentIntentId: string;
  chargeId?: string;
  releaseConditions: string;
  fundedAt?: Date;
  releasedAt?: Date;
  refundedAt?: Date;
  disputedAt?: Date;
  disputeReason?: string;
  resolutionNotes?: string;
  createdAt: Date;
  updatedAt?: Date;
}
```

#### `payouts`
```typescript
{
  id: string;
  sellerId: string;
  amount: number;
  currency: string;
  status: 'pending' | 'processing' | 'paid' | 'failed';
  stripePayoutId?: string;
  transactionIds: string[];
  createdAt: Date;
  paidAt?: Date;
}
```

#### `disputes`
```typescript
{
  id: string;
  transactionId: string;
  escrowId: string;
  wishId: string;
  bidId: string;
  initiatedBy: string;         // User ID
  initiatorRole: 'buyer' | 'seller';
  buyerId: string;
  sellerId: string;
  amount: number;
  reason: string;
  evidence: Record<string, any>;
  status: 'open' | 'resolved' | 'closed';
  resolution?: string;
  resolvedBy?: string;         // Admin user ID
  createdAt: Date;
  resolvedAt?: Date;
}
```

## Platform Fee Configuration

Default platform fee is set to 10% in `/functions/src/config/stripe.config.ts`:

```typescript
export const PLATFORM_FEE_PERCENT = 10;
```

To change the fee percentage, update this constant and redeploy.

## Error Handling

All payment functions include comprehensive error handling:

1. **Input Validation**: All inputs validated before processing
2. **Permission Checks**: User authorization verified
3. **Stripe Error Handling**: Specific error types caught and logged
4. **Atomic Operations**: Firestore batch writes prevent partial updates
5. **Webhook Retry**: Failed webhooks logged for manual review

## Monitoring & Alerts

### Stripe Dashboard

Monitor in Stripe Dashboard:
- Payments > All payments
- Disputes > Open disputes
- Webhooks > Webhook logs

### Firebase Console

Monitor Cloud Functions:
- Functions > Logs
- Firestore > Data (transactions, escrows, disputes)

### Recommended Alerts

Set up alerts for:
- Failed payment captures
- Webhook processing failures
- High dispute rates
- Refund spikes
- Authorization holds approaching 7-day limit

## Testing Checklist

- [ ] Create payment intent with test card
- [ ] Complete payment successfully
- [ ] Release escrow funds
- [ ] Process full refund
- [ ] Process partial refund
- [ ] Create dispute
- [ ] Test failed payment
- [ ] Test webhook events
- [ ] Verify Firestore updates
- [ ] Check permission enforcement

## Production Checklist

- [ ] Switch to live Stripe API keys
- [ ] Update webhook endpoint to production URL
- [ ] Set production webhook secret
- [ ] Configure platform fee percentage
- [ ] Set up monitoring and alerts
- [ ] Test end-to-end flow in production
- [ ] Document payout schedule for sellers
- [ ] Configure dispute resolution process
- [ ] Set up customer support workflows

## Support & Troubleshooting

### Common Issues

**Webhook signature verification failed**
- Ensure webhook secret is correctly configured
- Check that rawBody is being passed to webhook handler
- Verify webhook endpoint URL is correct

**Payment intent not found**
- Check that transaction was created in Firestore
- Verify paymentIntentId is correct
- Ensure webhook events are being received

**Authorization hold expired**
- Captures must happen within 7 days of authorization
- Implement automated capture or notifications
- Consider shorter hold times for your use case

**Dispute handling**
- Respond to disputes within Stripe's timeline
- Collect and submit evidence promptly
- Document all seller-buyer communications

### Getting Help

- Stripe Documentation: https://stripe.com/docs
- Stripe Support: https://support.stripe.com
- Firebase Documentation: https://firebase.google.com/docs

## Security Best Practices

1. **Never log sensitive data**: Don't log full card numbers or API keys
2. **Use environment variables**: Store secrets in Firebase config, not code
3. **Verify webhook signatures**: Always verify before processing
4. **Implement rate limiting**: Prevent abuse of payment endpoints
5. **Monitor for fraud**: Watch for suspicious payment patterns
6. **Use HTTPS only**: Ensure all endpoints use HTTPS
7. **Audit regularly**: Review transaction logs and access patterns

## Compliance Notes

- **PCI Compliance**: Never handle raw card data (use Stripe Elements)
- **1099-K Reporting**: Track seller payouts for tax reporting
- **Regional Regulations**: Ensure compliance with local payment laws
- **Data Retention**: Follow GDPR/CCPA requirements for payment data
