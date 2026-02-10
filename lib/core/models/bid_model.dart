import 'package:freezed_annotation/freezed_annotation.dart';

part 'bid_model.freezed.dart';
part 'bid_model.g.dart';

/// Bid status enum
enum BidStatus {
  active,
  outbid,
  winning,
  won,
  lost,
  cancelled,
  expired,
}

/// Bid model representing a bid on a listing
///
/// Uses Freezed for immutability, equality, and JSON serialization
@freezed
class BidModel with _$BidModel {
  const factory BidModel({
    required String id,
    required String listingId,
    required String bidderId,
    required int amount, // in cents
    required BidStatus status,
    String? message,
    @Default(false) bool isAutoBid,
    int? maxAutoBidAmount, // in cents for auto-bidding
    @Default(false) bool isProxy,
    String? proxyBidId, // reference to the proxy bid if this is an auto-increment
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? cancelledAt,
    String? cancellationReason,
  }) = _BidModel;

  factory BidModel.fromJson(Map<String, dynamic> json) =>
      _$BidModelFromJson(json);
}

/// Bid history entry for tracking all bids on a listing
@freezed
class BidHistoryEntry with _$BidHistoryEntry {
  const factory BidHistoryEntry({
    required String bidId,
    required String bidderId,
    String? bidderUsername,
    String? bidderAvatarUrl,
    required int amount,
    required DateTime timestamp,
  }) = _BidHistoryEntry;

  factory BidHistoryEntry.fromJson(Map<String, dynamic> json) =>
      _$BidHistoryEntryFromJson(json);
}
