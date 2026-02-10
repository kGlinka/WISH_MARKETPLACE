import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/wish_model.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../data/services/wish_service.dart';
import '../../data/repositories/wish_repository.dart';

/// Provider for wish service
final wishServiceProvider = Provider<WishService>((ref) {
  return WishService();
});

/// Provider for wish repository
final wishRepositoryProvider = Provider<WishRepository>((ref) {
  final service = ref.watch(wishServiceProvider);
  return WishRepository(service);
});

/// Provider for user wishes stream
final userWishesStreamProvider = StreamProvider.autoDispose<List<WishModel>>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null || userId.isEmpty) {
    return Stream.value([]);
  }

  final repository = ref.watch(wishRepositoryProvider);
  return repository.getUserWishesStream(userId);
});

/// Provider for wishes filtered by category
final wishesByCategoryProvider = StreamProvider.autoDispose.family<List<WishModel>, WishCategory>(
  (ref, category) {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null || userId.isEmpty) {
      return Stream.value([]);
    }

    final repository = ref.watch(wishRepositoryProvider);
    return repository.getWishesByCategoryStream(userId, category);
  },
);

/// Provider for wishes filtered by status
final wishesByStatusProvider = StreamProvider.autoDispose.family<List<WishModel>, WishStatus>(
  (ref, status) {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null || userId.isEmpty) {
      return Stream.value([]);
    }

    final repository = ref.watch(wishRepositoryProvider);
    return repository.getWishesByStatusStream(userId, status);
  },
);

/// Provider for wishes filtered by priority
final wishesByPriorityProvider = StreamProvider.autoDispose.family<List<WishModel>, WishPriority>(
  (ref, priority) {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null || userId.isEmpty) {
      return Stream.value([]);
    }

    final repository = ref.watch(wishRepositoryProvider);
    return repository.getWishesByPriorityStream(userId, priority);
  },
);

/// Provider for favorite wishes
final favoriteWishesProvider = StreamProvider.autoDispose<List<WishModel>>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null || userId.isEmpty) {
    return Stream.value([]);
  }

  final repository = ref.watch(wishRepositoryProvider);
  return repository.getFavoriteWishesStream(userId);
});

/// Provider for wish statistics
final wishStatisticsProvider = FutureProvider.autoDispose<WishStatistics>((ref) async {
  final userId = ref.watch(currentUserIdProvider);
  if (userId == null || userId.isEmpty) {
    return WishStatistics(
      totalWishes: 0,
      activeWishes: 0,
      inProgressWishes: 0,
      completedWishes: 0,
      deferredWishes: 0,
      categoryCount: {},
    );
  }

  final repository = ref.watch(wishRepositoryProvider);
  final result = await repository.getWishStatistics(userId);

  return result.fold(
    (failure) => throw Exception(failure.message),
    (stats) => stats,
  );
});

/// Provider for selected wish filter
enum WishFilter {
  all,
  active,
  inProgress,
  completed,
  deferred,
  favorites,
}

final selectedWishFilterProvider = StateProvider<WishFilter>((ref) => WishFilter.all);

/// Provider for selected category filter
final selectedCategoryFilterProvider = StateProvider<WishCategory?>((ref) => null);

/// Provider for search query
final wishSearchQueryProvider = StateProvider<String>((ref) => '');

/// Provider for filtered wishes based on current filters
final filteredWishesProvider = StreamProvider.autoDispose<List<WishModel>>((ref) {
  final filter = ref.watch(selectedWishFilterProvider);
  final category = ref.watch(selectedCategoryFilterProvider);
  final userId = ref.watch(currentUserIdProvider);

  if (userId == null || userId.isEmpty) {
    return Stream.value([]);
  }

  final repository = ref.watch(wishRepositoryProvider);

  // Apply status filter
  Stream<List<WishModel>> wishesStream;
  switch (filter) {
    case WishFilter.active:
      wishesStream = repository.getWishesByStatusStream(userId, WishStatus.active);
      break;
    case WishFilter.inProgress:
      wishesStream = repository.getWishesByStatusStream(userId, WishStatus.inProgress);
      break;
    case WishFilter.completed:
      wishesStream = repository.getWishesByStatusStream(userId, WishStatus.completed);
      break;
    case WishFilter.deferred:
      wishesStream = repository.getWishesByStatusStream(userId, WishStatus.deferred);
      break;
    case WishFilter.favorites:
      wishesStream = repository.getFavoriteWishesStream(userId);
      break;
    case WishFilter.all:
      wishesStream = repository.getUserWishesStream(userId);
      break;
  }

  // Apply category filter if selected
  if (category != null) {
    return wishesStream.map((wishes) =>
        wishes.where((wish) => wish.category == category).toList());
  }

  return wishesStream;
});

/// State notifier for wish form
class WishFormNotifier extends StateNotifier<WishFormState> {
  final WishRepository _repository;

  WishFormNotifier(this._repository) : super(const WishFormState.initial());

  Future<void> createWish(WishModel wish) async {
    state = const WishFormState.loading();

    final result = await _repository.createWish(wish);

    result.fold(
      (failure) => state = WishFormState.error(failure.message),
      (wishId) => state = WishFormState.success(wishId),
    );
  }

  Future<void> updateWish(String wishId, WishModel wish) async {
    state = const WishFormState.loading();

    final result = await _repository.updateWish(wishId, wish);

    result.fold(
      (failure) => state = WishFormState.error(failure.message),
      (_) => state = const WishFormState.success('updated'),
    );
  }

  Future<void> deleteWish(String wishId) async {
    state = const WishFormState.loading();

    final result = await _repository.deleteWish(wishId);

    result.fold(
      (failure) => state = WishFormState.error(failure.message),
      (_) => state = const WishFormState.success('deleted'),
    );
  }

  void reset() {
    state = const WishFormState.initial();
  }
}

/// Wish form state
class WishFormState {
  final bool isLoading;
  final String? error;
  final String? successMessage;

  const WishFormState({
    this.isLoading = false,
    this.error,
    this.successMessage,
  });

  const WishFormState.initial() : this();
  const WishFormState.loading() : this(isLoading: true);
  const WishFormState.error(String message) : this(error: message);
  const WishFormState.success(String message) : this(successMessage: message);
}

/// Provider for wish form notifier
final wishFormProvider = StateNotifierProvider.autoDispose<WishFormNotifier, WishFormState>((ref) {
  final repository = ref.watch(wishRepositoryProvider);
  return WishFormNotifier(repository);
});

/// State notifier for wish actions (toggle favorite, update progress, mark complete)
class WishActionsNotifier extends StateNotifier<AsyncValue<void>> {
  final WishRepository _repository;

  WishActionsNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<void> toggleFavorite(String wishId, bool isFavorite) async {
    state = const AsyncValue.loading();

    final result = await _repository.toggleFavorite(wishId, isFavorite);

    result.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (_) => state = const AsyncValue.data(null),
    );
  }

  Future<void> updateProgress(String wishId, int progress) async {
    state = const AsyncValue.loading();

    final result = await _repository.updateWishProgress(wishId, progress);

    result.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (_) => state = const AsyncValue.data(null),
    );
  }

  Future<void> markCompleted(String wishId) async {
    state = const AsyncValue.loading();

    final result = await _repository.markWishCompleted(wishId);

    result.fold(
      (failure) => state = AsyncValue.error(failure.message, StackTrace.current),
      (_) => state = const AsyncValue.data(null),
    );
  }
}

/// Provider for wish actions notifier
final wishActionsProvider = StateNotifierProvider.autoDispose<WishActionsNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(wishRepositoryProvider);
  return WishActionsNotifier(repository);
});
