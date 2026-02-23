import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/models/wish_model.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/errors/exceptions.dart';

/// Service for Firestore operations related to wishes
class WishService {
  final FirebaseFirestore _firestore;

  WishService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Get the wishes collection reference
  CollectionReference<Map<String, dynamic>> get _wishesCollection =>
      _firestore.collection(AppConstants.wishesCollection);

  /// Create a new wish
  Future<String> createWish(WishModel wish) async {
    try {
      AppLogger.info('Creating wish: ${wish.title}');

      final docRef = await _wishesCollection.add(wish.toJson());

      AppLogger.info('Wish created successfully with ID: ${docRef.id}');
      return docRef.id;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to create wish', e, stackTrace);
      throw FirestoreException(message: 'Failed to create wish: ${e.toString()}');
    }
  }

  /// Update an existing wish
  Future<void> updateWish(String wishId, WishModel wish) async {
    try {
      AppLogger.info('Updating wish: $wishId');

      await _wishesCollection.doc(wishId).update(wish.toJson());

      AppLogger.info('Wish updated successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update wish', e, stackTrace);
      throw FirestoreException(message: 'Failed to update wish: ${e.toString()}');
    }
  }

  /// Delete a wish
  Future<void> deleteWish(String wishId) async {
    try {
      AppLogger.info('Deleting wish: $wishId');

      await _wishesCollection.doc(wishId).delete();

      AppLogger.info('Wish deleted successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete wish', e, stackTrace);
      throw FirestoreException(message: 'Failed to delete wish: ${e.toString()}');
    }
  }

  /// Get a single wish by ID
  Future<WishModel?> getWish(String wishId) async {
    try {
      AppLogger.info('Fetching wish: $wishId');

      final doc = await _wishesCollection.doc(wishId).get();

      if (!doc.exists) {
        AppLogger.warning('Wish not found: $wishId');
        return null;
      }

      final data = doc.data()!;
      data['id'] = doc.id;

      return WishModel.fromJson(_convertTimestamps(data));
    } catch (e, stackTrace) {
      AppLogger.error('Failed to fetch wish', e, stackTrace);
      throw FirestoreException(message: 'Failed to fetch wish: ${e.toString()}');
    }
  }

