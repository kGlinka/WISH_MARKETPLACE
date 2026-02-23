import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../utils/logger.dart';

/// Firebase initialization and configuration service
///
/// Handles Firebase app initialization and FCM setup
class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  bool _initialized = false;
  String? _fcmToken;

  bool get isInitialized => _initialized;
  String? get fcmToken => _fcmToken;

  /// Initialize Firebase
  ///
  /// Must be called before runApp() in main.dart
  /// Returns true if initialization was successful
  Future<bool> initialize() async {
    if (_initialized) {
      AppLogger.warning('Firebase already initialized');
      return true;
    }

    try {
      AppLogger.info('Initializing Firebase...');

      // Initialize Firebase
      await Firebase.initializeApp();

      _initialized = true;
      AppLogger.info('Firebase initialized successfully');

      return true;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize Firebase', e, stackTrace);
      return false;
    }
  }

  /// Initialize Firebase Cloud Messaging
  ///
  /// Request notification permissions and get FCM token
  Future<void> initializeFCM() async {
    if (!_initialized) {
      throw Exception('Firebase must be initialized before FCM');
    }

    try {
      AppLogger.info('Initializing Firebase Cloud Messaging...');

      final messaging = FirebaseMessaging.instance;

      // Request notification permissions (iOS)
      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        AppLogger.info('Notification permissions granted');
      } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
        AppLogger.info('Notification permissions granted provisionally');
      } else {
        AppLogger.warning('Notification permissions denied');
      }

      // Get FCM token
      _fcmToken = await messaging.getToken();
      AppLogger.info('FCM Token: $_fcmToken');

      // Listen for token refresh
      messaging.onTokenRefresh.listen((token) {
        _fcmToken = token;
        AppLogger.info('FCM Token refreshed: $token');
        // TODO: Update token in backend/Firestore
      });

      // Configure foreground notification presentation
      await messaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      AppLogger.info('Firebase Cloud Messaging initialized successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize FCM', e, stackTrace);
    }
  }

  /// Handle background messages
  ///
  /// This must be a top-level function for background message handling
  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    AppLogger.info('Handling background message: ${message.messageId}');
    // TODO: Process background message
  }

  /// Set up message handlers
  Future<void> setupMessageHandlers() async {
    if (!_initialized) {
      throw Exception('Firebase must be initialized before setting up message handlers');
    }

    try {
      final messaging = FirebaseMessaging.instance;

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        AppLogger.info('Received foreground message: ${message.messageId}');
        AppLogger.debug('Message data: ${message.data}');

        if (message.notification != null) {
          AppLogger.info(
            'Message notification: ${message.notification!.title} - ${message.notification!.body}',
          );
          // TODO: Show local notification
        }
      });

      // Handle notification tap when app is in background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        AppLogger.info('Notification tapped: ${message.messageId}');
        // TODO: Navigate to appropriate screen based on message data
      });

      // Check if app was opened from a terminated state notification
      final initialMessage = await messaging.getInitialMessage();
      if (initialMessage != null) {
        AppLogger.info('App opened from notification: ${initialMessage.messageId}');
        // TODO: Navigate to appropriate screen based on message data
      }

      // Set background message handler
      FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

      AppLogger.info('Message handlers set up successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to setup message handlers', e, stackTrace);
    }
  }
}
