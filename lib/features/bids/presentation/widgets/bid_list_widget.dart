import 'package:flutter/material.dart';
import '../../../../core/models/bid_model.dart';
import '../../../../core/utils/currency_utils.dart';
import '../../../../core/utils/date_time_utils.dart';

/// Widget for displaying a list of bids
///
/// Used in wish detail pages to show all bids on a wish
class BidListWidget extends StatelessWidget {
  final List<BidModel> bids;
  final String wishId;
  final bool showActions;

  const BidListWidget({
    super.key,
    required this.bids,
    required this.wishId,
    this.showActions = false,
  });

  @override
  Widget build(BuildContext context) {
    if (bids.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.gavel_outlined,
                size: 48,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 16),
              Text(
                'No bids yet',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Be the first to place a bid!',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[500],
                    ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: bids.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final bid = bids[index];
        final isHighestBid = index == 0; // Bids are sorted by amount descending

        return _BidListItem(
          bid: bid,
          isHighestBid: isHighestBid,
          rank: index + 1,
        );
      },
    );
  }
}

class _BidListItem extends StatelessWidget {
  final BidModel bid;
  final bool isHighestBid;
  final int rank;

  const _BidListItem({
    required this.bid,
    required this.isHighestBid,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isHighestBid ? Colors.green[50] : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHighestBid ? Colors.green : Colors.grey[300]!,
          width: isHighestBid ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          // Rank badge
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isHighestBid ? Colors.green : Colors.grey[300],
              shape: BoxShape.circle,
            ),
            child: Center(
              child: isHighestBid
                  ? const Icon(Icons.emoji_events, color: Colors.white, size: 20)
                  : Text(
                      '$rank',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),

          const SizedBox(width: 16),

          // Bid details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      CurrencyUtils.formatCents(bid.amount),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isHighestBid ? Colors.green[700] : null,
                          ),
                    ),
                    const SizedBox(width: 8),
                    _buildStatusBadge(bid.status),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  DateTimeUtils.getRelativeTime(bid.createdAt),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                if (bid.message != null && bid.message!.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text(
                    bid.message!,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BidStatus status) {
    if (status == BidStatus.active) {
      return const SizedBox.shrink();
    }

    Color color;
    String label;

    switch (status) {
      case BidStatus.winning:
        color = Colors.green;
        label = 'WINNING';
        break;
      case BidStatus.won:
        color = Colors.amber;
        label = 'WON';
        break;
      case BidStatus.lost:
        color = Colors.grey;
        label = 'LOST';
        break;
      case BidStatus.cancelled:
        color = Colors.red;
        label = 'CANCELLED';
        break;
      case BidStatus.outbid:
        color = Colors.orange;
        label = 'OUTBID';
        break;
      case BidStatus.expired:
        color = Colors.grey;
        label = 'EXPIRED';
        break;
      default:
        return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}
