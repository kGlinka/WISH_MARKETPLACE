import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/bid_model.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../data/services/bid_service.dart';
import '../../data/repositories/bid_repository.dart';

/// Provider for bid service
final bidServiceProvider = Provider<BidService>((ref) {
  return BidService();
});

/// Provider for bid repository
final bidRepositoryProvider = Provider<BidRepository>((ref) {
  final service = ref.watch(bidServiceProvider);
  return BidRepository(service);
});

/// Stream provider for bids on a specific wish
///
/// Returns real-time updates of all bids for a wish
final wishBidsStreamProvider = StreamProvider.autoDispose.family<List<BidModel>, String>(
  (ref, wishId) {
    final repository = ref.watch(bidRepositoryProvider);
    return repository.streamBidsForWish(wishId: wishId);
  },
);

/// Stream provider for active bids on a specific wish
///
/// Returns real-time updates of only active bids
final wishActiveBidsStreamProvider = StreamProvider.autoDispose.family<List<BidModel>, String>(
  (ref, wishId) {
    final repository = ref.watch(bidRepositoryProvider);
    return repository.streamBidsForWish(
      wishId: wishId,
      status: BidStatus.active,
    );
  },
);

/// Stream provider for the highest bid on a wish
///
/// Returns real-time updates of the current highest bid
final highestBidStreamProvider = StreamProvider.autoDispose.family<BidModel?, String>(
  (ref, wishId) {
    final repository = ref.watch(bidRepositoryProvider);
    return repository.streamHighestBid(wishId: wishId);
  },
);

/// Stream provider for all bids placed by the current provider
///
/// Returns real-time updates of all provider's bids
final providerBidsStreamProvider = StreamProvider.autoDispose<List<BidModel>>(
  (ref) {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) {
      return Stream.value([]);
    }

    final repository = ref.watch(bidRepositoryProvider);
    return repository.streamProviderBids(providerId: userId);
  },
);

/// Stream provider for active bids placed by the current provider
///
/// Returns real-time updates of only active provider bids
final providerActiveBidsStreamProvider = StreamProvider.autoDispose<List<BidModel>>(
  (ref) {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) {
      return Stream.value([]);
    }

    final repository = ref.watch(bidRepositoryProvider);
    return repository.streamProviderBids(
      providerId: userId,
      status: BidStatus.active,
    );
  },
);

/// Stream provider for winning bids by the current provider
final providerWinningBidsStreamProvider = StreamProvider.autoDispose<List<BidModel>>(
  (ref) {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) {
      return Stream.value([]);
    }

    final repository = ref.watch(bidRepositoryProvider);
    return repository.streamProviderBids(
      providerId: userId,
      status: BidStatus.winning,
    );
  },
);

/// Stream provider for won bids by the current provider
final providerWonBidsStreamProvider = StreamProvider.autoDispose<List<BidModel>>(
  (ref) {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) {
      return Stream.value([]);
    }

    final repository = ref.watch(bidRepositoryProvider);
    return repository.streamProviderBids(
      providerId: userId,
      status: BidStatus.won,
    );
  },
);

/// State provider for bid filter
enum BidFilter {
  all,
  active,
  winning,
  won,
  lost,
  cancelled,
}

final selectedBidFilterProvider = StateProvider<BidFilter>((ref) => BidFilter.all);

/// Filtered provider bids based on selected filter
final filteredProviderBidsStreamProvider = StreamProvider.autoDispose<List<BidModel>>(
  (ref) {
    final filter = ref.watch(selectedBidFilterProvider);
    final userId = ref.watch(currentUserIdProvider);

    if (userId == null) {
      return Stream.value([]);
    }

    final repository = ref.watch(bidRepositoryProvider);

    // Map filter to bid status
    BidStatus? status;
    switch (filter) {
      case BidFilter.active:
        status = BidStatus.active;
        break;
      case BidFilter.winning:
        status = BidStatus.winning;
        break;
      case BidFilter.won:
        status = BidStatus.won;
        break;
      case BidFilter.lost:
        status = BidStatus.lost;
        break;
      case BidFilter.cancelled:
        status = BidStatus.cancelled;
        break;
      case BidFilter.all:
        status = null;
        break;
    }

    return repository.streamProviderBids(
      providerId: userId,
      status: status,
    );
  },
);

