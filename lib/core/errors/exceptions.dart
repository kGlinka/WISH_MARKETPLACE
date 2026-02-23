/// Base class for all exceptions in the application
///
/// Exceptions are used at the data layer and converted to Failures
/// at the domain/presentation layer
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  const AppException({
    required this.message,
    this.code,
    this.details,
  });

  @override
  String toString() => 'AppException(message: $message, code: $code)';
}

// Server Exceptions
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.code,
    super.details,
  });
}

// Cache Exceptions
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
    super.details,
  });
}

// Network Exceptions
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.code,
    super.details,
  });
}

// Authentication Exceptions
class AuthenticationException extends AppException {
  const AuthenticationException({
    required super.message,
    super.code,
    super.details,
  });
}

// Authorization Exceptions
class AuthorizationException extends AppException {
  const AuthorizationException({
    required super.message,
    super.code,
    super.details,
  });
}

// Validation Exceptions
class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    required super.message,
    super.code,
    super.details,
    this.fieldErrors,
  });
}

// Payment Exceptions
class PaymentException extends AppException {
  const PaymentException({
    required super.message,
    super.code,
    super.details,
  });
}

// Firestore Exceptions
class FirestoreException extends AppException {
  const FirestoreException({
    required super.message,
    super.code,
    super.details,
  });
}

// Storage Exceptions
class StorageException extends AppException {
  const StorageException({
    required super.message,
    super.code,
    super.details,
  });
}

// Location Exceptions
class LocationException extends AppException {
  const LocationException({
    required super.message,
    super.code,
    super.details,
  });
}

// Permission Exceptions
class PermissionException extends AppException {
  const PermissionException({
    required super.message,
    super.code,
    super.details,
  });
}

// Not Found Exceptions
class NotFoundException extends AppException {
  const NotFoundException({
    required super.message,
    super.code,
    super.details,
  });
}

// Timeout Exceptions
class TimeoutException extends AppException {
  const TimeoutException({
    required super.message,
    super.code,
    super.details,
  });
}
