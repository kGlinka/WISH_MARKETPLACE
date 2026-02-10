import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/wear_theme.dart';
import '../../core/wear_constants.dart';
import '../../data/providers/wear_providers.dart';
import '../widgets/wear_scaffold.dart';
import '../widgets/wear_chip.dart';
import '../widgets/wear_badge.dart';

class WearHomePage extends ConsumerWidget {
  final VoidCallback onNavigateToWishes;
  final VoidCallback onNavigateToMarketplace;
  final VoidCallback onNavigateToMyBids;
  final VoidCallback onNavigateToNotifications;
  final VoidCallback onNavigateToSettings;
  final VoidCallback onNavigateToCreateWish;

  const WearHomePage({
    super.key,
    required this.onNavigateToWishes,
    required this.onNavigateToMarketplace,
    required this.onNavigateToMyBids,
    required this.onNavigateToNotifications,
    required this.onNavigateToSettings,
    required this.onNavigateToCreateWish,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(wearNotificationsProvider);
    final bidsAsync = ref.watch(wearBidsProvider);

    final notificationCount = notificationsAsync.maybeWhen(
      data: (notifications) => notifications.length,
      orElse: () => 0,
    );

    final activeBidsCount = bidsAsync.maybeWhen(
      data: (bids) => bids.where((b) => b.status.name == 'active' || b.status.name == 'winning').length,
      orElse: () => 0,
    );

    return WearScaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: WearConstants.listHorizontalPadding,
          vertical: WearConstants.listTopPadding,
        ),
        children: [
          // App title
          const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'Wish Marketplace',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: WearColors.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // My Wishes
          WearChip(
            label: 'My Wishes',
            icon: Icons.favorite,
            backgroundColor: WearColors.primary,
            labelColor: WearColors.onPrimary,
            onTap: onNavigateToWishes,
          ),

          // Create Wish
          WearChip(
            label: 'Create Wish',
            icon: Icons.add,
            backgroundColor: WearColors.secondary,
            labelColor: WearColors.onSecondary,
            onTap: onNavigateToCreateWish,
          ),

          // Marketplace
          WearChip(
            label: 'Marketplace',
            icon: Icons.store,
            onTap: onNavigateToMarketplace,
          ),

          // My Bids with badge
          WearChip(
            label: 'My Bids',
            icon: Icons.gavel,
            onTap: onNavigateToMyBids,
            trailing: activeBidsCount > 0
                ? WearBadge(count: activeBidsCount, backgroundColor: WearColors.activeBid)
                : null,
          ),

          // Notifications with badge
          WearChip(
            label: 'Notifications',
            icon: Icons.notifications,
            onTap: onNavigateToNotifications,
            trailing: notificationCount > 0
                ? WearBadge(count: notificationCount, backgroundColor: WearColors.error)
                : null,
          ),

          // Settings
          WearChip(
            label: 'Settings',
            icon: Icons.settings,
            onTap: onNavigateToSettings,
          ),
        ],
      ),
    );
  }
}
