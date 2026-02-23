import 'package:freezed_annotation/freezed_annotation.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

/// Review type enum
enum ReviewType {
  buyer,
  seller,
  product,
}

/// Review model representing user or product reviews
///
/// Uses Freezed for immutability, equality, and JSON serialization
@freezed
class ReviewModel with _$ReviewModel {
  const factory ReviewModel({
    required String id,
    required String reviewerId,
    required String revieweeId,
    required String listingId,
    String? transactionId,
    required ReviewType type,
    required double rating, // 1-5 stars
    String? title,
    String? comment,
    List<String>? imageUrls,
    @Default(0) int helpfulCount,
    @Default(false) bool isVerifiedPurchase,
    String? sellerResponse,
    DateTime? sellerResponseAt,
    @Default(false) bool isReported,
    @Default(0) int reportCount,
    @Default(false) bool isHidden,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _ReviewModel;

  factory ReviewModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewModelFromJson(json);
}
