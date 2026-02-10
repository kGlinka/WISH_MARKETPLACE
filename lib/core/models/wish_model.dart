import 'package:freezed_annotation/freezed_annotation.dart';

part 'wish_model.freezed.dart';
part 'wish_model.g.dart';

/// Wish status enum
enum WishStatus {
  active,
  inProgress,
  completed,
  deferred,
  cancelled,
}

/// Wish priority enum
enum WishPriority {
  low,
  medium,
  high,
  urgent,
}

/// Wish category enum
enum WishCategory {
  personalGrowth,
  travel,
  career,
  relationships,
  health,
  creativity,
  financial,
  education,
  adventure,
  material,
  spiritual,
  other,
}

/// Extension for category display names
extension WishCategoryExtension on WishCategory {
  String get displayName {
    switch (this) {
      case WishCategory.personalGrowth:
        return 'Personal Growth';
      case WishCategory.travel:
        return 'Travel';
      case WishCategory.career:
        return 'Career';
      case WishCategory.relationships:
        return 'Relationships';
      case WishCategory.health:
        return 'Health';
      case WishCategory.creativity:
        return 'Creativity';
      case WishCategory.financial:
        return 'Financial';
      case WishCategory.education:
        return 'Education';
      case WishCategory.adventure:
        return 'Adventure';
      case WishCategory.material:
        return 'Material';
      case WishCategory.spiritual:
        return 'Spiritual';
      case WishCategory.other:
        return 'Other';
    }
  }
}

/// Wish model representing a user's wish, dream, or aspiration
///
/// Uses Freezed for immutability, equality, and JSON serialization
@freezed
class WishModel with _$WishModel {
  const factory WishModel({
    required String id,
    required String userId,
    required String title,
    required String description,
    required WishCategory category,
    required WishPriority priority,
    required WishStatus status,
    @Default([]) List<String> tags,
    @Default([]) List<String> prerequisites,
    String? targetDate,
    String? notes,
    @Default(0) int progress, // 0-100
    @Default([]) List<WishMilestone> milestones,
    @Default([]) List<String> imageUrls,
    @Default(false) bool isPublic,
    @Default(false) bool isFavorite,
    WishMetadata? metadata,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
  }) = _WishModel;

  factory WishModel.fromJson(Map<String, dynamic> json) =>
      _$WishModelFromJson(json);
}

/// Wish milestone for tracking sub-goals
@freezed
class WishMilestone with _$WishMilestone {
  const factory WishMilestone({
    required String id,
    required String title,
    String? description,
    required bool isCompleted,
    DateTime? completedAt,
    @Default(0) int order,
  }) = _WishMilestone;

  factory WishMilestone.fromJson(Map<String, dynamic> json) =>
      _$WishMilestoneFromJson(json);
}

/// Wish metadata for additional information
@freezed
class WishMetadata with _$WishMetadata {
  const factory WishMetadata({
    String? inspiration, // What inspired this wish
    String? motivation, // Why this wish matters
    @Default([]) List<String> resources, // Helpful resources
    @Default([]) List<String> obstacles, // Known obstacles
    Map<String, dynamic>? customFields,
    @Default(0) int viewCount,
    @Default(0) int shareCount,
    DateTime? lastViewedAt,
  }) = _WishMetadata;

  factory WishMetadata.fromJson(Map<String, dynamic> json) =>
      _$WishMetadataFromJson(json);
}
