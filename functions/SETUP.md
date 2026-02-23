# Cloud Functions Setup for Stripe Escrow System

## Initial Setup

### 1. Install Dependencies

```bash
cd functions
npm install
```

This will install:
- `stripe` - Stripe Node.js SDK
- `firebase-admin` - Firebase Admin SDK
- `firebase-functions` - Cloud Functions SDK
- TypeScript and development dependencies

### 2. Configure Stripe API Keys

```bash
# For testing (get from https://dashboard.stripe.com/test/apikeys)
firebase functions:config:set stripe.secret_key="sk_test_your_key_here"

# Webhook secret (set after creating webhook endpoint in step 4)
firebase functions:config:set stripe.webhook_secret="whsec_your_secret_here"
```

Verify configuration:
```bash
firebase functions:config:get
```

Should output:
```json
{
  "stripe": {
    "secret_key": "sk_test_...",
    "webhook_secret": "whsec_..."
  }
}
```

### 3. Build and Deploy

```bash
# Build TypeScript
npm run build

# Deploy all functions
firebase deploy --only functions

# Or deploy specific function
firebase deploy --only functions:createPaymentIntent
```

### 4. Configure Stripe Webhook

After deployment, set up webhook in Stripe Dashboard:

1. Go to https://dashboard.stripe.com/test/webhooks
2. Click "Add endpoint"
3. Enter webhook URL (from deployment output):
   ```
   https://[region]-[project-id].cloudfunctions.net/stripeWebhook
   ```
   Example: `https://us-central1-wishmarketplace.cloudfunctions.net/stripeWebhook`

4. Select events to listen for:
   - ✅ `payment_intent.succeeded`
   - ✅ `payment_intent.payment_failed`
   - ✅ `payment_intent.canceled`
   - ✅ `charge.succeeded`
   - ✅ `charge.refunded`
   - ✅ `charge.dispute.created`
   - ✅ `charge.dispute.closed`

5. Click "Add endpoint"

6. Copy the signing secret (whsec_...)

7. Update Firebase config:
   ```bash
   firebase functions:config:set stripe.webhook_secret="whsec_your_secret_here"
   ```

8. Redeploy webhook function:
   ```bash
   firebase deploy --only functions:stripeWebhook
   ```

## Verification

### Check Deployed Functions

```bash
firebase functions:list
```

Should show:
- `createPaymentIntent`
- `capturePayment`
- `releaseEscrow`
- `refundEscrow`
- `disputeEscrow`
- `stripeWebhook`
- `testWebhook`

### Test Payment Flow

1. Call `createPaymentIntent`:
```bash
# Using Firebase CLI
firebase functions:call createPaymentIntent --data '{
  "bidId": "test_bid",
  "wishId": "test_wish",
  "amount": 5000
}'
```

2. Check Stripe Dashboard for PaymentIntent

3. Complete payment using test card: `4242 4242 4242 4242`

4. Verify webhook events in Stripe Dashboard

### Check Logs

```bash
# View all logs
firebase functions:log

# View specific function logs
firebase functions:log --only createPaymentIntent

# Tail logs in real-time
firebase functions:log --only stripeWebhook
```

## Troubleshooting

### Build Errors

If `npm run build` fails:

```bash
# Clean and reinstall
rm -rf node_modules package-lock.json
npm install

# Try building again
npm run build
```

### Deployment Errors

**Error: Missing configuration**
```bash
firebase functions:config:get
# Verify Stripe keys are set
```

**Error: Permission denied**
```bash
firebase login
firebase use --add  # Select your project
```

**Error: Function timeout**
- Increase timeout in function definition
- Check for infinite loops
- Verify database queries are efficient

### Webhook Errors

**Signature verification failed**
- Verify webhook secret is correctly configured
- Check Stripe Dashboard for webhook signing secret
- Ensure it matches Firebase config

**Webhook not receiving events**
- Verify webhook URL is correct
- Check Stripe Dashboard webhook logs
- Ensure function is deployed
- Check function logs for errors

### Runtime Errors

**Stripe API error**
- Verify API key is valid
- Check Stripe Dashboard for API logs
- Ensure test/live mode matches

**Transaction not found**
- Verify transaction was created
- Check Firestore for transaction document
- Ensure IDs are correct

**Permission denied**
- Verify user is authenticated
- Check user role in Firestore
- Verify permission logic in function

## Local Development

### Run Functions Locally

```bash
# Install Firebase emulators
firebase init emulators

# Start emulators
npm run serve

# Functions will be available at:
# http://localhost:5001/[project-id]/[region]/[function-name]
```

### Test Webhooks Locally

```bash
# Install Stripe CLI
# Windows: scoop install stripe
# Mac: brew install stripe/stripe-cli/stripe
# Linux: See https://stripe.com/docs/stripe-cli

# Login to Stripe
stripe login

# Forward webhooks to local emulator
stripe listen --forward-to http://localhost:5001/[project-id]/[region]/stripeWebhook

# In another terminal, trigger test events
stripe trigger payment_intent.succeeded
stripe trigger charge.refunded
```

## Production Deployment

### Switch to Live Mode

1. Get live API keys from https://dashboard.stripe.com/apikeys

2. Update configuration:
```bash
firebase functions:config:set stripe.secret_key="sk_live_your_live_key"
```

3. Create live webhook:
   - Go to https://dashboard.stripe.com/webhooks
   - Add endpoint with production URL
   - Copy live webhook secret
   - Update config:
   ```bash
   firebase functions:config:set stripe.webhook_secret="whsec_live_secret"
   ```

4. Deploy to production:
```bash
npm run build
firebase deploy --only functions
```

5. Test with small real transaction

### Production Checklist

- [ ] Live Stripe API key configured
- [ ] Live webhook endpoint created
- [ ] Live webhook secret configured
- [ ] All functions deployed
- [ ] Webhook events verified
- [ ] Test transaction completed
- [ ] Error alerting configured
- [ ] Logs monitoring set up
- [ ] Customer support trained
- [ ] Refund policy documented

## Monitoring

### View Metrics

Firebase Console:
- Functions → Dashboard
- View invocations, errors, execution time

Stripe Dashboard:
- Payments → Overview
- Webhooks → Events
- Disputes → All disputes

### Set Up Alerts

Firebase Console:
- Functions → [function] → Metrics → Create Alert
- Set up alerts for error rate, execution time

Stripe Dashboard:
- Developers → Webhooks → [endpoint] → Settings
- Enable email notifications for failures

## Support

### Documentation
- Main README: `../STRIPE_ESCROW_README.md`
- Setup Guide: `../STRIPE_ESCROW_SETUP.md`
- Frontend Guide: `../STRIPE_FRONTEND_INTEGRATION.md`

### Resources
- Stripe Docs: https://stripe.com/docs
- Firebase Functions: https://firebase.google.com/docs/functions
- Stripe Test Cards: https://stripe.com/docs/testing

### Getting Help
- Stripe Support: https://support.stripe.com
- Firebase Support: https://firebase.google.com/support
- Check function logs: `firebase functions:log`
