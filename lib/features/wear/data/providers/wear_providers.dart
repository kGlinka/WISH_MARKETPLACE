import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/firebase_providers.dart';

import '../../../../core/models/wish_model.dart';
import '../../../../core/models/listing_model.dart';
import '../../../../core/models/bid_model.dart';
import '../../../../core/models/notification_model.dart';
import '../../core/wear_constants.dart';

/// Stream provider for user's wishes (limited for Wear OS)
final wearWishesProvider = StreamProvider<List<WishModel>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  final userId = ref.watch(currentUserIdProvider);

  if (userId == null) return Stream.value([]);

  return firestoreService
      .streamDocuments(
        collection: 'wishes',
        where: {'userId': userId, 'status': 'active'},
        orderBy: 'createdAt',
        descending: true,
        limit: WearConstants.maxWishItems,
      )
      .map((docs) => docs.map((doc) => WishModel.fromJson(doc)).toList());
});

/// Stream provider for active listings (limited for Wear OS)
final wearListingsProvider = StreamProvider<List<ListingModel>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);

  return firestoreService
      .streamDocuments(
        collection: 'listings',
        where: {'status': 'active'},
        orderBy: 'createdAt',
        descending: true,
        limit: WearConstants.maxListingItems,
      )
      .map((docs) => docs.map((doc) => ListingModel.fromJson(doc)).toList());
});

/// Stream provider for user's bids (limited for Wear OS)
final wearBidsProvider = StreamProvider<List<BidModel>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  final userId = ref.watch(currentUserIdProvider);

  if (userId == null) return Stream.value([]);

  return firestoreService
      .streamDocuments(
        collection: 'bids',
        where: {'bidderId': userId},
        orderBy: 'createdAt',
        descending: true,
        limit: WearConstants.maxBidItems,
      )
      .map((docs) => docs.map((doc) => BidModel.fromJson(doc)).toList());
});

/// Stream provider for user's notifications (limited for Wear OS)
final wearNotificationsProvider = StreamProvider<List<NotificationModel>>((ref) {
  final firestoreService = ref.watch(firestoreServiceProvider);
  final userId = ref.watch(currentUserIdProvider);

  if (userId == null) return Stream.value([]);

  return firestoreService
      .streamDocuments(
        collection: 'notifications',
        where: {'userId': userId, 'isRead': false},
        orderBy: 'createdAt',
        descending: true,
        limit: WearConstants.maxNotificationItems,
      )
      .map((docs) => docs.map((doc) => NotificationModel.fromJson(doc)).toList());
});

/// Provider for a single wish by ID
final wearWishDetailProvider =
    FutureProvider.family<WishModel?, String>((ref, wishId) async {
  final firestoreService = ref.watch(firestoreServiceProvider);
  final doc = await firestoreService.getDocument(
    collection: 'wishes',
    documentId: wishId,
  );
  if (doc == null) return null;
  return WishModel.fromJson({...doc, 'id': wishId});
});

/// Provider for a single listing by ID
final wearListingDetailProvider =
    FutureProvider.family<ListingModel?, String>((ref, listingId) async {
  final firestoreService = ref.watch(firestoreServiceProvider);
  final doc = await firestoreService.getDocument(
    collection: 'listings',
    documentId: listingId,
  );
  if (doc == null) return null;
  return ListingModel.fromJson({...doc, 'id': listingId});
});
