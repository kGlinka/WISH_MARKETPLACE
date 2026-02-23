import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// Empty state widget for lists and collections
///
/// Provides consistent empty state UI across the app
class EmptyState extends StatelessWidget {
  final String message;
  final String? title;
  final IconData? icon;
  final VoidCallback? onAction;
  final String? actionButtonText;
  final Widget? illustration;

  const EmptyState({
    super.key,
    required this.message,
    this.title,
    this.icon,
    this.onAction,
    this.actionButtonText,
    this.illustration,
  });

  const EmptyState.noListings({
    super.key,
    this.message = 'No listings available at the moment.',
    this.title = 'No Listings',
    this.onAction,
    this.actionButtonText = 'Create Listing',
    this.illustration,
  }) : icon = Icons.inventory_2_outlined;

  const EmptyState.noBids({
    super.key,
    this.message = 'You have not placed any bids yet.',
    this.title = 'No Bids',
    this.onAction,
    this.actionButtonText = 'Browse Listings',
    this.illustration,
  }) : icon = Icons.gavel_outlined;

  const EmptyState.noFavorites({
    super.key,
    this.message = 'You have not favorited any listings yet.',
    this.title = 'No Favorites',
    this.onAction,
    this.actionButtonText = 'Browse Listings',
    this.illustration,
  }) : icon = Icons.favorite_border;

  const EmptyState.noMessages({
    super.key,
    this.message = 'You have no messages yet.',
    this.title = 'No Messages',
    this.onAction,
    this.actionButtonText,
    this.illustration,
  }) : icon = Icons.message_outlined;

  const EmptyState.noNotifications({
    super.key,
    this.message = 'You have no notifications.',
    this.title = 'No Notifications',
    this.onAction,
    this.actionButtonText,
    this.illustration,
  }) : icon = Icons.notifications_outlined;

  const EmptyState.searchNoResults({
    super.key,
    this.message = 'No results found for your search.',
    this.title = 'No Results',
    this.onAction,
    this.actionButtonText = 'Clear Search',
    this.illustration,
  }) : icon = Icons.search_off;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (illustration != null)
              illustration!
            else if (icon != null)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha:0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 64,
                  color: AppColors.primary,
                ),
              ),
            const SizedBox(height: 24),
            if (title != null) ...[
              Text(
                title!,
                style: AppTextStyles.headline6,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
            ],
            Text(
              message,
              style: AppTextStyles.bodyText2.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (onAction != null && actionButtonText != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                child: Text(actionButtonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
