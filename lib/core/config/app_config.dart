/// Application-wide configuration constants
///
/// This file contains all configuration values that control app behavior
/// across different environments (development, staging, production)
class AppConfig {
  // Singleton pattern to ensure single instance across the app
  AppConfig._();
  static final AppConfig instance = AppConfig._();

  // Environment configuration
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  // API Configuration
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.wishmarketplace.com',
  );

  // Firebase Configuration
  // Note: Firebase is initialized using google-services.json and GoogleService-Info.plist
  // These values are for reference and logging purposes
  static const String firebaseProjectId = 'wish-marketplace';

  // Stripe Configuration (IMPORTANT: Never commit actual keys to version control)
  // Use environment variables or secure storage for production
  static const String stripePublishableKey = String.fromEnvironment(
    'STRIPE_PUBLISHABLE_KEY',
    defaultValue: 'pk_test_YOUR_TEST_KEY',
  );

  // App Configuration
  static const String appName = 'Wish Marketplace';
  static const String appVersion = '1.0.0';
  static const int buildNumber = 1;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;

  // Bidding Configuration
  static const int minimumBidIncrement = 100; // in cents
  static const int bidTimerDuration = 86400; // 24 hours in seconds
  static const int autoExtendTime = 300; // 5 minutes in seconds

  // Upload Limits
  static const int maxImageSize = 5242880; // 5MB in bytes
  static const int maxImagesPerListing = 10;
  static const int maxVideoSize = 52428800; // 50MB in bytes

  // Cache Configuration
  static const int cacheExpiration = 3600; // 1 hour in seconds
  static const int maxCacheSize = 104857600; // 100MB in bytes

  // Geolocation
  static const double defaultLocationRadius = 50.0; // km
  static const double maxLocationRadius = 500.0; // km

  // Timeouts
  static const int defaultTimeout = 30; // seconds
  static const int uploadTimeout = 120; // seconds

  // Feature Flags
  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enablePerformanceMonitoring = true;
  static const bool enableVoiceSearch = true;
  static const bool enableWearSupport = true;

  // Debug Configuration
  static bool get isDebugMode => environment == 'development';
  static bool get isProduction => environment == 'production';
  static bool get isStaging => environment == 'staging';
}
