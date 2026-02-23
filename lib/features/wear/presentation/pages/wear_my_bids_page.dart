import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/bid_model.dart';
import '../../core/wear_theme.dart';
import '../../core/wear_constants.dart';
import '../../core/wear_model_extensions.dart';
import '../../data/providers/wear_providers.dart';
import '../widgets/wear_scaffold.dart';
import '../widgets/wear_card.dart';
import '../widgets/wear_loading.dart';
import '../widgets/wear_empty_state.dart';
import '../widgets/wear_error_state.dart';

class WearMyBidsPage extends ConsumerWidget {
  final void Function(String listingId) onBidClick;

  const WearMyBidsPage({super.key, required this.onBidClick});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bidsAsync = ref.watch(wearBidsProvider);

    return WearScaffold(
      body: bidsAsync.when(
        loading: () => const WearLoading(),
        error: (error, _) => WearErrorState(message: error.toString()),
        data: (bids) {
          if (bids.isEmpty) {
            return const WearEmptyState(
              icon: Icons.gavel,
              message: 'No active bids',
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: WearConstants.listHorizontalPadding,
              vertical: WearConstants.listTopPadding,
            ),
            itemCount: bids.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'My Bids',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: WearColors.primary),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              final bid = bids[index - 1];
              return _BidCard(bid: bid, onTap: () => onBidClick(bid.listingId));
            },
          );
        },
      ),
    );
  }
}

class _BidCard extends StatelessWidget {
  final BidModel bid;
  final VoidCallback onTap;

  const _BidCard({required this.bid, required this.onTap});

  IconData? get _statusIcon {
    switch (bid.status) {
      case BidStatus.winning:
        return Icons.trending_up;
      case BidStatus.won:
        return Icons.check_circle;
      case BidStatus.outbid:
        return Icons.warning;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WearCard(
      onTap: onTap,
      backgroundColor: bid.statusColor.withValues(alpha: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: bid.statusColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  bid.status.name.toUpperCase(),
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: bid.statusColor),
                ),
              ),
              if (_statusIcon != null)
                Icon(_statusIcon, size: 20, color: bid.statusColor),
            ],
          ),
          const SizedBox(height: 8),

          // Bid amount
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Your Bid', style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant)),
                  Text(
                    bid.amountFormatted,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: WearColors.onSurface),
                  ),
                ],
              ),
              if (bid.isAutoBid)
                const Icon(Icons.autorenew, size: 24, color: WearColors.info),
            ],
          ),

          // Message if available
          if (bid.message != null) ...[
            const SizedBox(height: 4),
            Text(
              bid.message!,
              style: const TextStyle(fontSize: 10, color: WearColors.onSurfaceVariant),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ],
      ),
    );
  }
}
