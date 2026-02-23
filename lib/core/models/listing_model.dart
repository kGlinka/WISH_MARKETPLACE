import 'package:freezed_annotation/freezed_annotation.dart';

part 'listing_model.freezed.dart';
part 'listing_model.g.dart';

/// Listing status enum
enum ListingStatus {
  draft,
  active,
  pending,
  sold,
  expired,
  cancelled,
  removed,
}

/// Listing condition enum
enum ListingCondition {
  brandNew,
  likeNew,
  excellent,
  good,
  fair,
  poor,
}

/// Listing model representing a marketplace item
///
/// Uses Freezed for immutability, equality, and JSON serialization
@freezed
class ListingModel with _$ListingModel {
  const factory ListingModel({
    required String id,
    required String sellerId,
    required String title,
    required String description,
    required int startingPrice, // in cents
    int? currentBid, // in cents
    int? buyNowPrice, // in cents
    required List<String> imageUrls,
    String? videoUrl,
    required String category,
    @Default([]) List<String> tags,
    required ListingStatus status,
    required ListingCondition condition,
    ListingSpecs? specs,
    ListingLocation? location,
    ListingStats? stats,
    required DateTime startTime,
    required DateTime endTime,
    DateTime? soldAt,
    String? winnerId,
    @Default(false) bool isFeatured,
    @Default(false) bool isPromoted,
    @Default(0) int viewCount,
    @Default(0) int favoriteCount,
    @Default(0) int bidCount,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _ListingModel;

  factory ListingModel.fromJson(Map<String, dynamic> json) =>
      _$ListingModelFromJson(json);
}

/// Listing specifications (for smartwatches)
@freezed
class ListingSpecs with _$ListingSpecs {
  const factory ListingSpecs({
    String? brand,
    String? model,
    String? color,
    String? size,
    String? material,
    String? connectivity, // e.g., Bluetooth, WiFi, LTE
    String? compatibility, // e.g., iOS, Android, Both
    String? batteryLife,
    String? displaySize,
    String? displayType,
    String? waterResistance,
    String? sensors,
    String? storage,
    String? ram,
    String? processor,
    String? operatingSystem,
    String? releaseYear,
    Map<String, dynamic>? additionalSpecs,
  }) = _ListingSpecs;

  factory ListingSpecs.fromJson(Map<String, dynamic> json) =>
      _$ListingSpecsFromJson(json);
}

/// Listing location information
@freezed
class ListingLocation with _$ListingLocation {
  const factory ListingLocation({
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    double? latitude,
    double? longitude,
    @Default(false) bool isLocalPickupAvailable,
    @Default(true) bool isShippingAvailable,
    int? shippingCost, // in cents
  }) = _ListingLocation;

  factory ListingLocation.fromJson(Map<String, dynamic> json) =>
      _$ListingLocationFromJson(json);
}

/// Listing statistics
@freezed
class ListingStats with _$ListingStats {
  const factory ListingStats({
    @Default(0) int impressions,
    @Default(0) int clicks,
    @Default(0) int shares,
    @Default(0) int reports,
    @Default(0.0) double conversionRate,
  }) = _ListingStats;

  factory ListingStats.fromJson(Map<String, dynamic> json) =>
      _$ListingStatsFromJson(json);
}
