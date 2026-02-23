import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_constants.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/wishes/presentation/pages/wish_list_page.dart';
import '../../features/wishes/presentation/pages/wish_detail_page.dart';
import '../../features/wishes/presentation/pages/wish_form_page.dart';
import '../../features/bids/presentation/pages/available_wishes_page.dart';
import '../../features/bids/presentation/pages/bid_submission_page.dart';
import '../../features/bids/presentation/pages/my_bids_page.dart';

/// GoRouter configuration provider
///
/// Provides type-safe routing with authentication guards
final goRouterProvider = Provider<GoRouter>((ref) {
  // Watch auth state for route guards
  // final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppConstants.splashRoute,
    debugLogDiagnostics: true,
    // redirect: (context, state) {
    //   final isAuthenticated = authState.maybeWhen(
    //     authenticated: (_) => true,
    //     orElse: () => false,
    //   );
    //
    //   final isAuthRoute = state.matchedLocation.startsWith('/login') ||
    //       state.matchedLocation.startsWith('/register');
    //
    //   // Redirect to login if not authenticated and trying to access protected route
    //   if (!isAuthenticated && !isAuthRoute && state.matchedLocation != '/') {
    //     return AppConstants.loginRoute;
    //   }
    //
    //   // Redirect to home if authenticated and on auth route
    //   if (isAuthenticated && isAuthRoute) {
    //     return AppConstants.homeRoute;
    //   }
    //
    //   return null; // No redirect needed
    // },
    routes: [
      // Splash
      GoRoute(
        path: AppConstants.splashRoute,
        name: 'splash',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SplashPage(),
        ),
      ),

      // Authentication Routes
      GoRoute(
        path: AppConstants.loginRoute,
        name: 'login',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: AppConstants.registerRoute,
        name: 'register',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const RegisterPage(),
        ),
      ),

      // Home (Main Navigation Shell)
      GoRoute(
        path: AppConstants.homeRoute,
        name: 'home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),

      // Listing Details
      GoRoute(
        path: '${AppConstants.listingDetailsRoute}/:id',
        name: 'listing-details',
        pageBuilder: (context, state) {
          final listingId = state.pathParameters['id']!;
          return MaterialPage(
            key: state.pageKey,
            child: Scaffold(
              appBar: AppBar(title: const Text('Listing Details')),
              body: Center(child: Text('Listing ID: $listingId')),
            ),
          );
        },
      ),

      // Create Listing
      GoRoute(
        path: AppConstants.createListingRoute,
        name: 'create-listing',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            appBar: AppBar(title: const Text('Create Listing')),
            body: const Center(child: Text('Create Listing Page')),
          ),
        ),
      ),

      // Profile
      GoRoute(
        path: '${AppConstants.profileRoute}/:id',
        name: 'profile',
        pageBuilder: (context, state) {
          final userId = state.pathParameters['id']!;
          return MaterialPage(
            key: state.pageKey,
            child: Scaffold(
              appBar: AppBar(title: const Text('Profile')),
              body: Center(child: Text('User ID: $userId')),
            ),
          );
        },
      ),

      // Settings
      GoRoute(
        path: AppConstants.settingsRoute,
        name: 'settings',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            appBar: AppBar(title: const Text('Settings')),
            body: const Center(child: Text('Settings Page')),
          ),
        ),
      ),

      // Messages
      GoRoute(
        path: AppConstants.messagesRoute,
        name: 'messages',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            appBar: AppBar(title: const Text('Messages')),
            body: const Center(child: Text('Messages Page')),
          ),
        ),
      ),

      // Notifications
      GoRoute(
        path: AppConstants.notificationsRoute,
        name: 'notifications',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            appBar: AppBar(title: const Text('Notifications')),
            body: const Center(child: Text('Notifications Page')),
          ),
        ),
      ),

      // My Listings
      GoRoute(
        path: AppConstants.myListingsRoute,
        name: 'my-listings',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            appBar: AppBar(title: const Text('My Listings')),
            body: const Center(child: Text('My Listings Page')),
          ),
        ),
      ),

      // My Bids (Provider Bids)
      GoRoute(
        path: AppConstants.myBidsRoute,
        name: 'my-bids',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const MyBidsPage(),
        ),
      ),

      // Provider Bids (alternative route)
      GoRoute(
        path: AppConstants.providerBidsRoute,
        name: 'provider-bids',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const MyBidsPage(),
        ),
      ),

      // Available Wishes for Bidding
      GoRoute(
        path: AppConstants.availableWishesRoute,
        name: 'available-wishes',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const AvailableWishesPage(),
        ),
      ),

      // Bid Submission
      GoRoute(
        path: '/wishes/:wishId/bid',
        name: 'bid-submission',
        pageBuilder: (context, state) {
          final wishId = state.pathParameters['wishId']!;
          return MaterialPage(
            key: state.pageKey,
            child: BidSubmissionPage(wishId: wishId),
          );
        },
      ),

      // Favorites
      GoRoute(
        path: AppConstants.favoritesRoute,
        name: 'favorites',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            appBar: AppBar(title: const Text('Favorites')),
            body: const Center(child: Text('Favorites Page')),
          ),
        ),
      ),

      // Search
      GoRoute(
        path: AppConstants.searchRoute,
        name: 'search',
        pageBuilder: (context, state) {
          final query = state.uri.queryParameters['q'] ?? '';
          return MaterialPage(
            key: state.pageKey,
            child: Scaffold(
              appBar: AppBar(title: const Text('Search')),
              body: Center(child: Text('Search Query: $query')),
            ),
          );
        },
      ),

      // Wishes Routes
      GoRoute(
        path: AppConstants.wishesRoute,
        name: 'wishes',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const WishListPage(),
        ),
      ),
      GoRoute(
        path: '${AppConstants.wishDetailsRoute}/:id',
        name: 'wish-details',
        pageBuilder: (context, state) {
          final wishId = state.pathParameters['id']!;
          return MaterialPage(
            key: state.pageKey,
            child: WishDetailPage(wishId: wishId),
          );
        },
      ),
      GoRoute(
        path: AppConstants.createWishRoute,
        name: 'create-wish',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const WishFormPage(),
        ),
      ),
      GoRoute(
        path: '${AppConstants.editWishRoute}/:id',
        name: 'edit-wish',
        pageBuilder: (context, state) {
          final wishId = state.pathParameters['id']!;
          return MaterialPage(
            key: state.pageKey,
            child: WishFormPage(wishId: wishId),
          );
        },
      ),
    ],

    // Error page
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Page not found',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                state.uri.toString(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go(AppConstants.homeRoute),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    ),
  );
});

/// Router extension methods
extension RouterExtension on BuildContext {
  /// Navigate to a named route
  void goNamed(String name, {Map<String, String>? pathParameters, Map<String, dynamic>? queryParameters}) {
    GoRouter.of(this).goNamed(
      name,
      pathParameters: pathParameters ?? <String, String>{},
      queryParameters: queryParameters ?? <String, dynamic>{},
    );
  }

  /// Push a named route
  Future<T?> pushNamed<T>(String name, {Map<String, String>? pathParameters, Map<String, dynamic>? queryParameters}) {
    return GoRouter.of(this).pushNamed<T>(
      name,
      pathParameters: pathParameters ?? <String, String>{},
      queryParameters: queryParameters ?? <String, dynamic>{},
    );
  }

  /// Pop current route
  void pop<T>([T? result]) {
    GoRouter.of(this).pop(result);
  }
}
