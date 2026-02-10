import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
///
/// Using the Failure pattern to handle errors in a functional way
/// All failures are immutable and comparable using Equatable
abstract class Failure extends Equatable {
  final String message;
  final String? code;
  final dynamic details;

  const Failure({
    required this.message,
    this.code,
    this.details,
  });

  @override
  List<Object?> get props => [message, code, details];

  @override
  String toString() => 'Failure(message: $message, code: $code)';
}

// Server Failures
class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
    super.details,
  });
}

// Cache Failures
class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
    super.details,
  });
}

// Network Failures
class NetworkFailure extends Failure {
  const NetworkFailure({
    required super.message,
    super.code,
    super.details,
  });
}

// Authentication Failures
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({
    required super.message,
    super.code,
    super.details,
  });
}

// Authorization Failures
class AuthorizationFailure extends Failure {
  const AuthorizationFailure({
    required super.message,
    super.code,
    super.details,
  });
}

// Validation Failures
class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({
    required super.message,
    super.code,
    super.details,
    this.fieldErrors,
  });

  @override
  List<Object?> get props => [message, code, details, fieldErrors];
}

// Payment Failures
class PaymentFailure extends Failure {
  const PaymentFailure({
    required super.message,
    super.code,
    super.details,
  });
}

// Firestore Failures
class FirestoreFailure extends Failure {
  const FirestoreFailure({
    required super.message,
    super.code,
    super.details,
  });
}

// Storage Failures
class StorageFailure extends Failure {
  const StorageFailure({
    required super.message,
    super.code,
    super.details,
  });
}

// Location Failures
class LocationFailure extends Failure {
  const LocationFailure({
    required super.message,
    super.code,
    super.details,
  });
}

// Permission Failures
class PermissionFailure extends Failure {
  const PermissionFailure({
    required super.message,
    super.code,
    super.details,
  });
}

// Not Found Failures
class NotFoundFailure extends Failure {
  const NotFoundFailure({
    required super.message,
    super.code,
    super.details,
  });
}

// Timeout Failures
class TimeoutFailure extends Failure {
  const TimeoutFailure({
    required super.message,
    super.code,
    super.details,
  });
}

// Unknown Failures
class UnknownFailure extends Failure {
  const UnknownFailure({
    required super.message,
    super.code,
    super.details,
  });
}
