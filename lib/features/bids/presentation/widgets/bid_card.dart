import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/bid_model.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../providers/bid_providers.dart';

/// Card widget for displaying a bid with optional actions
///
/// Shows bid details and allows cancellation/withdrawal
class BidCard extends ConsumerWidget {
  final BidModel bid;
  final bool showWishDetails;
  final bool showActions;

  const BidCard({
    super.key,
    required this.bid,
    this.showWishDetails = false,
    this.showActions = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status badge
            Row(
              children: [
                Expanded(
                  child: Text(
                    CurrencyUtils.formatCents(bid.amount),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(bid.status),
                        ),
                  ),
                ),
                _buildStatusBadge(bid.status),
              ],
            ),

            const SizedBox(height: 8),

            // Bid message if available
            if (bid.message != null && bid.message!.isNotEmpty) ...[
              Text(
                bid.message!,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
            ],

            // Metadata
            Row(
              children: [
                Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  DateTimeUtils.getRelativeTime(bid.createdAt),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                if (bid.updatedAt != null) ...[
                  const SizedBox(width: 12),
                  Icon(Icons.update, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    'Updated ${DateTimeUtils.getRelativeTime(bid.updatedAt!)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ],
            ),

            // Cancellation info if cancelled
            if (bid.status == BidStatus.cancelled && bid.cancellationReason != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 16, color: Colors.red[700]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Reason: ${bid.cancellationReason}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red[700],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Actions
            if (showActions && _canPerformActions(bid.status)) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showWishDetails)
                    TextButton.icon(
                      onPressed: () {
                        context.push('/wishes/${bid.listingId}');
                      },
                      icon: const Icon(Icons.visibility, size: 18),
                      label: const Text('View Wish'),
                    ),
                  const SizedBox(width: 8),
                  if (bid.status == BidStatus.active || bid.status == BidStatus.winning)
                    TextButton.icon(
                      onPressed: () => _showCancelDialog(context, ref),
                      icon: const Icon(Icons.cancel, size: 18),
                      label: const Text('Withdraw'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BidStatus status) {
    Color color;
    IconData icon;
    String label;

    switch (status) {
      case BidStatus.active:
        color = Colors.blue;
        icon = Icons.gavel;
        label = 'ACTIVE';
        break;
      case BidStatus.winning:
        color = Colors.green;
        icon = Icons.emoji_events;
        label = 'WINNING';
        break;
      case BidStatus.won:
        color = Colors.amber;
        icon = Icons.celebration;
        label = 'WON';
        break;
      case BidStatus.lost:
        color = Colors.grey;
        icon = Icons.sentiment_dissatisfied;
        label = 'LOST';
        break;
      case BidStatus.cancelled:
        color = Colors.red;
        icon = Icons.cancel;
        label = 'CANCELLED';
        break;
      case BidStatus.outbid:
        color = Colors.orange;
        icon = Icons.trending_down;
        label = 'OUTBID';
        break;
      case BidStatus.expired:
        color = Colors.grey;
        icon = Icons.access_time;
        label = 'EXPIRED';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(BidStatus status) {
    switch (status) {
      case BidStatus.active:
        return Colors.blue;
      case BidStatus.winning:
        return Colors.green;
      case BidStatus.won:
        return Colors.amber[700]!;
      case BidStatus.lost:
        return Colors.grey;
      case BidStatus.cancelled:
        return Colors.red;
      case BidStatus.outbid:
        return Colors.orange;
      case BidStatus.expired:
        return Colors.grey;
    }
  }

  bool _canPerformActions(BidStatus status) {
    return status == BidStatus.active || status == BidStatus.winning;
  }

  void _showCancelDialog(BuildContext context, WidgetRef ref) {
    final reasonController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Withdraw Bid'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Are you sure you want to withdraw this bid?',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason (Optional)',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
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
              await _cancelBid(context, ref, reasonController.text);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Withdraw'),
          ),
        ],
      ),
    );
  }

  Future<void> _cancelBid(BuildContext context, WidgetRef ref, String reason) async {
    final bidFormNotifier = ref.read(bidFormProvider.notifier);

    await bidFormNotifier.cancelBid(
      wishId: bid.listingId,
      bidId: bid.id,
      reason: reason.isEmpty ? null : reason,
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
          content: Text('Bid withdrawn successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
