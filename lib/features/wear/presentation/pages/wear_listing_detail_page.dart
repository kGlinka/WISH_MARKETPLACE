import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/wear_theme.dart';
import '../../core/wear_constants.dart';
import '../../core/wear_model_extensions.dart';
import '../../data/providers/wear_providers.dart';
import '../widgets/wear_scaffold.dart';
import '../widgets/wear_card.dart';
import '../widgets/wear_chip.dart';
import '../widgets/wear_loading.dart';
import '../widgets/wear_error_state.dart';

class WearListingDetailPage extends ConsumerWidget {
  final String listingId;
  final VoidCallback onPlaceBid;

  const WearListingDetailPage({
    super.key,
    required this.listingId,
    required this.onPlaceBid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingAsync = ref.watch(wearListingDetailProvider(listingId));

    return WearScaffold(
      body: listingAsync.when(
        loading: () => const WearLoading(),
        error: (error, _) => WearErrorState(message: error.toString()),
        data: (listing) {
          if (listing == null) {
            return const WearErrorState(message: 'Listing not found');
          }

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: WearConstants.listTopPadding,
            ),
            children: [
              // Title
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  listing.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: WearColors.onSurface),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Current bid card
              WearCard(
                backgroundColor: WearColors.success.withValues(alpha: 0.2),
                child: Column(
                  children: [
                    const Text('Current Bid', style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant)),
                    Text(
                      listing.currentBidFormatted,
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: WearColors.success),
                    ),
                  ],
                ),
              ),

              // Time remaining card
              WearCard(
                backgroundColor: listing.isEndingSoon
                    ? WearColors.error.withValues(alpha: 0.2)
                    : WearColors.surface,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Time Left', style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant)),
                        Text(
                          listing.timeRemaining,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: listing.isEndingSoon ? WearColors.error : WearColors.warning,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text('Bids', style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant)),
                        Text(
                          listing.bidCount.toString(),
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: WearColors.onSurface),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Description
              WearCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 4),
                      child: Text('Description', style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant)),
                    ),
                    Text(
                      listing.description,
                      style: const TextStyle(fontSize: 14, color: WearColors.onSurface),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Bid details
              WearCard(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Starting Bid', style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant)),
                        Text(listing.startingBidFormatted, style: const TextStyle(fontSize: 14, color: WearColors.onSurface)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Bid Increment', style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant)),
                        Text('\$${listing.effectiveBidIncrement ~/ 100}', style: const TextStyle(fontSize: 14, color: WearColors.onSurface)),
                      ],
                    ),
                    if (listing.buyNowPrice != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Buy Now', style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant)),
                          Text(listing.buyNowPriceFormatted ?? '', style: const TextStyle(fontSize: 14, color: WearColors.success)),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              // Place bid button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: WearChip(
                  label: 'Place Bid',
                  icon: Icons.gavel,
                  backgroundColor: WearColors.primary,
                  labelColor: WearColors.onPrimary,
                  onTap: onPlaceBid,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
