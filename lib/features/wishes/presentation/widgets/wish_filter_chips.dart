import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/wish_model.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/wish_providers.dart';

/// Filter chips for filtering wishes
class WishFilterChips extends ConsumerWidget {
  const WishFilterChips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(selectedWishFilterProvider);
    final selectedCategory = ref.watch(selectedCategoryFilterProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status filters
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Filter by Status',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: WishFilter.values.map((filter) {
              final isSelected = selectedFilter == filter;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(_getFilterLabel(filter)),
                  selected: isSelected,
                  onSelected: (selected) {
                    ref.read(selectedWishFilterProvider.notifier).state = filter;
                  },
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 16),

        // Category filters
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Filter by Category',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              // "All Categories" chip
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: const Text('All Categories'),
                  selected: selectedCategory == null,
                  onSelected: (selected) {
                    ref.read(selectedCategoryFilterProvider.notifier).state = null;
                  },
                  selectedColor: AppColors.primary,
                  labelStyle: TextStyle(
                    color: selectedCategory == null ? Colors.white : Colors.grey[700],
                    fontWeight: selectedCategory == null ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
              // Category chips
              ...WishCategory.values.map((category) {
                final isSelected = selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(category.displayName),
                    selected: isSelected,
                    onSelected: (selected) {
                      ref.read(selectedCategoryFilterProvider.notifier).state =
                          selected ? category : null;
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[700],
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  String _getFilterLabel(WishFilter filter) {
    switch (filter) {
      case WishFilter.all:
        return 'All';
      case WishFilter.active:
        return 'Active';
      case WishFilter.inProgress:
        return 'In Progress';
      case WishFilter.completed:
        return 'Completed';
      case WishFilter.deferred:
        return 'Deferred';
      case WishFilter.favorites:
        return 'Favorites';
    }
  }
}
