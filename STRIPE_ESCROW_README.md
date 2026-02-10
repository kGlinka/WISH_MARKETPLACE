# Stripe Escrow Payment System

A production-ready escrow payment system built with Stripe for marketplace applications. This implementation provides secure payment handling with funds held in escrow until service/product delivery is confirmed.

## Features

### Core Functionality
- **Authorization Holds**: Authorize payments before capturing funds (7-day hold window)
- **Manual Capture**: Funds captured only when ready, not automatically
- **Escrow Management**: Hold funds securely until release conditions met
- **Release on Confirmation**: Buyer confirms delivery, funds released to seller
- **Refund Handling**: Full and partial refunds with Stripe integration
- **Dispute Resolution**: Freeze payments during disputes for admin review
- **Webhook Processing**: Real-time payment status updates from Stripe
- **Platform Fees**: Automatic calculation and collection of marketplace fees

### Security Features
- Webhook signature verification
- Idempotent payment operations
- Role-based access control
- Atomic database transactions
- PCI-compliant (no raw card data handling)
- Comprehensive error handling
- Request validation and sanitization

### Payment Flow States

```
BUYER                           ESCROW STATUS              SELLER
---------------------------------------------------------------------
1. Accepts bid
2. Creates payment              → PENDING
3. Completes payment            → AUTHORIZED
4. Payment captured             → FUNDED                   Notified
5. Confirms delivery            → RELEASED              → Gets payout

Alternative flows:
- Request refund                → REFUNDED              ← Gets notification
- File dispute                  → DISPUTED              ← Gets notification
- Cancel before capture         → CANCELLED
```

## File Structure

```
functions/src/
├── config/
│   └── stripe.config.ts         # Stripe initialization & constants
├── types/
│   └── payment.types.ts         # TypeScript type definitions
├── services/
│   ├── escrow.service.ts        # Core escrow logic
│   └── webhook.service.ts       # Webhook event processing
├── callable/
│   ├── createPaymentIntent.ts   # Create escrow payment
│   ├── capturePayment.ts        # Capture authorized payment
│   ├── releaseEscrow.ts         # Release funds to seller
│   ├── refundEscrow.ts          # Process refunds
│   └── disputeEscrow.ts         # Handle disputes
├── http/
│   └── stripeWebhook.ts         # Webhook endpoint
└── index.ts                     # Function exports
```

## Quick Start

### 1. Install Dependencies

```bash
cd functions
npm install
```

Required packages (already in package.json):
- `stripe`: Stripe Node.js SDK
- `firebase-admin`: Firebase Admin SDK
- `firebase-functions`: Cloud Functions SDK

### 2. Configure Stripe

```bash
# Set Stripe secret key
firebase functions:config:set stripe.secret_key="sk_test_your_key"

# Set webhook secret (after creating webhook endpoint)
firebase functions:config:set stripe.webhook_secret="whsec_your_secret"
```

### 3. Deploy Functions

```bash
npm run build
firebase deploy --only functions
```

### 4. Configure Webhook in Stripe

1. Go to Stripe Dashboard → Developers → Webhooks
2. Add endpoint: `https://[region]-[project].cloudfunctions.net/stripeWebhook`
3. Select events:
   - `payment_intent.succeeded`
   - `payment_intent.payment_failed`
   - `payment_intent.canceled`
   - `charge.succeeded`
   - `charge.refunded`
   - `charge.dispute.created`
   - `charge.dispute.closed`
4. Copy webhook secret and update config

## API Reference

### createPaymentIntent

Creates a payment intent with escrow for a bid.

```typescript
// Input
{
  bidId: string;
  wishId: string;
  amount: number;      // In cents (min: 50)
  currency?: string;   // Default: 'usd'
  description?: string;
}

// Output
{
  success: boolean;
  clientSecret: string;      // For Stripe Elements
  paymentIntentId: string;
  transactionId: string;
  escrowId: string;
}
```

**Example:**
```dart
final result = await functions.httpsCallable('createPaymentIntent').call({
  'bidId': 'bid_123',
  'wishId': 'wish_456',
  'amount': 5000, // $50.00
  'description': 'Payment for web design',
});
```

### capturePayment

Manually captures an authorized payment.

```typescript
// Input
{
  paymentIntentId: string;
}

// Output
{
  success: boolean;
  paymentIntentId: string;
  status: string;
  amount: number;
}
```

