# Quick Payment Reference Card

## Setup (One-Time)

```bash
# 1. Install
cd functions && npm install

# 2. Configure
firebase functions:config:set stripe.secret_key="sk_test_..."

# 3. Deploy
npm run build && firebase deploy --only functions

# 4. Setup webhook at https://dashboard.stripe.com/webhooks
# Use URL: https://[region]-[project].cloudfunctions.net/stripeWebhook
# Copy secret and run:
firebase functions:config:set stripe.webhook_secret="whsec_..."
firebase deploy --only functions:stripeWebhook
```

## Payment Flow (Happy Path)

```dart
// 1. CREATE PAYMENT INTENT
final result = await functions.httpsCallable('createPaymentIntent').call({
  'bidId': bid.id,
  'wishId': wish.id,
  'amount': 5000,  // $50.00 in cents
});
String clientSecret = result.data['clientSecret'];

// 2. INITIALIZE PAYMENT SHEET
await Stripe.instance.initPaymentSheet(
  paymentSheetParameters: SetupPaymentSheetParameters(
    paymentIntentClientSecret: clientSecret,
    merchantDisplayName: 'WishMarketplace',
  ),
);

// 3. PRESENT PAYMENT SHEET
await Stripe.instance.presentPaymentSheet();
// Payment captured automatically via webhook

// 4. BUYER CONFIRMS DELIVERY
await functions.httpsCallable('releaseEscrow').call({
  'transactionId': transaction.id,
  'reason': 'Service completed',
});
// Funds released to seller, payout created
```

## Refund Flow

```dart
// Full refund
await functions.httpsCallable('refundEscrow').call({
  'transactionId': transaction.id,
  'reason': 'Service not delivered',
});

// Partial refund
await functions.httpsCallable('refundEscrow').call({
  'transactionId': transaction.id,
  'refundAmount': 2500,  // $25.00
  'reason': 'Partial work completed',
});
```

## Dispute Flow

```dart
await functions.httpsCallable('disputeEscrow').call({
  'transactionId': transaction.id,
  'reason': 'Quality issues',
  'evidence': {
    'photos': ['url1', 'url2'],
    'messages': ['msg1'],
  },
});
// Escrow frozen, admin notified
```

## Test Cards

| Card Number          | Result              |
|---------------------|---------------------|
| 4242 4242 4242 4242 | Success             |
| 4000 0000 0000 0002 | Decline             |
| 4000 0025 0000 3155 | Requires 3DS        |

Use any future expiry, any CVC.

## Cloud Functions

| Function              | Purpose                    | Who Can Call    |
|----------------------|----------------------------|----------------|
| createPaymentIntent  | Start payment              | Buyer          |
| capturePayment       | Manual capture (backup)    | Buyer, Admin   |
| releaseEscrow        | Release to seller          | Buyer, Admin   |
| refundEscrow         | Refund to buyer            | Buyer, Seller, Admin |
| disputeEscrow        | File dispute               | Buyer, Seller  |
| stripeWebhook        | Process Stripe events      | Stripe (auto)  |

## Escrow Status Flow

```
PENDING → AUTHORIZED → FUNDED → RELEASED
                              ↘ REFUNDED
                              ↘ DISPUTED → (admin) → RELEASED/REFUNDED
```

## Database Collections

- **transactions**: All payment records
- **escrows**: Escrow state tracking
- **payouts**: Seller payment tracking
- **disputes**: Admin review queue

## Configuration

```typescript
// functions/src/config/stripe.config.ts
PLATFORM_FEE_PERCENT = 10        // 10% fee
DEFAULT_CURRENCY = 'usd'         // USD
MINIMUM_CHARGE_AMOUNT = 50       // $0.50
```

## Debugging

```bash
# View logs
firebase functions:log

# View specific function
firebase functions:log --only createPaymentIntent

# Tail logs
firebase functions:log --only stripeWebhook

# Check config
firebase functions:config:get
```

## Stripe Dashboard

- Payments: https://dashboard.stripe.com/test/payments
- Webhooks: https://dashboard.stripe.com/test/webhooks
- Logs: https://dashboard.stripe.com/test/logs

## Common Issues

**Webhook signature failed**
→ Check webhook secret matches Stripe dashboard

**Transaction not found**
→ Verify IDs, check Firestore for record

**Permission denied**
→ Check user authentication and role

**Amount too small**
→ Minimum is $0.50 (50 cents)

**Authorization expired**
→ Capture within 7 days of authorization

## File Locations

```
functions/src/
├── config/stripe.config.ts         # Configuration
├── types/payment.types.ts          # Type definitions
├── services/
│   ├── escrow.service.ts           # Core logic
│   └── webhook.service.ts          # Event processing
├── callable/
│   ├── createPaymentIntent.ts      # Create payment
│   ├── releaseEscrow.ts            # Release funds
│   ├── refundEscrow.ts             # Process refund
│   └── disputeEscrow.ts            # Handle dispute
└── http/
    └── stripeWebhook.ts            # Webhook endpoint
```

## Documentation

- **Setup**: `STRIPE_ESCROW_SETUP.md`
- **Frontend**: `STRIPE_FRONTEND_INTEGRATION.md`
- **API Ref**: `STRIPE_ESCROW_README.md`
- **Overview**: `PAYMENT_SYSTEM_OVERVIEW.md`

## Quick Links

- Main Docs: `/STRIPE_ESCROW_README.md`
- Setup Guide: `/STRIPE_ESCROW_SETUP.md`
- Functions Setup: `/functions/SETUP.md`
- This Reference: `/QUICK_PAYMENT_REFERENCE.md`
