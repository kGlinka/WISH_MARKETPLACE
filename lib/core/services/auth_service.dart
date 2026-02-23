import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../errors/exceptions.dart';
import '../utils/logger.dart';
import '../constants/app_constants.dart';

/// Authentication service wrapping Firebase Auth
///
/// Provides methods for user authentication and session management
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get current user
  User? get currentUser => _auth.currentUser;

  /// Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  /// Check if user is authenticated
  bool get isAuthenticated => _auth.currentUser != null;

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Sign up with email and password
  Future<User> signUpWithEmail({
    required String email,
    required String password,
    required String username,
    String? displayName,
  }) async {
    try {
      AppLogger.info('Signing up user: $email');

      // Create user account
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw const AuthenticationException(
          message: 'Failed to create user account',
        );
      }

      // Update display name
      await user.updateDisplayName(displayName ?? username);

      // Send email verification
      await user.sendEmailVerification();

      // Create user document in Firestore
      await _createUserDocument(
        userId: user.uid,
        email: email,
        username: username,
        displayName: displayName,
      );

      AppLogger.info('User signed up successfully: ${user.uid}');
      return user;
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.error('Sign up failed', e, stackTrace);
      throw _handleAuthException(e);
    } catch (e, stackTrace) {
      AppLogger.error('Sign up failed', e, stackTrace);
      throw AuthenticationException(
        message: 'Failed to sign up: ${e.toString()}',
      );
    }
  }

  /// Sign in with email and password
  Future<User> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      AppLogger.info('Signing in user: $email');

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw const AuthenticationException(
          message: 'Failed to sign in',
        );
      }

      // Update last active timestamp
      await _updateLastActive(user.uid);

      AppLogger.info('User signed in successfully: ${user.uid}');
      return user;
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.error('Sign in failed', e, stackTrace);
      throw _handleAuthException(e);
    } catch (e, stackTrace) {
      AppLogger.error('Sign in failed', e, stackTrace);
      throw AuthenticationException(
        message: 'Failed to sign in: ${e.toString()}',
      );
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      AppLogger.info('Signing out user: $currentUserId');
      await _auth.signOut();
      AppLogger.info('User signed out successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Sign out failed', e, stackTrace);
      throw AuthenticationException(
        message: 'Failed to sign out: ${e.toString()}',
      );
    }
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      AppLogger.info('Sending password reset email to: $email');
      await _auth.sendPasswordResetEmail(email: email);
      AppLogger.info('Password reset email sent');
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.error('Password reset failed', e, stackTrace);
      throw _handleAuthException(e);
    } catch (e, stackTrace) {
      AppLogger.error('Password reset failed', e, stackTrace);
      throw AuthenticationException(
        message: 'Failed to send password reset email: ${e.toString()}',
      );
    }
  }

  /// Update password
  Future<void> updatePassword(String newPassword) async {
    try {
      final user = currentUser;
      if (user == null) {
        throw const AuthenticationException(
          message: 'No user signed in',
        );
      }

      AppLogger.info('Updating password for user: ${user.uid}');
      await user.updatePassword(newPassword);
      AppLogger.info('Password updated successfully');
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.error('Password update failed', e, stackTrace);
      throw _handleAuthException(e);
    } catch (e, stackTrace) {
      AppLogger.error('Password update failed', e, stackTrace);
      throw AuthenticationException(
        message: 'Failed to update password: ${e.toString()}',
      );
    }
  }

  /// Update email
  Future<void> updateEmail(String newEmail) async {
    try {
      final user = currentUser;
      if (user == null) {
        throw const AuthenticationException(
          message: 'No user signed in',
        );
      }

      AppLogger.info('Updating email for user: ${user.uid}');
      await user.verifyBeforeUpdateEmail(newEmail);
      AppLogger.info('Email updated successfully');
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.error('Email update failed', e, stackTrace);
      throw _handleAuthException(e);
    } catch (e, stackTrace) {
      AppLogger.error('Email update failed', e, stackTrace);
      throw AuthenticationException(
        message: 'Failed to update email: ${e.toString()}',
      );
    }
  }

  /// Delete user account
  Future<void> deleteAccount() async {
    try {
      final user = currentUser;
      if (user == null) {
        throw const AuthenticationException(
          message: 'No user signed in',
        );
      }

      AppLogger.info('Deleting account for user: ${user.uid}');

      // Delete user document from Firestore
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .delete();

      // Delete Firebase Auth account
      await user.delete();

      AppLogger.info('Account deleted successfully');
    } on FirebaseAuthException catch (e, stackTrace) {
      AppLogger.error('Account deletion failed', e, stackTrace);
      throw _handleAuthException(e);
    } catch (e, stackTrace) {
      AppLogger.error('Account deletion failed', e, stackTrace);
      throw AuthenticationException(
        message: 'Failed to delete account: ${e.toString()}',
      );
    }
  }

  /// Create user document in Firestore
  Future<void> _createUserDocument({
    required String userId,
    required String email,
    required String username,
    String? displayName,
  }) async {
    try {
      await _firestore.collection(AppConstants.usersCollection).doc(userId).set({
        'id': userId,
        'email': email,
        'username': username,
        'displayName': displayName ?? username,
        'roles': ['buyer', 'seller'],
        'createdAt': FieldValue.serverTimestamp(),
        'lastActiveAt': FieldValue.serverTimestamp(),
        'isActive': true,
        'isVerified': false,
        'isBlocked': false,
        'stats': {
          'listingsCount': 0,
          'activeListingsCount': 0,
          'soldListingsCount': 0,
          'bidsPlacedCount': 0,
          'bidsWonCount': 0,
          'reviewsCount': 0,
          'averageRating': 0.0,
          'followersCount': 0,
          'followingCount': 0,
        },
      });

      AppLogger.info('User document created: $userId');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to create user document', e, stackTrace);
      rethrow;
    }
  }

  /// Update last active timestamp
  Future<void> _updateLastActive(String userId) async {
    try {
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(userId)
          .update({
        'lastActiveAt': FieldValue.serverTimestamp(),
      });
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update last active', e, stackTrace);
    }
  }

  /// Handle Firebase Auth exceptions
  AuthenticationException _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return const AuthenticationException(
          message: 'This email is already registered',
          code: 'email-already-in-use',
        );
      case 'invalid-email':
        return const AuthenticationException(
          message: 'Invalid email address',
          code: 'invalid-email',
        );
      case 'weak-password':
        return const AuthenticationException(
          message: 'Password is too weak',
          code: 'weak-password',
        );
      case 'user-not-found':
        return const AuthenticationException(
          message: 'No account found with this email',
          code: 'user-not-found',
        );
      case 'wrong-password':
        return const AuthenticationException(
          message: 'Incorrect password',
          code: 'wrong-password',
        );
      case 'user-disabled':
        return const AuthenticationException(
          message: 'This account has been disabled',
          code: 'user-disabled',
        );
      case 'too-many-requests':
        return const AuthenticationException(
          message: 'Too many attempts. Please try again later',
          code: 'too-many-requests',
        );
      case 'requires-recent-login':
        return const AuthenticationException(
          message: 'Please sign in again to continue',
          code: 'requires-recent-login',
        );
      default:
        return AuthenticationException(
          message: e.message ?? 'Authentication failed',
          code: e.code,
        );
    }
  }
}
