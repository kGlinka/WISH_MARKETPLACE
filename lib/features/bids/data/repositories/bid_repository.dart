import 'package:dartz/dartz.dart';
import '../../../../core/models/bid_model.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../services/bid_service.dart';

/// Repository for bid data operations
///
/// Handles data operations and converts exceptions to failures
class BidRepository {
  final BidService _bidService;

  BidRepository(this._bidService);

  /// Create a new bid
  Future<Either<Failure, String>> createBid({
    required String wishId,
    required BidModel bid,
  }) async {
    try {
      final bidId = await _bidService.createBid(
        wishId: wishId,
        bid: bid,
      );
      return Right(bidId);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to create bid', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error creating bid', e);
      return Left(UnknownFailure(message: 'Failed to create bid: ${e.toString()}'));
    }
  }

  /// Update an existing bid
  Future<Either<Failure, void>> updateBid({
    required String wishId,
    required String bidId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      await _bidService.updateBid(
        wishId: wishId,
        bidId: bidId,
        updates: updates,
      );
      return const Right(null);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to update bid', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error updating bid', e);
      return Left(UnknownFailure(message: 'Failed to update bid: ${e.toString()}'));
    }
  }

  /// Cancel/withdraw a bid
  Future<Either<Failure, void>> cancelBid({
    required String wishId,
    required String bidId,
    String? cancellationReason,
  }) async {
    try {
      await _bidService.cancelBid(
        wishId: wishId,
        bidId: bidId,
        cancellationReason: cancellationReason,
      );
      return const Right(null);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to cancel bid', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error cancelling bid', e);
      return Left(UnknownFailure(message: 'Failed to cancel bid: ${e.toString()}'));
    }
  }

  /// Delete a bid
  Future<Either<Failure, void>> deleteBid({
    required String wishId,
    required String bidId,
  }) async {
    try {
      await _bidService.deleteBid(
        wishId: wishId,
        bidId: bidId,
      );
      return const Right(null);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to delete bid', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error deleting bid', e);
      return Left(UnknownFailure(message: 'Failed to delete bid: ${e.toString()}'));
    }
  }

  /// Get a single bid
  Future<Either<Failure, BidModel?>> getBid({
    required String wishId,
    required String bidId,
  }) async {
    try {
      final bid = await _bidService.getBid(
        wishId: wishId,
        bidId: bidId,
      );
      return Right(bid);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to get bid', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error getting bid', e);
      return Left(UnknownFailure(message: 'Failed to get bid: ${e.toString()}'));
    }
  }

  /// Get all bids for a wish
  Future<Either<Failure, List<BidModel>>> getBidsForWish({
    required String wishId,
    BidStatus? status,
  }) async {
    try {
      final bids = await _bidService.getBidsForWish(
        wishId: wishId,
        status: status,
      );
      return Right(bids);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to get bids for wish', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error getting bids for wish', e);
      return Left(UnknownFailure(message: 'Failed to get bids: ${e.toString()}'));
    }
  }

  /// Stream all bids for a wish with real-time updates
  Stream<List<BidModel>> streamBidsForWish({
    required String wishId,
    BidStatus? status,
  }) {
    return _bidService.streamBidsForWish(
      wishId: wishId,
      status: status,
    );
  }

  /// Get all bids placed by a provider
  Future<Either<Failure, List<BidModel>>> getProviderBids({
    required String providerId,
    BidStatus? status,
  }) async {
    try {
      final bids = await _bidService.getProviderBids(
        providerId: providerId,
        status: status,
      );
      return Right(bids);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to get provider bids', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error getting provider bids', e);
      return Left(UnknownFailure(message: 'Failed to get provider bids: ${e.toString()}'));
    }
  }

  /// Stream all bids placed by a provider with real-time updates
  Stream<List<BidModel>> streamProviderBids({
    required String providerId,
    BidStatus? status,
  }) {
    return _bidService.streamProviderBids(
      providerId: providerId,
      status: status,
    );
  }

  /// Get the highest bid for a wish
  Future<Either<Failure, BidModel?>> getHighestBid({
    required String wishId,
  }) async {
    try {
      final bid = await _bidService.getHighestBid(wishId: wishId);
      return Right(bid);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to get highest bid', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error getting highest bid', e);
      return Left(UnknownFailure(message: 'Failed to get highest bid: ${e.toString()}'));
    }
  }

  /// Stream the highest bid for a wish with real-time updates
  Stream<BidModel?> streamHighestBid({
    required String wishId,
  }) {
    return _bidService.streamHighestBid(wishId: wishId);
  }

  /// Accept a bid
  Future<Either<Failure, void>> acceptBid({
    required String wishId,
    required String bidId,
  }) async {
    try {
      await _bidService.acceptBid(
        wishId: wishId,
        bidId: bidId,
      );
      return const Right(null);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to accept bid', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error accepting bid', e);
      return Left(UnknownFailure(message: 'Failed to accept bid: ${e.toString()}'));
    }
  }

  /// Check if provider has already bid on a wish
  Future<Either<Failure, bool>> hasProviderBidOnWish({
    required String wishId,
    required String providerId,
  }) async {
    try {
      final hasBid = await _bidService.hasProviderBidOnWish(
        wishId: wishId,
        providerId: providerId,
      );
      return Right(hasBid);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to check provider bid', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error checking provider bid', e);
      return Left(UnknownFailure(message: 'Failed to check bid: ${e.toString()}'));
    }
  }

  /// Get provider's bid on a specific wish
  Future<Either<Failure, BidModel?>> getProviderBidOnWish({
    required String wishId,
    required String providerId,
  }) async {
    try {
      final bid = await _bidService.getProviderBidOnWish(
        wishId: wishId,
        providerId: providerId,
      );
      return Right(bid);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to get provider bid', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error getting provider bid', e);
      return Left(UnknownFailure(message: 'Failed to get provider bid: ${e.toString()}'));
    }
  }
}
