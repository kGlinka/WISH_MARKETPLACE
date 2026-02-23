import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../data/repositories/auth_repository.dart';

/// Auth repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthRepository(authService);
});

/// Login state notifier provider
final loginStateProvider = StateNotifierProvider<LoginStateNotifier, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginStateNotifier(authRepository);
});

/// Login state notifier
class LoginStateNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;

  LoginStateNotifier(this._authRepository) : super(const AsyncValue.data(null));

  /// Sign in with email and password
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    final result = await _authRepository.signInWithEmail(
      email: email,
      password: password,
    );

    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (_) => const AsyncValue.data(null),
    );
  }

  /// Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    state = const AsyncValue.loading();

    final result = await _authRepository.sendPasswordResetEmail(email);

    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (_) => const AsyncValue.data(null),
    );
  }
}

/// Register state notifier provider
final registerStateProvider = StateNotifierProvider<RegisterStateNotifier, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return RegisterStateNotifier(authRepository);
});

/// Register state notifier
class RegisterStateNotifier extends StateNotifier<AsyncValue<void>> {
  final AuthRepository _authRepository;

  RegisterStateNotifier(this._authRepository) : super(const AsyncValue.data(null));

  /// Sign up with email and password
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    String? displayName,
  }) async {
    state = const AsyncValue.loading();

    final result = await _authRepository.signUpWithEmail(
      email: email,
      password: password,
      username: username,
      displayName: displayName,
    );

    state = result.fold(
      (failure) => AsyncValue.error(failure.message, StackTrace.current),
      (_) => const AsyncValue.data(null),
    );
  }
}

/// Sign out action provider
final signOutProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    final authRepository = ref.read(authRepositoryProvider);
    await authRepository.signOut();
  };
});
