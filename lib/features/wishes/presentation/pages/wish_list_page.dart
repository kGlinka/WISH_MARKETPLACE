import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/wish_providers.dart';
import '../widgets/wish_card.dart';
import '../widgets/wish_filter_chips.dart';
import '../widgets/wish_statistics_card.dart';

/// Page for displaying and managing user's wishes
class WishListPage extends ConsumerStatefulWidget {
  const WishListPage({super.key});

  @override
  ConsumerState<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends ConsumerState<WishListPage> {
  bool _showFilters = false;
  bool _showStatistics = true;

  @override
  Widget build(BuildContext context) {
    final wishesAsync = ref.watch(filteredWishesProvider);
    final statisticsAsync = ref.watch(wishStatisticsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishes'),
        actions: [
          IconButton(
            icon: Icon(_showStatistics ? Icons.show_chart : Icons.show_chart_outlined),
            onPressed: () {
              setState(() {
                _showStatistics = !_showStatistics;
              });
            },
            tooltip: _showStatistics ? 'Hide Statistics' : 'Show Statistics',
          ),
          IconButton(
            icon: Icon(_showFilters ? Icons.filter_list : Icons.filter_list_outlined),
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
            tooltip: _showFilters ? 'Hide Filters' : 'Show Filters',
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _showSearchDialog(context);
            },
            tooltip: 'Search Wishes',
          ),
        ],
      ),
      body: Column(
        children: [
          // Statistics
          if (_showStatistics)
            statisticsAsync.when(
              data: (stats) => WishStatisticsCard(statistics: stats),
              loading: () => const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (error, stack) => Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Error loading statistics: $error'),
              ),
            ),

          // Filters
          if (_showFilters) ...[
            const WishFilterChips(),
            const SizedBox(height: 8),
          ],

          // Wishes List
          Expanded(
            child: wishesAsync.when(
              data: (wishes) {
                if (wishes.isEmpty) {
                  return _buildEmptyState();
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(filteredWishesProvider);
                  },
                  child: ListView.builder(
                    itemCount: wishes.length,
                    itemBuilder: (context, index) {
                      final wish = wishes[index];
                      return WishCard(
                        wish: wish,
                        onTap: () {
                          context.push(
                            '${AppConstants.wishDetailsRoute}/${wish.id}',
                          );
                        },
                        onFavoriteToggle: () async {
                          await ref
                              .read(wishActionsProvider.notifier)
                              .toggleFavorite(wish.id, !wish.isFavorite);
                        },
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
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
                      'Error loading wishes',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ref.invalidate(filteredWishesProvider);
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push(AppConstants.createWishRoute);
        },
        icon: const Icon(Icons.add),
        label: const Text('New Wish'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.stars_outlined,
            size: 100,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 24),
          Text(
            'No wishes yet',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start capturing your dreams and aspirations',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              context.push(AppConstants.createWishRoute);
            },
            icon: const Icon(Icons.add),
            label: const Text('Create Your First Wish'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    final searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Wishes'),
        content: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            hintText: 'Enter search query...',
            prefixIcon: Icon(Icons.search),
          ),
          autofocus: true,
          onSubmitted: (query) {
            if (query.isNotEmpty) {
              Navigator.pop(context);
              context.push(
                '${AppConstants.searchRoute}?q=$query&type=wishes',
              );
            }
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final query = searchController.text;
              if (query.isNotEmpty) {
                Navigator.pop(context);
                context.push(
                  '${AppConstants.searchRoute}?q=$query&type=wishes',
                );
              }
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
