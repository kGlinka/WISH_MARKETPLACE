import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../core/wear_theme.dart';
import '../../core/wear_constants.dart';
import '../../core/wear_model_extensions.dart';
import '../../data/providers/wear_providers.dart';
import '../widgets/wear_scaffold.dart';
import '../widgets/wear_card.dart';
import '../widgets/wear_chip.dart';
import '../widgets/wear_bid_option_chip.dart';
import '../widgets/wear_loading.dart';
import '../widgets/wear_error_state.dart';

class WearPlaceBidPage extends ConsumerStatefulWidget {
  final String listingId;
  final VoidCallback onBidPlaced;

  const WearPlaceBidPage({
    super.key,
    required this.listingId,
    required this.onBidPlaced,
  });

  @override
  ConsumerState<WearPlaceBidPage> createState() => _WearPlaceBidPageState();
}

class _WearPlaceBidPageState extends ConsumerState<WearPlaceBidPage> {
  bool _isPlacingBid = false;
  String? _errorMessage;
  String? _successMessage;

  Future<void> _placeBid(int amount) async {
    setState(() {
      _isPlacingBid = true;
      _errorMessage = null;
    });

    try {
      final firestoreService = ref.read(firestoreServiceProvider);
      final userId = ref.read(currentUserIdProvider);

      if (userId == null) {
        setState(() {
          _errorMessage = 'Not logged in';
          _isPlacingBid = false;
        });
        return;
      }

      await firestoreService.createDocument(
        collection: 'bids',
        data: {
          'listingId': widget.listingId,
          'bidderId': userId,
          'amount': amount,
          'status': 'active',
          'isAutoBid': false,
        },
      );

      setState(() => _successMessage = 'Bid placed successfully!');
      await Future.delayed(const Duration(milliseconds: 1500));
      widget.onBidPlaced();
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isPlacingBid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final listingAsync = ref.watch(wearListingDetailProvider(widget.listingId));

    if (_successMessage != null) {
      return WearScaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, size: 64, color: WearColors.success),
              const SizedBox(height: 8),
              Text(
                _successMessage!,
                style: const TextStyle(fontSize: 14, color: WearColors.success),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return WearScaffold(
      body: listingAsync.when(
        loading: () => const WearLoading(),
        error: (error, _) => WearErrorState(message: error.toString()),
        data: (listing) {
          if (listing == null) {
            return const WearErrorState(message: 'Listing not found');
          }

          final currentBid = listing.currentBid ?? listing.startingPrice;
          final bidIncrement = listing.effectiveBidIncrement;
          final minimumBid = currentBid + bidIncrement;

          return ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: WearConstants.listTopPadding,
            ),
            children: [
              // Title
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Place Bid',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: WearColors.primary),
                  textAlign: TextAlign.center,
                ),
              ),

              // Current bid info
              WearCard(
                child: Column(
                  children: [
                    const Text('Current Bid', style: TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant)),
                    Text(
                      listing.currentBidFormatted,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: WearColors.onSurface),
                    ),
                  ],
                ),
              ),

              // Error message
              if (_errorMessage != null)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: WearColors.error.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(fontSize: 14, color: WearColors.error),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Minimum bid
              WearBidOptionChip(
                label: 'Minimum Bid',
                amount: minimumBid,
                enabled: !_isPlacingBid,
                onTap: () => _placeBid(minimumBid),
              ),

              // +$5
              WearBidOptionChip(
                label: '+\$5',
                amount: currentBid + 500,
                enabled: !_isPlacingBid,
                onTap: () => _placeBid(currentBid + 500),
              ),

              // +$10
              WearBidOptionChip(
                label: '+\$10',
                amount: currentBid + 1000,
                enabled: !_isPlacingBid,
                onTap: () => _placeBid(currentBid + 1000),
              ),

              // +$25
              WearBidOptionChip(
                label: '+\$25',
                amount: currentBid + 2500,
                enabled: !_isPlacingBid,
                onTap: () => _placeBid(currentBid + 2500),
              ),

              // Buy Now option
              if (listing.buyNowPrice != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: WearChip(
                    label: 'Buy Now ${listing.buyNowPriceFormatted}',
                    icon: Icons.shopping_cart,
                    backgroundColor: WearColors.success,
                    labelColor: Colors.white,
                    enabled: !_isPlacingBid,
                    onTap: () => _placeBid(listing.buyNowPrice!),
                  ),
                ),

              // Loading indicator
              if (_isPlacingBid)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: CircularProgressIndicator(color: WearColors.primary),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