/// State notifier for bid form actions
class BidFormNotifier extends StateNotifier<BidFormState> {
  final BidRepository _repository;

  BidFormNotifier(this._repository) : super(const BidFormState.initial());

  /// Submit a new bid
  Future<void> submitBid({
    required String wishId,
    required BidModel bid,
  }) async {
    state = const BidFormState.loading();

    final result = await _repository.createBid(
      wishId: wishId,
      bid: bid,
    );

    result.fold(
      (failure) => state = BidFormState.error(failure.message),
      (bidId) => state = BidFormState.success(bidId),
    );
  }

  /// Update an existing bid
  Future<void> updateBid({
    required String wishId,
    required String bidId,
    required Map<String, dynamic> updates,
  }) async {
    state = const BidFormState.loading();

    final result = await _repository.updateBid(
      wishId: wishId,
      bidId: bidId,
      updates: updates,
    );

    result.fold(
      (failure) => state = BidFormState.error(failure.message),
      (_) => state = const BidFormState.success('updated'),
    );
  }

  /// Cancel a bid
  Future<void> cancelBid({
    required String wishId,
    required String bidId,
    String? reason,
  }) async {
    state = const BidFormState.loading();

    final result = await _repository.cancelBid(
      wishId: wishId,
      bidId: bidId,
      cancellationReason: reason,
    );

    result.fold(
      (failure) => state = BidFormState.error(failure.message),
      (_) => state = const BidFormState.success('cancelled'),
    );
  }

  /// Accept a bid (for wish owners)
  Future<void> acceptBid({
    required String wishId,
    required String bidId,
  }) async {
    state = const BidFormState.loading();

    final result = await _repository.acceptBid(
      wishId: wishId,
      bidId: bidId,
    );

    result.fold(
      (failure) => state = BidFormState.error(failure.message),
      (_) => state = const BidFormState.success('accepted'),
    );
  }

  /// Check if provider has already bid
  Future<bool> hasProviderBidOnWish({
    required String wishId,
    required String providerId,
  }) async {
    final result = await _repository.hasProviderBidOnWish(
      wishId: wishId,
      providerId: providerId,
    );

    return result.fold(
      (failure) => false,
      (hasBid) => hasBid,
    );
  }

  void reset() {
    state = const BidFormState.initial();
  }
}

/// Bid form state
class BidFormState {
  final bool isLoading;
  final String? error;
  final String? successMessage;

  const BidFormState({
    this.isLoading = false,
    this.error,
    this.successMessage,
  });

  const BidFormState.initial() : this();
  const BidFormState.loading() : this(isLoading: true);
  const BidFormState.error(String message) : this(error: message);
  const BidFormState.success(String message) : this(successMessage: message);
}

/// Provider for bid form notifier
final bidFormProvider = StateNotifierProvider.autoDispose<BidFormNotifier, BidFormState>((ref) {
  final repository = ref.watch(bidRepositoryProvider);
  return BidFormNotifier(repository);
});

/// Provider to check if user has bid on a specific wish
final hasProviderBidProvider = FutureProvider.autoDispose.family<bool, String>(
  (ref, wishId) async {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) {
      return false;
    }

    final repository = ref.watch(bidRepositoryProvider);
    final result = await repository.hasProviderBidOnWish(
      wishId: wishId,
      providerId: userId,
    );

    return result.fold(
      (failure) => false,
      (hasBid) => hasBid,
    );
  },
);

/// Provider to get provider's bid on a specific wish
final providerBidOnWishProvider = FutureProvider.autoDispose.family<BidModel?, String>(
  (ref, wishId) async {
    final userId = ref.watch(currentUserIdProvider);
    if (userId == null) {
      return null;
    }

    final repository = ref.watch(bidRepositoryProvider);
    final result = await repository.getProviderBidOnWish(
      wishId: wishId,
      providerId: userId,
    );

    return result.fold(
      (failure) => null,
      (bid) => bid,
    );
  },
);
