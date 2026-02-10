/// Application-wide constant values
///
/// Contains all static constant values used throughout the app
/// including API endpoints, storage keys, collection names, etc.
class AppConstants {
  AppConstants._();

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String listingsCollection = 'listings';
  static const String bidsCollection = 'bids';
  static const String transactionsCollection = 'transactions';
  static const String escrowCollection = 'escrow';
  static const String reviewsCollection = 'reviews';
  static const String messagesCollection = 'messages';
  static const String notificationsCollection = 'notifications';
  static const String reportsCollection = 'reports';
  static const String categoriesCollection = 'categories';
  static const String wishesCollection = 'wishes';

  // Firebase Storage Paths
  static const String userAvatarsPath = 'user_avatars';
  static const String listingImagesPath = 'listing_images';
  static const String listingVideosPath = 'listing_videos';
  static const String verificationDocumentsPath = 'verification_docs';

  // Local Storage Keys
  static const String userIdKey = 'user_id';
  static const String authTokenKey = 'auth_token';
  static const String userPreferencesKey = 'user_preferences';
  static const String notificationSettingsKey = 'notification_settings';
  static const String lastSyncTimeKey = 'last_sync_time';
  static const String cachedUserDataKey = 'cached_user_data';
  static const String themePreferenceKey = 'theme_preference';
  static const String languagePreferenceKey = 'language_preference';
  static const String locationPermissionKey = 'location_permission';
  static const String onboardingCompletedKey = 'onboarding_completed';

  // API Endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String verifyEmailEndpoint = '/auth/verify-email';
  static const String resetPasswordEndpoint = '/auth/reset-password';
  static const String refreshTokenEndpoint = '/auth/refresh-token';

  // Routes (defined separately in routing configuration)
  static const String splashRoute = '/';
  static const String onboardingRoute = '/onboarding';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String listingDetailsRoute = '/listing';
  static const String createListingRoute = '/create-listing';
  static const String profileRoute = '/profile';
  static const String settingsRoute = '/settings';
  static const String messagesRoute = '/messages';
  static const String notificationsRoute = '/notifications';
  static const String myListingsRoute = '/my-listings';
  static const String myBidsRoute = '/my-bids';
  static const String favoritesRoute = '/favorites';
  static const String searchRoute = '/search';
  static const String wishesRoute = '/wishes';
  static const String wishDetailsRoute = '/wish';
  static const String createWishRoute = '/create-wish';
  static const String editWishRoute = '/edit-wish';
  static const String availableWishesRoute = '/available-wishes';
  static const String bidSubmissionRoute = '/bid-submission';
  static const String providerBidsRoute = '/provider-bids';

  // Validation
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 128;
  static const int minUsernameLength = 3;
  static const int maxUsernameLength = 30;
  static const int maxBioLength = 500;
  static const int maxListingTitleLength = 100;
  static const int maxListingDescriptionLength = 2000;

  // Regex Patterns
  static const String emailPattern =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String phonePattern = r'^\+?[1-9]\d{1,14}$';
  static const String usernamePattern = r'^[a-zA-Z0-9_]+$';
  static const String urlPattern =
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)$';

  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayDateTimeFormat = 'MMM dd, yyyy HH:mm';

  // Animation Durations
  static const int shortAnimationDuration = 200; // milliseconds
  static const int mediumAnimationDuration = 300; // milliseconds
  static const int longAnimationDuration = 500; // milliseconds

  // Network
  static const int maxRetryAttempts = 3;
  static const int retryDelay = 2; // seconds

  // Marketplace Categories
  static const List<String> defaultCategories = [
    'Smartwatches',
    'Fitness Trackers',
    'Luxury Watches',
    'Sports Watches',
    'Smart Bands',
    'Accessories',
    'Parts & Repairs',
  ];

  // Payment Methods
  static const String paymentMethodCard = 'card';
  static const String paymentMethodBank = 'bank_transfer';
  static const String paymentMethodWallet = 'wallet';

  // Escrow Status
  static const String escrowPending = 'pending';
  static const String escrowFunded = 'funded';
  static const String escrowReleased = 'released';
  static const String escrowRefunded = 'refunded';
  static const String escrowDisputed = 'disputed';

  // User Roles
  static const String roleBuyer = 'buyer';
  static const String roleSeller = 'seller';
  static const String roleAdmin = 'admin';
  static const String roleModerator = 'moderator';

  // Notification Types
  static const String notificationBidPlaced = 'bid_placed';
  static const String notificationBidOutbid = 'bid_outbid';
  static const String notificationBidWon = 'bid_won';
  static const String notificationBidExpired = 'bid_expired';
  static const String notificationMessage = 'message';
  static const String notificationPayment = 'payment';
  static const String notificationShipment = 'shipment';
  static const String notificationReview = 'review';
}
