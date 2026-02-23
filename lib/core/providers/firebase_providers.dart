import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';

/// Firebase service provider
final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

/// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

/// Firestore service provider
final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

/// Auth state stream provider
///
/// Provides real-time authentication state changes
final authStateStreamProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

/// Current user provider
///
/// Provides the currently authenticated user
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateStreamProvider);
  return authState.maybeWhen(
    data: (user) => user,
    orElse: () => null,
  );
});

/// Is authenticated provider
///
/// Returns true if user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
});

/// Current user ID provider
///
/// Provides the current user's ID
final currentUserIdProvider = Provider<String?>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.uid;
});
