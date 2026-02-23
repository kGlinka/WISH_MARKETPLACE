import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/notification_model.dart';
import '../../../core/providers/firebase_providers.dart';
import '../core/wear_navigation.dart';
import 'pages/wear_login_page.dart';
import 'pages/wear_home_page.dart';
import 'pages/wear_wish_list_page.dart';
import 'pages/wear_wish_detail_page.dart';
import 'pages/wear_marketplace_page.dart';
import 'pages/wear_listing_detail_page.dart';
import 'pages/wear_place_bid_page.dart';
import 'pages/wear_my_bids_page.dart';
import 'pages/wear_notifications_page.dart';
import 'pages/wear_settings_page.dart';
import 'pages/wear_register_page.dart';
import 'pages/wear_create_wish_page.dart';

/// Main navigation shell for Wear OS
/// Uses simple Navigator (no GoRouter - watch doesn't need deep linking)
class WearAppShell extends ConsumerStatefulWidget {
  const WearAppShell({super.key});

  @override
  ConsumerState<WearAppShell> createState() => _WearAppShellState();
}

class _WearAppShellState extends ConsumerState<WearAppShell> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = ref.watch(isAuthenticatedProvider);

    return Navigator(
      key: _navigatorKey,
      initialRoute: isAuthenticated ? WearRoutes.home : WearRoutes.login,
      onGenerateRoute: (settings) {
        Widget page;

        switch (settings.name) {
          case WearRoutes.login:
            page = WearLoginPage(
              onLoginSuccess: () {
                _navigator.pushNamedAndRemoveUntil(
                  WearRoutes.home,
                  (_) => false,
                );
              },
              onNavigateToRegister: () {
                _navigator.pushNamed(WearRoutes.register);
              },
            );
            break;

          case WearRoutes.register:
            page = WearRegisterPage(
              onRegisterSuccess: () {
                _navigator.pushNamedAndRemoveUntil(
                  WearRoutes.home,
                  (_) => false,
                );
              },
            );
            break;

          case WearRoutes.home:
            page = WearHomePage(
              onNavigateToWishes: () => _navigator.pushNamed(WearRoutes.wishes),
              onNavigateToMarketplace: () => _navigator.pushNamed(WearRoutes.marketplace),
              onNavigateToMyBids: () => _navigator.pushNamed(WearRoutes.myBids),
              onNavigateToNotifications: () => _navigator.pushNamed(WearRoutes.notifications),
              onNavigateToSettings: () => _navigator.pushNamed(WearRoutes.settings),
              onNavigateToCreateWish: () => _navigator.pushNamed(WearRoutes.createWish),
            );
            break;

          case WearRoutes.createWish:
            page = WearCreateWishPage(
              onWishCreated: () => _navigator.pop(),
            );
            break;

          case WearRoutes.wishes:
            page = WearWishListPage(
              onWishClick: (wishId) {
                _navigator.pushNamed(WearRoutes.wishDetail, arguments: wishId);
              },
              onCreateWish: () => _navigator.pushNamed(WearRoutes.createWish),
            );
            break;

          case WearRoutes.wishDetail:
            final wishId = settings.arguments as String;
            page = WearWishDetailPage(wishId: wishId);
            break;

          case WearRoutes.marketplace:
            page = WearMarketplacePage(
              onListingClick: (listingId) {
                _navigator.pushNamed(WearRoutes.listingDetail, arguments: listingId);
              },
            );
            break;

          case WearRoutes.listingDetail:
            final listingId = settings.arguments as String;
            page = WearListingDetailPage(
              listingId: listingId,
              onPlaceBid: () {
                _navigator.pushNamed(WearRoutes.placeBid, arguments: listingId);
              },
            );
            break;

          case WearRoutes.placeBid:
            final listingId = settings.arguments as String;
            page = WearPlaceBidPage(
              listingId: listingId,
              onBidPlaced: () => _navigator.pop(),
            );
            break;

          case WearRoutes.myBids:
            page = WearMyBidsPage(
              onBidClick: (listingId) {
                _navigator.pushNamed(WearRoutes.listingDetail, arguments: listingId);
              },
            );
            break;

          case WearRoutes.notifications:
            page = WearNotificationsPage(
              onNotificationClick: (notification) {
                _handleNotificationTap(notification);
              },
            );
            break;

          case WearRoutes.settings:
            page = WearSettingsPage(
              onSignOut: () {
                _navigator.pushNamedAndRemoveUntil(
                  WearRoutes.login,
                  (_) => false,
                );
              },
            );
            break;

          default:
            page = WearHomePage(
              onNavigateToWishes: () => _navigator.pushNamed(WearRoutes.wishes),
              onNavigateToMarketplace: () => _navigator.pushNamed(WearRoutes.marketplace),
              onNavigateToMyBids: () => _navigator.pushNamed(WearRoutes.myBids),
              onNavigateToNotifications: () => _navigator.pushNamed(WearRoutes.notifications),
              onNavigateToSettings: () => _navigator.pushNamed(WearRoutes.settings),
              onNavigateToCreateWish: () => _navigator.pushNamed(WearRoutes.createWish),
            );
        }

        return MaterialPageRoute(builder: (_) => page, settings: settings);
      },
    );
  }

  void _handleNotificationTap(NotificationModel notification) {
    if (notification.listingId != null) {
      _navigator.pushNamed(WearRoutes.listingDetail, arguments: notification.listingId);
    } else if (notification.bidId != null) {
      _navigator.pushNamed(WearRoutes.myBids);
    }
  }
}
