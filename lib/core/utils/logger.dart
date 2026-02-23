import 'package:logger/logger.dart';
import '../config/app_config.dart';

/// Application-wide logger utility
///
/// Provides consistent logging across the app with appropriate levels
/// and formatting based on the environment
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    level: AppConfig.isDebugMode ? Level.debug : Level.warning,
  );

  static final Logger _loggerNoStack = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 0,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    level: AppConfig.isDebugMode ? Level.debug : Level.warning,
  );

  AppLogger._();

  /// Log a debug message (development only)
  static void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (AppConfig.isDebugMode) {
      _logger.d(message, error: error, stackTrace: stackTrace);
    }
  }

  /// Log an info message
  static void info(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _loggerNoStack.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log a warning message
  static void warning(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log an error message
  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  /// Log a fatal/critical error
  static void fatal(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.f(message, error: error, stackTrace: stackTrace);
  }

  /// Log API requests
  static void apiRequest(String method, String endpoint, {dynamic body}) {
    if (AppConfig.isDebugMode) {
      debug('API Request: $method $endpoint ${body != null ? '\nBody: $body' : ''}');
    }
  }

  /// Log API responses
  static void apiResponse(String endpoint, int statusCode, {dynamic body}) {
    if (AppConfig.isDebugMode) {
      debug('API Response: $endpoint [$statusCode] ${body != null ? '\nBody: $body' : ''}');
    }
  }

  /// Log navigation events
  static void navigation(String route, {Map<String, dynamic>? params}) {
    if (AppConfig.isDebugMode) {
      debug('Navigation: $route ${params != null ? '\nParams: $params' : ''}');
    }
  }

  /// Log Firebase events
  static void firebase(String event, {Map<String, dynamic>? data}) {
    if (AppConfig.isDebugMode) {
      debug('Firebase: $event ${data != null ? '\nData: $data' : ''}');
    }
  }

  /// Log state changes (for debugging state management)
  static void stateChange(String provider, String event, {dynamic data}) {
    if (AppConfig.isDebugMode) {
      debug('State Change [$provider]: $event ${data != null ? '\nData: $data' : ''}');
    }
  }
}
