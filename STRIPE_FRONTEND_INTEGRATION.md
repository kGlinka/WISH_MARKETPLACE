# Stripe Frontend Integration Guide

## Overview

This guide shows how to integrate the Stripe escrow payment system into your Flutter frontend using the `flutter_stripe` package.

## Prerequisites

Add to `pubspec.yaml`:
```yaml
dependencies:
  flutter_stripe: ^10.0.0
  cloud_functions: ^4.5.0
```

## Setup

### 1. Initialize Stripe

Create `lib/core/services/stripe_service.dart`:

```dart
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  static const String _publishableKey = 'pk_test_your_publishable_key_here';

  static Future<void> initialize() async {
    Stripe.publishableKey = _publishableKey;
    // Optional: Set merchant display name
    Stripe.merchantIdentifier = 'WishMarketplace';
  }
}
```

### 2. Initialize in main.dart

```dart
import 'package:flutter/material.dart';
import 'core/services/stripe_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Stripe
  await StripeService.initialize();

  runApp(MyApp());
}
```

## Payment Flow Implementation

### 1. Create Payment Intent

Create `lib/features/payments/services/payment_service.dart`:

```dart
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentService {
  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  /// Creates a payment intent for a bid
  Future<String> createPaymentIntent({
    required String bidId,
    required String wishId,
    required int amount,
    String? description,
  }) async {
    try {
      // Call Cloud Function to create payment intent
      final result = await _functions
          .httpsCallable('createPaymentIntent')
          .call({
        'bidId': bidId,
        'wishId': wishId,
        'amount': amount,
        'description': description,
      });

      final data = result.data as Map<String, dynamic>;

      if (!data['success']) {
        throw Exception('Failed to create payment intent');
      }

      return data['clientSecret'] as String;
    } catch (e) {
      print('Error creating payment intent: $e');
      rethrow;
    }
  }

  /// Processes payment with Stripe
  Future<void> processPayment({
    required String clientSecret,
    BillingDetails? billingDetails,
  }) async {
    try {
      // Present payment sheet
      await Stripe.instance.presentPaymentSheet();

      // Payment successful
      print('Payment completed successfully');
    } catch (e) {
      if (e is StripeException) {
        print('Stripe error: ${e.error.localizedMessage}');
      }
      rethrow;
    }
  }

  /// Initializes payment sheet
  Future<void> initializePaymentSheet({
    required String clientSecret,
    String? customerEmail,
  }) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'WishMarketplace',
          customerEphemeralKeySecret: null,
          customerId: null,
          style: ThemeMode.system,
          billingDetailsCollectionConfiguration:
              BillingDetailsCollectionConfiguration(
            email: CollectionMode.always,
            phone: CollectionMode.always,
            name: CollectionMode.always,
            address: AddressCollectionMode.full,
          ),
        ),
      );
    } catch (e) {
      print('Error initializing payment sheet: $e');
      rethrow;
    }
  }

  /// Releases escrow (buyer confirms delivery)
  Future<void> releaseEscrow({
    required String transactionId,
    String? reason,
  }) async {
    try {
      final result = await _functions
          .httpsCallable('releaseEscrow')
          .call({
        'transactionId': transactionId,
        'reason': reason ?? 'Service/product delivery confirmed',
      });

      final data = result.data as Map<String, dynamic>;

      if (!data['success']) {
        throw Exception('Failed to release escrow');
      }
    } catch (e) {
      print('Error releasing escrow: $e');
      rethrow;
    }
  }

  /// Refunds escrow payment
  Future<void> refundEscrow({
    required String transactionId,
    required String reason,
    int? refundAmount,
  }) async {
    try {
      final result = await _functions
          .httpsCallable('refundEscrow')
          .call({
        'transactionId': transactionId,
        'reason': reason,
        if (refundAmount != null) 'refundAmount': refundAmount,
      });

      final data = result.data as Map<String, dynamic>;

      if (!data['success']) {
        throw Exception('Failed to refund escrow');
      }
    } catch (e) {
      print('Error refunding escrow: $e');
      rethrow;
    }
  }

  /// Disputes escrow payment
  Future<void> disputeEscrow({
    required String transactionId,
    required String reason,
    Map<String, dynamic>? evidence,
  }) async {
    try {
      final result = await _functions
          .httpsCallable('disputeEscrow')
          .call({
        'transactionId': transactionId,
        'reason': reason,
        if (evidence != null) 'evidence': evidence,
      });

      final data = result.data as Map<String, dynamic>;

      if (!data['success']) {
        throw Exception('Failed to dispute escrow');
      }
    } catch (e) {
      print('Error disputing escrow: $e');
      rethrow;
    }
  }
}
```

### 2. Payment Provider (State Management)

