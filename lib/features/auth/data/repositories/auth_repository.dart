import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/utils/logger.dart';

/// Authentication repository
///
/// Handles authentication-related data operations and error conversion
class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  /// Sign up with email and password
  Future<Either<Failure, User>> signUpWithEmail({
    required String email,
    required String password,
    required String username,
    String? displayName,
  }) async {
    try {
      final user = await _authService.signUpWithEmail(
        email: email,
        password: password,
        username: username,
        displayName: displayName,
      );
      return Right(user);
    } on AuthenticationException catch (e) {
      AppLogger.error('Sign up failed', e);
      return Left(AuthenticationFailure(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      AppLogger.error('Unexpected error during sign up', e);
      return Left(UnknownFailure(
        message: 'An unexpected error occurred during sign up',
      ));
    }
  }

  /// Sign in with email and password
  Future<Either<Failure, User>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _authService.signInWithEmail(
        email: email,
        password: password,
      );
      return Right(user);
    } on AuthenticationException catch (e) {
      AppLogger.error('Sign in failed', e);
      return Left(AuthenticationFailure(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      AppLogger.error('Unexpected error during sign in', e);
      return Left(UnknownFailure(
        message: 'An unexpected error occurred during sign in',
      ));
    }
  }

  /// Sign out
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authService.signOut();
      return const Right(null);
    } on AuthenticationException catch (e) {
      AppLogger.error('Sign out failed', e);
      return Left(AuthenticationFailure(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      AppLogger.error('Unexpected error during sign out', e);
      return Left(UnknownFailure(
        message: 'An unexpected error occurred during sign out',
      ));
    }
  }

  /// Send password reset email
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email);
      return const Right(null);
    } on AuthenticationException catch (e) {
      AppLogger.error('Password reset failed', e);
      return Left(AuthenticationFailure(
        message: e.message,
        code: e.code,
      ));
    } catch (e) {
      AppLogger.error('Unexpected error during password reset', e);
      return Left(UnknownFailure(
        message: 'An unexpected error occurred',
      ));
    }
  }

  /// Get current user
  User? getCurrentUser() {
    return _authService.currentUser;
  }

  /// Check if user is authenticated
  bool isAuthenticated() {
    return _authService.isAuthenticated;
  }

  /// Stream of authentication state changes
  Stream<User?> authStateChanges() {
    return _authService.authStateChanges;
  }
}
