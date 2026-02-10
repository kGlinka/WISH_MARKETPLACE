import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/models/bid_model.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/utils/logger.dart';

/// Service for bid-related Firestore operations
///
/// Handles all bid CRUD operations and real-time updates
class BidService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Collection names
  static const String _wishesCollection = 'wishes';
  static const String _bidsCollection = 'bids';

  /// Create a new bid on a wish
  ///
  /// Returns the bid ID
  /// Throws [FirestoreException] on failure
  Future<String> createBid({
    required String wishId,
    required BidModel bid,
  }) async {
    try {
      AppLogger.debug('Creating bid for wish: $wishId');

      final bidData = bid.toJson();

      // Use a transaction to ensure atomicity
      final bidId = await _firestore.runTransaction<String>((transaction) async {
        // Get the wish document to check if it still exists and is accepting bids
        final wishRef = _firestore.collection(_wishesCollection).doc(wishId);
        final wishDoc = await transaction.get(wishRef);

        if (!wishDoc.exists) {
          throw FirestoreException(
            message: 'Wish not found',
          );
        }

        // Create bid document
        final bidRef = _firestore
            .collection(_wishesCollection)
            .doc(wishId)
            .collection(_bidsCollection)
            .doc();

        // Add bid with timestamp
        final bidWithTimestamp = {
          ...bidData,
          'id': bidRef.id,
          'wishId': wishId,
          'createdAt': FieldValue.serverTimestamp(),
        };

        transaction.set(bidRef, bidWithTimestamp);

        // Update wish document to increment bid count
        transaction.update(wishRef, {
          'bidCount': FieldValue.increment(1),
          'updatedAt': FieldValue.serverTimestamp(),
        });

        return bidRef.id;
      });

      AppLogger.info('Bid created successfully: $bidId');
      return bidId;
    } on FirestoreException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to create bid', e, stackTrace);
      throw FirestoreException(
        message: 'Failed to create bid: ${e.toString()}',
      );
    }
  }

  /// Update an existing bid
  ///
  /// Throws [FirestoreException] on failure
  Future<void> updateBid({
    required String wishId,
    required String bidId,
    required Map<String, dynamic> updates,
  }) async {
    try {
      AppLogger.debug('Updating bid: $bidId for wish: $wishId');

      await _firestore
          .collection(_wishesCollection)
          .doc(wishId)
          .collection(_bidsCollection)
          .doc(bidId)
          .update({
        ...updates,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      AppLogger.info('Bid updated successfully: $bidId');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update bid', e, stackTrace);
      throw FirestoreException(
        message: 'Failed to update bid: ${e.toString()}',
      );
    }
  }

  /// Cancel/withdraw a bid
  ///
  /// Throws [FirestoreException] on failure
  Future<void> cancelBid({
    required String wishId,
    required String bidId,
    String? cancellationReason,
  }) async {
    try {
      AppLogger.debug('Cancelling bid: $bidId for wish: $wishId');

      await _firestore.runTransaction((transaction) async {
        final bidRef = _firestore
            .collection(_wishesCollection)
            .doc(wishId)
            .collection(_bidsCollection)
            .doc(bidId);

        final wishRef = _firestore.collection(_wishesCollection).doc(wishId);

        // Update bid status to cancelled
        transaction.update(bidRef, {
          'status': BidStatus.cancelled.name,
          'cancelledAt': FieldValue.serverTimestamp(),
          'cancellationReason': cancellationReason,
          'updatedAt': FieldValue.serverTimestamp(),
        });

        // Decrement wish bid count
        transaction.update(wishRef, {
          'bidCount': FieldValue.increment(-1),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      });

      AppLogger.info('Bid cancelled successfully: $bidId');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to cancel bid', e, stackTrace);
      throw FirestoreException(
        message: 'Failed to cancel bid: ${e.toString()}',
      );
    }
  }

  /// Delete a bid (hard delete)
  ///
  /// Throws [FirestoreException] on failure
  Future<void> deleteBid({
    required String wishId,
    required String bidId,
  }) async {
    try {
      AppLogger.debug('Deleting bid: $bidId for wish: $wishId');

      await _firestore.runTransaction((transaction) async {
        final bidRef = _firestore
            .collection(_wishesCollection)
            .doc(wishId)
            .collection(_bidsCollection)
            .doc(bidId);

        final wishRef = _firestore.collection(_wishesCollection).doc(wishId);

        transaction.delete(bidRef);

        // Decrement wish bid count
        transaction.update(wishRef, {
          'bidCount': FieldValue.increment(-1),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      });

      AppLogger.info('Bid deleted successfully: $bidId');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete bid', e, stackTrace);
      throw FirestoreException(
        message: 'Failed to delete bid: ${e.toString()}',
      );
    }
  }

  /// Get a single bid by ID
  ///
  /// Returns null if bid not found
  /// Throws [FirestoreException] on failure
  Future<BidModel?> getBid({
    required String wishId,
    required String bidId,
  }) async {
    try {
      AppLogger.debug('Getting bid: $bidId for wish: $wishId');

      final doc = await _firestore
          .collection(_wishesCollection)
          .doc(wishId)
          .collection(_bidsCollection)
          .doc(bidId)
          .get();

      if (!doc.exists || doc.data() == null) {
        return null;
      }

      return BidModel.fromJson({
        ...doc.data()!,
        'id': doc.id,
      });
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get bid', e, stackTrace);
      throw FirestoreException(
        message: 'Failed to get bid: ${e.toString()}',
      );
    }
  }

  /// Get all bids for a wish
  ///
  /// Returns list of bids sorted by amount (highest first)
  /// Throws [FirestoreException] on failure
  Future<List<BidModel>> getBidsForWish({
    required String wishId,
    BidStatus? status,
  }) async {
    try {
      AppLogger.debug('Getting bids for wish: $wishId');

      Query query = _firestore
          .collection(_wishesCollection)
          .doc(wishId)
          .collection(_bidsCollection);

      // Filter by status if provided
      if (status != null) {
        query = query.where('status', isEqualTo: status.name);
      }

      // Order by amount descending (highest bids first)
      query = query.orderBy('amount', descending: true);

      final snapshot = await query.get();

      return snapshot.docs.map((doc) {
        return BidModel.fromJson({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
      }).toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get bids for wish', e, stackTrace);
      throw FirestoreException(
        message: 'Failed to get bids for wish: ${e.toString()}',
      );
    }
  }

  /// Stream all bids for a wish with real-time updates
  ///
  /// Returns a stream of bids sorted by amount (highest first)
  Stream<List<BidModel>> streamBidsForWish({
    required String wishId,
    BidStatus? status,
  }) {
    try {
      AppLogger.debug('Streaming bids for wish: $wishId');

      Query query = _firestore
          .collection(_wishesCollection)
          .doc(wishId)
          .collection(_bidsCollection);

      // Filter by status if provided
      if (status != null) {
        query = query.where('status', isEqualTo: status.name);
      }

      // Order by amount descending (highest bids first)
      query = query.orderBy('amount', descending: true);

      return query.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return BidModel.fromJson({
            ...doc.data() as Map<String, dynamic>,
            'id': doc.id,
          });
        }).toList();
      });
    } catch (e, stackTrace) {
      AppLogger.error('Failed to stream bids for wish', e, stackTrace);
      throw FirestoreException(
        message: 'Failed to stream bids for wish: ${e.toString()}',
      );
    }
  }

  /// Get all bids placed by a provider
  ///
  /// Returns list of bids sorted by creation date (newest first)
  /// Throws [FirestoreException] on failure
  Future<List<BidModel>> getProviderBids({
    required String providerId,
    BidStatus? status,
  }) async {
    try {
      AppLogger.debug('Getting bids for provider: $providerId');

      // Note: This requires a composite index in Firestore
      // We need to query across all wishes, which is inefficient
      // Better approach: maintain a separate provider_bids collection
      // For now, we'll use a collection group query

      Query query = _firestore.collectionGroup(_bidsCollection);

      query = query.where('bidderId', isEqualTo: providerId);

      if (status != null) {
        query = query.where('status', isEqualTo: status.name);
      }

      query = query.orderBy('createdAt', descending: true);

      final snapshot = await query.get();

      return snapshot.docs.map((doc) {
        return BidModel.fromJson({
          ...doc.data() as Map<String, dynamic>,
          'id': doc.id,
        });
      }).toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get provider bids', e, stackTrace);
      throw FirestoreException(
        message: 'Failed to get provider bids: ${e.toString()}',
      );
    }
  }

  /// Stream all bids placed by a provider with real-time updates
  ///
  /// Returns a stream of bids sorted by creation date (newest first)
  Stream<List<BidModel>> streamProviderBids({
    required String providerId,
    BidStatus? status,
  }) {
    try {
      AppLogger.debug('Streaming bids for provider: $providerId');

      Query query = _firestore.collectionGroup(_bidsCollection);

      query = query.where('bidderId', isEqualTo: providerId);

      if (status != null) {
        query = query.where('status', isEqualTo: status.name);
      }

      query = query.orderBy('createdAt', descending: true);

      return query.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return BidModel.fromJson({
            ...doc.data() as Map<String, dynamic>,
            'id': doc.id,
          });
        }).toList();
      });
    } catch (e, stackTrace) {
      AppLogger.error('Failed to stream provider bids', e, stackTrace);
      throw FirestoreException(
        message: 'Failed to stream provider bids: ${e.toString()}',
      );
    }
  }

  /// Get the highest bid for a wish
  ///
  /// Returns null if no bids exist
  /// Throws [FirestoreException] on failure
  Future<BidModel?> getHighestBid({
    required String wishId,
  }) async {
    try {
      AppLogger.debug('Getting highest bid for wish: $wishId');

      final snapshot = await _firestore
          .collection(_wishesCollection)
          .doc(wishId)
          .collection(_bidsCollection)
          .where('status', whereIn: [BidStatus.active.name, BidStatus.winning.name])
          .orderBy('amount', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      return BidModel.fromJson({
        ...snapshot.docs.first.data(),
        'id': snapshot.docs.first.id,
      });
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get highest bid', e, stackTrace);
      throw FirestoreException(
        message: 'Failed to get highest bid: ${e.toString()}',
      );
    }
  }

  /// Stream the highest bid for a wish with real-time updates
  ///
  /// Returns a stream of the highest bid or null if no bids exist
  Stream<BidModel?> streamHighestBid({
    required String wishId,
  }) {
    try {
      AppLogger.debug('Streaming highest bid for wish: $wishId');

      return _firestore
          .collection(_wishesCollection)
          .doc(wishId)
          .collection(_bidsCollection)
          .where('status', whereIn: [BidStatus.active.name, BidStatus.winning.name])
          .orderBy('amount', descending: true)
          .limit(1)
          .snapshots()
          .map((snapshot) {
        if (snapshot.docs.isEmpty) {
          return null;
        }

        return BidModel.fromJson({
          ...snapshot.docs.first.data(),
          'id': snapshot.docs.first.id,
        });
      });
    } catch (e, stackTrace) {
      AppLogger.error('Failed to stream highest bid', e, stackTrace);
      throw FirestoreException(
        message: 'Failed to stream highest bid: ${e.toString()}',
      );
    }
  }

  /// Accept a bid (mark as winner)
  ///
  /// Updates the winning bid and marks other bids as lost
  /// Throws [FirestoreException] on failure
  Future<void> acceptBid({
    required String wishId,
    required String bidId,
  }) async {
    try {
      AppLogger.debug('Accepting bid: $bidId for wish: $wishId');

      final wishRef = _firestore.collection(_wishesCollection).doc(wishId);
      final bidsRef = wishRef.collection(_bidsCollection);

      // Query active bids outside the transaction
      final bidsSnapshot = await bidsRef
          .where('status', whereIn: [BidStatus.active.name, BidStatus.winning.name])
          .get();

      await _firestore.runTransaction((transaction) async {
        // Update winning bid
        final winningBidRef = bidsRef.doc(bidId);
        transaction.update(winningBidRef, {
          'status': BidStatus.won.name,
          'updatedAt': FieldValue.serverTimestamp(),
        });

        // Mark other bids as lost
        for (final doc in bidsSnapshot.docs) {
          if (doc.id != bidId) {
            transaction.update(bidsRef.doc(doc.id), {
              'status': BidStatus.lost.name,
              'updatedAt': FieldValue.serverTimestamp(),
            });
          }
        }

        // Update wish status
        transaction.update(wishRef, {
          'status': 'inProgress',
          'acceptedBidId': bidId,
          'updatedAt': FieldValue.serverTimestamp(),
        });
      });

      AppLogger.info('Bid accepted successfully: $bidId');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to accept bid', e, stackTrace);
      throw FirestoreException(
        message: 'Failed to accept bid: ${e.toString()}',
      );
    }
  }

  /// Check if provider has already bid on a wish
  ///
  /// Returns true if provider has an active bid
  /// Throws [FirestoreException] on failure
  Future<bool> hasProviderBidOnWish({
    required String wishId,
    required String providerId,
  }) async {
    try {
      AppLogger.debug('Checking if provider has bid on wish: $wishId');

      final snapshot = await _firestore
          .collection(_wishesCollection)
          .doc(wishId)
          .collection(_bidsCollection)
          .where('bidderId', isEqualTo: providerId)
          .where('status', whereIn: [
            BidStatus.active.name,
            BidStatus.winning.name,
          ])
          .limit(1)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to check provider bid', e, stackTrace);
      throw FirestoreException(
        message: 'Failed to check provider bid: ${e.toString()}',
      );
    }
  }

  /// Get provider's bid on a specific wish
  ///
  /// Returns null if no active bid found
  /// Throws [FirestoreException] on failure
  Future<BidModel?> getProviderBidOnWish({
    required String wishId,
    required String providerId,
  }) async {
    try {
      AppLogger.debug('Getting provider bid on wish: $wishId');

      final snapshot = await _firestore
          .collection(_wishesCollection)
          .doc(wishId)
          .collection(_bidsCollection)
          .where('bidderId', isEqualTo: providerId)
          .where('status', whereIn: [
            BidStatus.active.name,
            BidStatus.winning.name,
          ])
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        return null;
      }

      return BidModel.fromJson({
        ...snapshot.docs.first.data(),
        'id': snapshot.docs.first.id,
      });
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get provider bid', e, stackTrace);
      throw FirestoreException(
        message: 'Failed to get provider bid: ${e.toString()}',
      );
    }
  }
}