**Note:** Usually automatic via webhook. Use this for manual recovery.

### releaseEscrow

Releases funds to seller after delivery confirmation.

```typescript
// Input
{
  transactionId: string;
  reason?: string;
}

// Output
{
  success: boolean;
  escrowId: string;
  status: string;
  releasedAt: Date;
}
```

**Example:**
```dart
await functions.httpsCallable('releaseEscrow').call({
  'transactionId': 'txn_789',
  'reason': 'Service completed satisfactorily',
});
```

**Side Effects:**
- Escrow status → `released`
- Payout record created
- Wish status → `completed`
- Bid status → `won`

### refundEscrow

Processes full or partial refund.

```typescript
// Input
{
  transactionId: string;
  refundAmount?: number;  // Optional, defaults to full
  reason: string;
}

// Output
{
  success: boolean;
  refundId: string;
  amount: number;
  status: string;
}
```

**Example:**
```dart
// Full refund
await functions.httpsCallable('refundEscrow').call({
  'transactionId': 'txn_789',
  'reason': 'Service not delivered',
});

// Partial refund
await functions.httpsCallable('refundEscrow').call({
  'transactionId': 'txn_789',
  'refundAmount': 2500, // $25.00 of $50.00
  'reason': 'Partial work completed',
});
```

### disputeEscrow

Marks escrow as disputed for admin review.

```typescript
// Input
{
  transactionId: string;
  reason: string;
  evidence?: Record<string, any>;
}

// Output
{
  success: boolean;
  disputeId: string;
  escrowId: string;
  status: string;
}
```

**Example:**
```dart
await functions.httpsCallable('disputeEscrow').call({
  'transactionId': 'txn_789',
  'reason': 'Work quality does not match expectations',
  'evidence': {
    'screenshots': ['url1', 'url2'],
    'messages': ['msg1', 'msg2'],
  },
});
```

## Database Schema

### transactions

```typescript
{
  id: string;
  userId: string;              // Buyer ID
  wishId: string;
  bidId: string;
  escrowId: string;
  type: TransactionType;
  status: TransactionStatus;
  amount: number;              // Cents
  fee: number;                 // Platform fee
  netAmount: number;           // After fees
  currency: string;
  paymentMethod: string;
  paymentIntentId: string;
  chargeId?: string;
  receiptUrl?: string;
  failureReason?: string;
  description: string;
  metadata: object;
  createdAt: Date;
  completedAt?: Date;
  cancelledAt?: Date;
  refundedAt?: Date;
}
```

### escrows

```typescript
{
  id: string;
  transactionId: string;
  buyerId: string;
  sellerId: string;
  wishId: string;
  bidId: string;
  amount: number;
  status: EscrowStatus;
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

### payouts

```typescript
{
  id: string;
  sellerId: string;
  amount: number;
  currency: string;
  status: string;
  transactionIds: string[];
  createdAt: Date;
  paidAt?: Date;
}
```

### disputes

```typescript
{
  id: string;
  transactionId: string;
  escrowId: string;
  wishId: string;
  bidId: string;
  initiatedBy: string;
  initiatorRole: 'buyer' | 'seller';
  buyerId: string;
  sellerId: string;
  amount: number;
  reason: string;
  evidence: object;
  status: 'open' | 'resolved' | 'closed';
  resolution?: string;
  resolvedBy?: string;
  createdAt: Date;
  resolvedAt?: Date;
}
```

## Configuration

### Platform Fee

Adjust in `/functions/src/config/stripe.config.ts`:

```typescript
export const PLATFORM_FEE_PERCENT = 10; // 10%
```

### Currency

Default currency is USD. To change:

```typescript
export const DEFAULT_CURRENCY = 'eur'; // or 'gbp', 'cad', etc.
```

### Minimum Charge

Stripe enforces minimum charges (e.g., $0.50 for USD):

```typescript
export const MINIMUM_CHARGE_AMOUNT = 50; // 50 cents
```

## Testing

### Test Cards

| Card                | Scenario              |
|--------------------|-----------------------|
| 4242 4242 4242 4242 | Success              |
| 4000 0000 0000 0002 | Decline              |
| 4000 0025 0000 3155 | Requires auth (3DS)  |
| 4000 0000 0000 9995 | Insufficient funds   |

Any future date, any 3-digit CVC.

### Test Flow

```bash
# 1. Create payment intent
curl -X POST https://your-function-url/createPaymentIntent \
  -H "Content-Type: application/json" \
  -d '{"bidId":"test","wishId":"test","amount":5000}'