  /// Get all wishes for a user
  Stream<List<WishModel>> getUserWishesStream(String userId) {
    try {
      AppLogger.info('Getting wishes stream for user: $userId');

      return _wishesCollection
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return WishModel.fromJson(_convertTimestamps(data));
        }).toList();
      });
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get wishes stream', e, stackTrace);
      throw FirestoreException(message: 'Failed to get wishes stream: ${e.toString()}');
    }
  }

  /// Get wishes by category
  Stream<List<WishModel>> getWishesByCategoryStream(
    String userId,
    WishCategory category,
  ) {
    try {
      AppLogger.info('Getting wishes by category: ${category.name}');

      return _wishesCollection
          .where('userId', isEqualTo: userId)
          .where('category', isEqualTo: category.name)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return WishModel.fromJson(_convertTimestamps(data));
        }).toList();
      });
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get wishes by category', e, stackTrace);
      throw FirestoreException(message: 'Failed to get wishes by category: ${e.toString()}');
    }
  }

  /// Get wishes by status
  Stream<List<WishModel>> getWishesByStatusStream(
    String userId,
    WishStatus status,
  ) {
    try {
      AppLogger.info('Getting wishes by status: ${status.name}');

      return _wishesCollection
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: status.name)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return WishModel.fromJson(_convertTimestamps(data));
        }).toList();
      });
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get wishes by status', e, stackTrace);
      throw FirestoreException(message: 'Failed to get wishes by status: ${e.toString()}');
    }
  }

  /// Get wishes by priority
  Stream<List<WishModel>> getWishesByPriorityStream(
    String userId,
    WishPriority priority,
  ) {
    try {
      AppLogger.info('Getting wishes by priority: ${priority.name}');

      return _wishesCollection
          .where('userId', isEqualTo: userId)
          .where('priority', isEqualTo: priority.name)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return WishModel.fromJson(_convertTimestamps(data));
        }).toList();
      });
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get wishes by priority', e, stackTrace);
      throw FirestoreException(message: 'Failed to get wishes by priority: ${e.toString()}');
    }
  }

  /// Get favorite wishes
  Stream<List<WishModel>> getFavoriteWishesStream(String userId) {
    try {
      AppLogger.info('Getting favorite wishes for user: $userId');

      return _wishesCollection
          .where('userId', isEqualTo: userId)
          .where('isFavorite', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          data['id'] = doc.id;
          return WishModel.fromJson(_convertTimestamps(data));
        }).toList();
      });
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get favorite wishes', e, stackTrace);
      throw FirestoreException(message: 'Failed to get favorite wishes: ${e.toString()}');
    }
  }

  /// Search wishes by title or description
  Future<List<WishModel>> searchWishes(String userId, String query) async {
    try {
      AppLogger.info('Searching wishes for query: $query');

      final snapshot = await _wishesCollection
          .where('userId', isEqualTo: userId)
          .get();

      final lowerQuery = query.toLowerCase();

      final wishes = snapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return WishModel.fromJson(_convertTimestamps(data));
          })
          .where((wish) =>
              wish.title.toLowerCase().contains(lowerQuery) ||
              wish.description.toLowerCase().contains(lowerQuery) ||
              wish.tags.any((tag) => tag.toLowerCase().contains(lowerQuery)))
          .toList();

      return wishes;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to search wishes', e, stackTrace);
      throw FirestoreException(message: 'Failed to search wishes: ${e.toString()}');
    }
  }

  /// Update wish progress
  Future<void> updateWishProgress(String wishId, int progress) async {
    try {
      AppLogger.info('Updating wish progress: $wishId to $progress%');

      await _wishesCollection.doc(wishId).update({
        'progress': progress,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      AppLogger.info('Wish progress updated successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update wish progress', e, stackTrace);
      throw FirestoreException(message: 'Failed to update wish progress: ${e.toString()}');
    }
  }

  /// Toggle favorite status
  Future<void> toggleFavorite(String wishId, bool isFavorite) async {
    try {
      AppLogger.info('Toggling favorite for wish: $wishId to $isFavorite');

      await _wishesCollection.doc(wishId).update({
        'isFavorite': isFavorite,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      AppLogger.info('Wish favorite status updated successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to toggle favorite', e, stackTrace);
      throw FirestoreException(message: 'Failed to toggle favorite: ${e.toString()}');
    }
  }

  /// Mark wish as completed
  Future<void> markWishCompleted(String wishId) async {
    try {
      AppLogger.info('Marking wish as completed: $wishId');

      await _wishesCollection.doc(wishId).update({
        'status': WishStatus.completed.name,
        'progress': 100,
        'completedAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

      AppLogger.info('Wish marked as completed successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to mark wish as completed', e, stackTrace);
      throw FirestoreException(message: 'Failed to mark wish as completed: ${e.toString()}');
    }
  }

  /// Convert Firestore Timestamps to ISO 8601 strings for JSON deserialization
  Map<String, dynamic> _convertTimestamps(Map<String, dynamic> data) {
    final result = Map<String, dynamic>.from(data);
    for (final key in ['createdAt', 'updatedAt', 'completedAt']) {
      if (result[key] is Timestamp) {
        result[key] = (result[key] as Timestamp).toDate().toIso8601String();
      }
    }
    return result;
  }

  /// Get wish statistics for a user
  Future<WishStatistics> getWishStatistics(String userId) async {
    try {
      AppLogger.info('Getting wish statistics for user: $userId');

      final snapshot = await _wishesCollection
          .where('userId', isEqualTo: userId)
          .get();

      final wishes = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return WishModel.fromJson(_convertTimestamps(data));
      }).toList();

      final total = wishes.length;
      final active = wishes.where((w) => w.status == WishStatus.active).length;
      final inProgress = wishes.where((w) => w.status == WishStatus.inProgress).length;
      final completed = wishes.where((w) => w.status == WishStatus.completed).length;
      final deferred = wishes.where((w) => w.status == WishStatus.deferred).length;

      final categoryCount = <WishCategory, int>{};
      for (final wish in wishes) {
        categoryCount[wish.category] = (categoryCount[wish.category] ?? 0) + 1;
      }

      return WishStatistics(
        totalWishes: total,
        activeWishes: active,
        inProgressWishes: inProgress,
        completedWishes: completed,
        deferredWishes: deferred,
        categoryCount: categoryCount,
      );
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get wish statistics', e, stackTrace);
      throw FirestoreException(message: 'Failed to get wish statistics: ${e.toString()}');
    }
  }
}

/// Wish statistics class
class WishStatistics {
  final int totalWishes;
  final int activeWishes;
  final int inProgressWishes;
  final int completedWishes;
  final int deferredWishes;
  final Map<WishCategory, int> categoryCount;

  WishStatistics({
    required this.totalWishes,
    required this.activeWishes,
    required this.inProgressWishes,
    required this.completedWishes,
    required this.deferredWishes,
    required this.categoryCount,
  });
}
