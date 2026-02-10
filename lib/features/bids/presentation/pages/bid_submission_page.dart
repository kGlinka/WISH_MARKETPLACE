import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/bid_model.dart';
import '../../../../core/models/wish_model.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../core/providers/firebase_providers.dart';

import '../../../wishes/presentation/providers/wish_providers.dart';
import '../providers/bid_providers.dart';
import '../widgets/bid_list_widget.dart';

/// Page for submitting a bid on a wish
///
/// Displays wish details, current bids, and bid submission form
class BidSubmissionPage extends ConsumerStatefulWidget {
  final String wishId;

  const BidSubmissionPage({
    super.key,
    required this.wishId,
  });

  @override
  ConsumerState<BidSubmissionPage> createState() => _BidSubmissionPageState();
}

class _BidSubmissionPageState extends ConsumerState<BidSubmissionPage> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _messageController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _amountController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(currentUserIdProvider);
    final wishAsync = ref.watch(wishRepositoryProvider).getWish(widget.wishId);
    final bidsAsync = ref.watch(wishBidsStreamProvider(widget.wishId));
    final highestBidAsync = ref.watch(highestBidStreamProvider(widget.wishId));
    final hasProviderBidAsync = ref.watch(hasProviderBidProvider(widget.wishId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Bid'),
      ),
      body: FutureBuilder<dynamic>(
        future: wishAsync,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: const Text('Go Back'),
                  ),
                ],
              ),
            );
          }

          final wishResult = snapshot.data;
          if (wishResult == null) {
            return const Center(child: Text('Wish not found'));
          }

          // Extract wish from Either
          WishModel? wish;
          wishResult.fold(
            (failure) => null,
            (w) => wish = w,
          );

          if (wish == null) {
            return const Center(child: Text('Wish not found'));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Wish details card
                _buildWishDetailsCard(wish!),

                const Divider(height: 1),

                // Current highest bid
                highestBidAsync.when(
                  data: (highestBid) => _buildHighestBidCard(highestBid),
                  loading: () => const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, stack) => const SizedBox.shrink(),
                ),

                const Divider(height: 1),

                // Check if user already has a bid
                hasProviderBidAsync.when(
                  data: (hasBid) {
                    if (hasBid) {
                      return _buildExistingBidWarning();
                    }
                    return _buildBidForm(context, userId, wish!);
                  },
                  loading: () => const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, stack) => _buildBidForm(context, userId, wish!),
                ),

                const Divider(height: 1, thickness: 8),

                // All bids list
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'All Bids',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                bidsAsync.when(
                  data: (bids) => BidListWidget(
                    bids: bids,
                    wishId: widget.wishId,
                    showActions: false,
                  ),
                  loading: () => const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, stack) => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('Error loading bids: $error'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWishDetailsCard(WishModel wish) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              wish.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              wish.description,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  label: Text(wish.category.displayName),
                  avatar: const Icon(Icons.category, size: 16),
                ),
                Chip(
                  label: Text(wish.priority.name.toUpperCase()),
                  avatar: const Icon(Icons.priority_high, size: 16),
                ),
                if (wish.targetDate != null)
                  Chip(
                    label: Text('Due: ${wish.targetDate}'),
                    avatar: const Icon(Icons.calendar_today, size: 16),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighestBidCard(BidModel? highestBid) {
    if (highestBid == null) {
      return Card(
        margin: const EdgeInsets.all(16),
        color: Colors.blue[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[700]),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'No bids yet',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                    ),
                    const Text('Be the first to bid on this wish!'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.green[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.trending_up, color: Colors.green[700]),
                const SizedBox(width: 8),
                Text(
                  'Current Highest Bid',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              CurrencyUtils.formatCents(highestBid.amount),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                  ),
            ),
            if (highestBid.message != null && highestBid.message!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                highestBid.message!,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildExistingBidWarning() {
    return Card(
      margin: const EdgeInsets.all(16),
      color: Colors.orange[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.orange[700]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Already Bid',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[700],
                    ),
                  ),
                  const Text(
                    'You have already placed a bid on this wish. You can view it in "My Bids".',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBidForm(BuildContext context, String? userId, WishModel wish) {
    if (userId == null) {
      return Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text('Please sign in to place a bid'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/login'),
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      );
    }

    // Don't allow bidding on own wishes
    if (wish.userId == userId) {
      return Card(
        margin: const EdgeInsets.all(16),
        color: Colors.red[50],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.block, color: Colors.red[700]),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'You cannot bid on your own wish',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Place Your Bid',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Bid Amount',
                  prefixText: '\$',
                  helperText: 'Enter your bid amount in dollars',
                  border: OutlineInputBorder(),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a bid amount';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return 'Please enter a valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _messageController,
                decoration: const InputDecoration(
                  labelText: 'Message (Optional)',
                  helperText: 'Add a message to explain your bid',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                maxLength: 500,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSubmitting ? null : () => _submitBid(userId),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Submit Bid'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitBid(String userId) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final amount = double.parse(_amountController.text);
      final amountInCents = (amount * 100).round();

      final bid = BidModel(
        id: '', // Will be set by Firestore
        listingId: widget.wishId,
        bidderId: userId,
        amount: amountInCents,
        status: BidStatus.active,
        message: _messageController.text.isEmpty ? null : _messageController.text,
        createdAt: DateTime.now(),
      );

      final bidFormNotifier = ref.read(bidFormProvider.notifier);
      await bidFormNotifier.submitBid(
        wishId: widget.wishId,
        bid: bid,
      );

      final state = ref.read(bidFormProvider);
      if (state.error != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else if (state.successMessage != null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Bid submitted successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }
}