# 2. Complete payment in frontend (use test card)

# 3. Release escrow
curl -X POST https://your-function-url/releaseEscrow \
  -H "Content-Type: application/json" \
  -d '{"transactionId":"txn_123"}'
```

### Local Testing with Stripe CLI

```bash
# Install Stripe CLI
brew install stripe/stripe-cli/stripe

# Login
stripe login

# Forward webhooks to local functions
stripe listen --forward-to http://localhost:5001/project/region/stripeWebhook

# Trigger test events
stripe trigger payment_intent.succeeded
stripe trigger charge.refunded
```

## Monitoring

### Stripe Dashboard

Monitor at https://dashboard.stripe.com:
- Payments → All payments
- Disputes → Open disputes
- Webhooks → Webhook logs

### Firebase Console

- Functions → Logs (Cloud Functions logs)
- Firestore → Data (Database records)

### Key Metrics

Monitor:
- Payment success rate
- Average time in escrow
- Refund rate
- Dispute rate
- Webhook failure rate

## Error Handling

All functions include comprehensive error handling:

```typescript
try {
  // Payment operation
} catch (error) {
  if (error instanceof functions.https.HttpsError) {
    // Known error - rethrow
    throw error;
  } else if (error.type) {
    // Stripe error
    throw new functions.https.HttpsError('internal', error.message);
  } else {
    // Unknown error
    throw new functions.https.HttpsError('internal', 'Operation failed');
  }
}
```

### Common Errors

| Error Code           | Meaning                          | Solution                        |
|---------------------|----------------------------------|---------------------------------|
| `unauthenticated`   | User not logged in               | Require authentication          |
| `permission-denied` | Insufficient permissions         | Check user role                 |
| `invalid-argument`  | Missing/invalid parameters       | Validate input                  |
| `failed-precondition` | Invalid state for operation    | Check escrow status             |
| `not-found`         | Resource doesn't exist           | Verify IDs                      |

## Security Best Practices

1. **Never log sensitive data**: Don't log card numbers or full API keys
2. **Verify webhook signatures**: Always verify before processing
3. **Use idempotency keys**: Prevent duplicate charges
4. **Validate amounts**: Server-side validation prevents tampering
5. **Role-based access**: Check permissions on all operations
6. **Use HTTPS**: All endpoints must use HTTPS
7. **Monitor for fraud**: Watch for suspicious patterns

## Production Checklist

- [ ] Switch to live Stripe API keys
- [ ] Update webhook endpoint URL
- [ ] Configure webhook signing secret
- [ ] Set platform fee percentage
- [ ] Test full payment flow
- [ ] Configure monitoring alerts
- [ ] Document payout schedule
- [ ] Set up dispute resolution process
- [ ] Train support team
- [ ] Review error handling
- [ ] Load test payment endpoints
- [ ] Verify HTTPS enforcement

## Compliance

### PCI Compliance
- Never handle raw card data
- Use Stripe Elements for card input
- Store only Stripe IDs, not card details

### Tax Reporting
- Track seller earnings for 1099-K reporting
- Implement payout records
- Maintain transaction history

### Regional Regulations
- Verify compliance with local payment laws
- Implement required disclosures
- Follow regional refund policies

## Support

### Documentation
- Stripe Docs: https://stripe.com/docs
- Firebase Docs: https://firebase.google.com/docs

### Common Issues

**Q: Webhook signature verification fails**
A: Ensure webhook secret is correctly set and rawBody is passed to verification.

**Q: Payment authorized but not captured**
A: Check webhook events are being received. Manually capture using `capturePayment`.

**Q: Authorization hold expired**
A: Captures must happen within 7 days. Implement auto-capture or notifications.

**Q: Refund failed**
A: Verify charge ID exists and amount doesn't exceed original charge.

## License

This implementation is part of the WishMarketplace project.

## Contributing

When contributing to the payment system:
1. Never commit API keys or secrets
2. Test all changes with Stripe test mode
3. Update documentation for API changes
4. Add tests for new functionality
5. Follow existing code patterns