Create `lib/features/payments/providers/payment_provider.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/payment_service.dart';

final paymentServiceProvider = Provider((ref) => PaymentService());

class PaymentState {
  final bool isProcessing;
  final String? error;
  final String? transactionId;
  final String? clientSecret;

  PaymentState({
    this.isProcessing = false,
    this.error,
    this.transactionId,
    this.clientSecret,
  });

  PaymentState copyWith({
    bool? isProcessing,
    String? error,
    String? transactionId,
    String? clientSecret,
  }) {
    return PaymentState(
      isProcessing: isProcessing ?? this.isProcessing,
      error: error,
      transactionId: transactionId ?? this.transactionId,
      clientSecret: clientSecret ?? this.clientSecret,
    );
  }
}

class PaymentNotifier extends StateNotifier<PaymentState> {
  final PaymentService _paymentService;

  PaymentNotifier(this._paymentService) : super(PaymentState());

  Future<bool> initiatePayment({
    required String bidId,
    required String wishId,
    required int amount,
    String? description,
  }) async {
    state = state.copyWith(isProcessing: true, error: null);

    try {
      // Create payment intent
      final clientSecret = await _paymentService.createPaymentIntent(
        bidId: bidId,
        wishId: wishId,
        amount: amount,
        description: description,
      );

      // Initialize payment sheet
      await _paymentService.initializePaymentSheet(
        clientSecret: clientSecret,
      );

      // Present payment sheet
      await _paymentService.processPayment(clientSecret: clientSecret);

      state = state.copyWith(
        isProcessing: false,
        clientSecret: clientSecret,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<bool> confirmDelivery(String transactionId) async {
    state = state.copyWith(isProcessing: true, error: null);

    try {
      await _paymentService.releaseEscrow(
        transactionId: transactionId,
        reason: 'Delivery confirmed by buyer',
      );

      state = state.copyWith(isProcessing: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<bool> requestRefund({
    required String transactionId,
    required String reason,
  }) async {
    state = state.copyWith(isProcessing: true, error: null);

    try {
      await _paymentService.refundEscrow(
        transactionId: transactionId,
        reason: reason,
      );

      state = state.copyWith(isProcessing: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        error: e.toString(),
      );
      return false;
    }
  }
}

final paymentProvider = StateNotifierProvider<PaymentNotifier, PaymentState>(
  (ref) => PaymentNotifier(ref.watch(paymentServiceProvider)),
);
```

### 3. Payment UI Screen

Create `lib/features/payments/presentation/pages/payment_page.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/payment_provider.dart';
import '../../../../core/models/bid_model.dart';
import '../../../../core/models/wish_model.dart';

class PaymentPage extends ConsumerWidget {
  final WishModel wish;
  final BidModel bid;

  const PaymentPage({
    Key? key,
    required this.wish,
    required this.bid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentState = ref.watch(paymentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Payment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Payment Summary
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Payment Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryRow('Wish', wish.title),
                    _buildSummaryRow(
                      'Amount',
                      '\$${(bid.amount / 100).toStringAsFixed(2)}',
                    ),
                    const Divider(),
                    const Text(
                      'This payment will be held in escrow until you confirm delivery.',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Payment Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: paymentState.isProcessing
                    ? null
                    : () => _handlePayment(context, ref),
                child: paymentState.isProcessing
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Pay Now'),
              ),
            ),

            if (paymentState.error != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error, color: Colors.red.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        paymentState.error!,
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Security Info
            _buildSecurityInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityInfo() {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.security, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text(
                  'Secure Payment',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              '• Payment held in escrow until delivery confirmed\n'
              '• Powered by Stripe - industry-leading security\n'
              '• Full refund available if service not delivered\n'
              '• Dispute resolution available if needed',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handlePayment(BuildContext context, WidgetRef ref) async {
    final success = await ref.read(paymentProvider.notifier).initiatePayment(
          bidId: bid.id,
          wishId: wish.id,
          amount: bid.amount,
          description: 'Payment for: ${wish.title}',
        );

    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Payment successful! Funds held in escrow.'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }
}
```

### 4. Delivery Confirmation Screen

Create `lib/features/payments/presentation/pages/delivery_confirmation_page.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/payment_provider.dart';
import '../../../../core/models/transaction_model.dart';

class DeliveryConfirmationPage extends ConsumerWidget {
  final TransactionModel transaction;

  const DeliveryConfirmationPage({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentState = ref.watch(paymentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Delivery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            const Text(
              'Confirm Delivery',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Has the service/product been delivered satisfactorily?',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: Colors.amber.shade700),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'By confirming, you release the payment to the seller. '
                      'This action cannot be undone.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: paymentState.isProcessing
                    ? null
                    : () => _confirmDelivery(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: paymentState.isProcessing
                    ? const CircularProgressIndicator()
                    : const Text('Confirm Delivery & Release Payment'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _showDisputeDialog(context),
                child: const Text('Report Issue'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDelivery(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delivery?'),
        content: const Text(
          'This will release the payment to the seller. Are you sure?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final success = await ref
          .read(paymentProvider.notifier)
          .confirmDelivery(transaction.id);

      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Payment released to seller!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context);
      }
    }
  }

  void _showDisputeDialog(BuildContext context) {
    // Navigate to dispute form or show dialog
    // Implementation depends on your UI requirements
  }
}
```

## Test Cards

For testing, use these Stripe test cards:

| Card Number         | Scenario              |
|--------------------|-----------------------|
| 4242 4242 4242 4242 | Success              |
| 4000 0000 0000 0002 | Card declined        |
| 4000 0025 0000 3155 | Requires auth (3DS)  |
| 4000 0000 0000 9995 | Insufficient funds   |

Use any future expiry date and any 3-digit CVC.

## Error Handling

```dart
try {
  await paymentService.processPayment(clientSecret: clientSecret);
} on StripeException catch (e) {
  switch (e.error.code) {
    case FailureCode.Canceled:
      // User canceled payment
      break;
    case FailureCode.Failed:
      // Payment failed
      showError('Payment failed: ${e.error.localizedMessage}');
      break;
    default:
      showError('An error occurred');
  }
} catch (e) {
  showError('Unexpected error: $e');
}
```

## Next Steps

1. Add payment history page
2. Implement seller payout tracking
3. Add email notifications for payment events
4. Create admin panel for dispute resolution
5. Add analytics tracking for payment funnel
