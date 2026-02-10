import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/listing_model.dart';
import '../../core/wear_theme.dart';
import '../../core/wear_constants.dart';
import '../../core/wear_model_extensions.dart';
import '../../data/providers/wear_providers.dart';
import '../widgets/wear_scaffold.dart';
import '../widgets/wear_card.dart';
import '../widgets/wear_loading.dart';
import '../widgets/wear_empty_state.dart';
import '../widgets/wear_error_state.dart';

class WearMarketplacePage extends ConsumerWidget {
  final void Function(String listingId) onListingClick;

  const WearMarketplacePage({super.key, required this.onListingClick});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsync = ref.watch(wearListingsProvider);

    return WearScaffold(
      body: listingsAsync.when(
        loading: () => const WearLoading(),
        error: (error, _) => WearErrorState(message: error.toString()),
        data: (listings) {
          if (listings.isEmpty) {
            return const WearEmptyState(
              icon: Icons.store,
              message: 'No active listings',
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: WearConstants.listHorizontalPadding,
              vertical: WearConstants.listTopPadding,
            ),
            itemCount: listings.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Marketplace',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: WearColors.secondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              final listing = listings[index - 1];
              return _ListingCard(
                listing: listing,
                onTap: () => onListingClick(listing.id),
              );
            },
          );
        },
      ),
    );
  }
}

class _ListingCard extends StatelessWidget {
  final ListingModel listing;
  final VoidCallback onTap;

  const _ListingCard({required this.listing, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return WearCard(
      onTap: onTap,
      backgroundColor: listing.isEndingSoon
          ? WearColors.error.withValues(alpha: 0.2)
          : WearColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            listing.title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: WearColors.onSurface),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // Current bid and time remaining
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Current Bid', style: TextStyle(fontSize: 10, color: WearColors.onSurfaceVariant)),
                  Text(
                    listing.currentBidFormatted,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: WearColors.success),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('Time Left', style: TextStyle(fontSize: 10, color: WearColors.onSurfaceVariant)),
                  Text(
                    listing.timeRemaining,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: listing.isEndingSoon ? WearColors.error : WearColors.warning,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Bid count
          if (listing.bidCount > 0) ...[
            const SizedBox(height: 4),
            Text(
              '${listing.bidCount} bid${listing.bidCount != 1 ? 's' : ''}',
              style: const TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant),
            ),
          ],

          // Ending soon indicator
          if (listing.isEndingSoon) ...[
            const SizedBox(height: 4),
            const Row(
              children: [
                Icon(Icons.warning, size: 12, color: WearColors.error),
                SizedBox(width: 4),
                Text('Ending Soon!', style: TextStyle(fontSize: 10, color: WearColors.error)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
