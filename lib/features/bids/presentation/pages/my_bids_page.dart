import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/bid_providers.dart';
import '../widgets/bid_card.dart';

/// Page showing all bids placed by the current provider
///
/// Displays bids with real-time updates and filtering options
class MyBidsPage extends ConsumerWidget {
  const MyBidsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(selectedBidFilterProvider);
    final bidsAsync = ref.watch(filteredProviderBidsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bids'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: BidFilter.values.map((filter) {
                final isSelected = selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(_getFilterLabel(filter)),
                    selected: isSelected,
                    onSelected: (selected) {
                      ref.read(selectedBidFilterProvider.notifier).state = filter;
                    },
                    avatar: isSelected ? const Icon(Icons.check, size: 18) : null,
                  ),
                );
              }).toList(),
            ),
          ),

          const Divider(height: 1),

          // Bids list
          Expanded(
            child: bidsAsync.when(
              data: (bids) {
                if (bids.isEmpty) {
                  return _buildEmptyState(context, selectedFilter);
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(filteredProviderBidsStreamProvider);
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: bids.length,
                    itemBuilder: (context, index) {
                      final bid = bids[index];
                      return BidCard(
                        bid: bid,
                        showWishDetails: true,
                        showActions: true,
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red[300],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Failed to load bids',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[600],
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        ref.invalidate(filteredProviderBidsStreamProvider);
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, BidFilter filter) {
    String message;
    IconData icon;

    switch (filter) {
      case BidFilter.active:
        message = 'You have no active bids';
        icon = Icons.gavel;
        break;
      case BidFilter.winning:
        message = 'You have no winning bids';
        icon = Icons.emoji_events;
        break;
      case BidFilter.won:
        message = 'You have not won any bids yet';
        icon = Icons.celebration;
        break;
      case BidFilter.lost:
        message = 'You have no lost bids';
        icon = Icons.sentiment_dissatisfied;
        break;
      case BidFilter.cancelled:
        message = 'You have no cancelled bids';
        icon = Icons.cancel;
        break;
      case BidFilter.all:
        message = 'You have not placed any bids yet';
        icon = Icons.inbox;
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Browse available wishes to place bids',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
          ),
        ],
      ),
    );
  }

  String _getFilterLabel(BidFilter filter) {
    switch (filter) {
      case BidFilter.all:
        return 'All';
      case BidFilter.active:
        return 'Active';
      case BidFilter.winning:
        return 'Winning';
      case BidFilter.won:
        return 'Won';
      case BidFilter.lost:
        return 'Lost';
      case BidFilter.cancelled:
        return 'Cancelled';
    }
  }

  void _showFilterDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Bids'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: BidFilter.values.map((filter) {
            final currentFilter = ref.read(selectedBidFilterProvider);
            return RadioListTile<BidFilter>(
              title: Text(_getFilterLabel(filter)),
              value: filter,
              groupValue: currentFilter,
              onChanged: (value) {
                if (value != null) {
                  ref.read(selectedBidFilterProvider.notifier).state = value;
                  Navigator.of(context).pop();
                }
              },
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
