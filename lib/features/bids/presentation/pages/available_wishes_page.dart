import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/models/wish_model.dart';

import '../../../wishes/presentation/providers/wish_providers.dart';
import '../widgets/wish_bid_card.dart';

/// Page showing available wishes that providers can bid on
///
/// Displays public wishes with real-time updates
class AvailableWishesPage extends ConsumerStatefulWidget {
  const AvailableWishesPage({super.key});

  @override
  ConsumerState<AvailableWishesPage> createState() => _AvailableWishesPageState();
}

class _AvailableWishesPageState extends ConsumerState<AvailableWishesPage> {
  WishCategory? _selectedCategory;
  WishPriority? _selectedPriority;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // Get all public wishes (active status)
    final wishesAsyncValue = ref.watch(wishesByStatusProvider(WishStatus.active));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Wishes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search wishes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),

          // Active filters display
          if (_selectedCategory != null || _selectedPriority != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8,
                children: [
                  if (_selectedCategory != null)
                    Chip(
                      label: Text(_selectedCategory!.displayName),
                      onDeleted: () {
                        setState(() {
                          _selectedCategory = null;
                        });
                      },
                    ),
                  if (_selectedPriority != null)
                    Chip(
                      label: Text(_selectedPriority!.name.toUpperCase()),
                      onDeleted: () {
                        setState(() {
                          _selectedPriority = null;
                        });
                      },
                    ),
                ],
              ),
            ),

          const SizedBox(height: 8),

          // Wishes list
          Expanded(
            child: wishesAsyncValue.when(
              data: (wishes) {
                // Filter wishes based on search and filters
                final filteredWishes = wishes.where((wish) {
                  // Filter by search query
                  if (_searchQuery.isNotEmpty) {
                    final matchesSearch = wish.title.toLowerCase().contains(_searchQuery) ||
                        wish.description.toLowerCase().contains(_searchQuery);
                    if (!matchesSearch) return false;
                  }

                  // Filter by category
                  if (_selectedCategory != null && wish.category != _selectedCategory) {
                    return false;
                  }

                  // Filter by priority
                  if (_selectedPriority != null && wish.priority != _selectedPriority) {
                    return false;
                  }

                  // Only show public wishes
                  return wish.isPublic;
                }).toList();

                if (filteredWishes.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No wishes available',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your filters',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey[500],
                              ),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(wishesByStatusProvider(WishStatus.active));
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredWishes.length,
                    itemBuilder: (context, index) {
                      final wish = filteredWishes[index];
                      return WishBidCard(
                        wish: wish,
                        onTap: () {
                          context.push('/wishes/${wish.id}/bid');
                        },
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
                      'Failed to load wishes',
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
                        ref.invalidate(wishesByStatusProvider(WishStatus.active));
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

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Filter Wishes'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category filter
              const Text(
                'Category',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('All'),
                    selected: _selectedCategory == null,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = null;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  ...WishCategory.values.map((category) {
                    return ChoiceChip(
                      label: Text(category.displayName),
                      selected: _selectedCategory == category,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = selected ? category : null;
                        });
                        Navigator.of(context).pop();
                      },
                    );
                  }),
                ],
              ),
              const SizedBox(height: 16),

              // Priority filter
              const Text(
                'Priority',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('All'),
                    selected: _selectedPriority == null,
                    onSelected: (selected) {
                      setState(() {
                        _selectedPriority = null;
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  ...WishPriority.values.map((priority) {
                    return ChoiceChip(
                      label: Text(priority.name.toUpperCase()),
                      selected: _selectedPriority == priority,
                      onSelected: (selected) {
                        setState(() {
                          _selectedPriority = selected ? priority : null;
                        });
                        Navigator.of(context).pop();
                      },
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedCategory = null;
                _selectedPriority = null;
              });
              Navigator.of(context).pop();
            },
            child: const Text('Clear All'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
