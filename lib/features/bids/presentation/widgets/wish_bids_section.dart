import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/bid_model.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../providers/bid_providers.dart';
import 'bid_list_widget.dart';

/// Widget section for displaying bids on a wish
///
/// Shows all bids with accept/reject actions for wish owners
class WishBidsSection extends ConsumerWidget {
  final String wishId;
  final String wishOwnerId;

  const WishBidsSection({
    super.key,
    required this.wishId,
    required this.wishOwnerId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserId = ref.watch(currentUserIdProvider);
    final bidsAsync = ref.watch(wishBidsStreamProvider(wishId));
    final isOwner = currentUserId == wishOwnerId;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.gavel, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Bids',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                bidsAsync.when(
                  data: (bids) => Chip(
                    label: Text('${bids.length}'),
                    avatar: const Icon(Icons.numbers, size: 16),
                  ),
                  loading: () => const SizedBox.shrink(),
                  error: (_, __) => const SizedBox.shrink(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            bidsAsync.when(
              data: (bids) {
                return Column(
                  children: [
                    BidListWidget(
                      bids: bids,
                      wishId: wishId,
                      showActions: false,
                    ),
                    if (isOwner && bids.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _buildOwnerActions(context, ref, bids),
                    ],
                  ],
                );
              },
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (error, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red[300],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Failed to load bids',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnerActions(BuildContext context, WidgetRef ref, List<BidModel> bids) {
    final activeBids = bids.where((bid) =>
        bid.status == BidStatus.active || bid.status == BidStatus.winning).toList();

    if (activeBids.isEmpty) {
      return const SizedBox.shrink();
    }

    final highestBid = activeBids.first;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue[700]),
              const SizedBox(width: 8),
              Text(
                'Owner Actions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'You can accept the highest bid to proceed with this wish.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => _showAcceptBidDialog(context, ref, highestBid),
            icon: const Icon(Icons.check_circle),
            label: Text('Accept Highest Bid (\$${(highestBid.amount / 100).toStringAsFixed(2)})'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showAcceptBidDialog(BuildContext context, WidgetRef ref, BidModel bid) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Accept Bid'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Are you sure you want to accept this bid?',
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bid Amount: \$${(bid.amount / 100).toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (bid.message != null && bid.message!.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text('Message: ${bid.message}'),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'This will mark your wish as "In Progress" and notify the provider.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _acceptBid(context, ref, bid);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: const Text('Accept Bid'),
          ),
        ],
      ),
    );
  }

  Future<void> _acceptBid(BuildContext context, WidgetRef ref, BidModel bid) async {
    final bidFormNotifier = ref.read(bidFormProvider.notifier);

    await bidFormNotifier.acceptBid(
      wishId: wishId,
      bidId: bid.id,
    );

    final state = ref.read(bidFormProvider);

    if (!context.mounted) return;

    if (state.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${state.error}'),
          backgroundColor: Colors.red,
        ),
      );
    } else if (state.successMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Bid accepted successfully!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
