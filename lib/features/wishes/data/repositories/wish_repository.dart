import 'package:dartz/dartz.dart';
import '../../../../core/models/wish_model.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/logger.dart';
import '../services/wish_service.dart';

/// Repository for wish data operations
///
/// Handles data operations and converts exceptions to failures
class WishRepository {
  final WishService _wishService;

  WishRepository(this._wishService);

  /// Create a new wish
  Future<Either<Failure, String>> createWish(WishModel wish) async {
    try {
      final wishId = await _wishService.createWish(wish);
      return Right(wishId);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to create wish', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error creating wish', e);
      return Left(UnknownFailure(message: 'Failed to create wish: ${e.toString()}'));
    }
  }

  /// Update an existing wish
  Future<Either<Failure, void>> updateWish(String wishId, WishModel wish) async {
    try {
      await _wishService.updateWish(wishId, wish);
      return const Right(null);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to update wish', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error updating wish', e);
      return Left(UnknownFailure(message: 'Failed to update wish: ${e.toString()}'));
    }
  }

  /// Delete a wish
  Future<Either<Failure, void>> deleteWish(String wishId) async {
    try {
      await _wishService.deleteWish(wishId);
      return const Right(null);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to delete wish', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error deleting wish', e);
      return Left(UnknownFailure(message: 'Failed to delete wish: ${e.toString()}'));
    }
  }

  /// Get a single wish by ID
  Future<Either<Failure, WishModel?>> getWish(String wishId) async {
    try {
      final wish = await _wishService.getWish(wishId);
      return Right(wish);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to get wish', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error getting wish', e);
      return Left(UnknownFailure(message: 'Failed to get wish: ${e.toString()}'));
    }
  }

  /// Get all wishes for a user
  Stream<List<WishModel>> getUserWishesStream(String userId) {
    return _wishService.getUserWishesStream(userId);
  }

  /// Get wishes by category
  Stream<List<WishModel>> getWishesByCategoryStream(
    String userId,
    WishCategory category,
  ) {
    return _wishService.getWishesByCategoryStream(userId, category);
  }

  /// Get wishes by status
  Stream<List<WishModel>> getWishesByStatusStream(
    String userId,
    WishStatus status,
  ) {
    return _wishService.getWishesByStatusStream(userId, status);
  }

  /// Get wishes by priority
  Stream<List<WishModel>> getWishesByPriorityStream(
    String userId,
    WishPriority priority,
  ) {
    return _wishService.getWishesByPriorityStream(userId, priority);
  }

  /// Get favorite wishes
  Stream<List<WishModel>> getFavoriteWishesStream(String userId) {
    return _wishService.getFavoriteWishesStream(userId);
  }

  /// Search wishes
  Future<Either<Failure, List<WishModel>>> searchWishes(
    String userId,
    String query,
  ) async {
    try {
      final wishes = await _wishService.searchWishes(userId, query);
      return Right(wishes);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to search wishes', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error searching wishes', e);
      return Left(UnknownFailure(message: 'Failed to search wishes: ${e.toString()}'));
    }
  }

  /// Update wish progress
  Future<Either<Failure, void>> updateWishProgress(
    String wishId,
    int progress,
  ) async {
    try {
      await _wishService.updateWishProgress(wishId, progress);
      return const Right(null);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to update wish progress', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error updating wish progress', e);
      return Left(UnknownFailure(message: 'Failed to update wish progress: ${e.toString()}'));
    }
  }

  /// Toggle favorite status
  Future<Either<Failure, void>> toggleFavorite(
    String wishId,
    bool isFavorite,
  ) async {
    try {
      await _wishService.toggleFavorite(wishId, isFavorite);
      return const Right(null);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to toggle favorite', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error toggling favorite', e);
      return Left(UnknownFailure(message: 'Failed to toggle favorite: ${e.toString()}'));
    }
  }

  /// Mark wish as completed
  Future<Either<Failure, void>> markWishCompleted(String wishId) async {
    try {
      await _wishService.markWishCompleted(wishId);
      return const Right(null);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to mark wish as completed', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error marking wish as completed', e);
      return Left(UnknownFailure(message: 'Failed to mark wish as completed: ${e.toString()}'));
    }
  }

  /// Get wish statistics
  Future<Either<Failure, WishStatistics>> getWishStatistics(String userId) async {
    try {
      final stats = await _wishService.getWishStatistics(userId);
      return Right(stats);
    } on FirestoreException catch (e) {
      AppLogger.error('Repository: Failed to get wish statistics', e);
      return Left(FirestoreFailure(message: e.message));
    } catch (e) {
      AppLogger.error('Repository: Unexpected error getting wish statistics', e);
      return Left(UnknownFailure(message: 'Failed to get wish statistics: ${e.toString()}'));
    }
  }
}
