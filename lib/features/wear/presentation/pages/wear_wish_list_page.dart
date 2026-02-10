import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/wish_model.dart';
import '../../core/wear_theme.dart';
import '../../core/wear_constants.dart';
import '../../core/wear_model_extensions.dart';
import '../../data/providers/wear_providers.dart';
import '../widgets/wear_scaffold.dart';
import '../widgets/wear_card.dart';
import '../widgets/wear_progress_bar.dart';
import '../widgets/wear_chip.dart';
import '../widgets/wear_loading.dart';
import '../widgets/wear_empty_state.dart';
import '../widgets/wear_error_state.dart';

class WearWishListPage extends ConsumerWidget {
  final void Function(String wishId) onWishClick;
  final VoidCallback onCreateWish;

  const WearWishListPage({
    super.key,
    required this.onWishClick,
    required this.onCreateWish,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishesAsync = ref.watch(wearWishesProvider);

    return WearScaffold(
      body: wishesAsync.when(
        loading: () => const WearLoading(),
        error: (error, _) => WearErrorState(message: error.toString()),
        data: (wishes) {
          if (wishes.isEmpty) {
            return const WearEmptyState(
              icon: Icons.favorite_border,
              message: 'No active wishes',
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: WearConstants.listHorizontalPadding,
              vertical: WearConstants.listTopPadding,
            ),
            itemCount: wishes.length + 2, // +1 header, +1 new wish button
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'My Wishes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: WearColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (index == 1) {
                return WearChip(
                  label: 'New Wish',
                  icon: Icons.add,
                  backgroundColor: WearColors.secondary,
                  labelColor: WearColors.onSecondary,
                  onTap: onCreateWish,
                );
              }

              final wish = wishes[index - 2];
              return _WishCard(wish: wish, onTap: () => onWishClick(wish.id));
            },
          );
        },
      ),
    );
  }
}

class _WishCard extends StatelessWidget {
  final WishModel wish;
  final VoidCallback onTap;

  const _WishCard({required this.wish, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return WearCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and priority dot
          Row(
            children: [
              Expanded(
                child: Text(
                  wish.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: WearColors.onSurface,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: wish.priorityColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Category
          Text(
            wish.categoryDisplay,
            style: const TextStyle(fontSize: 12, color: WearColors.onSurfaceVariant),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // Progress bar
          WearProgressBar(progress: wish.progress),
        ],
      ),
    );
  }
}
