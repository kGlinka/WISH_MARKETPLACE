import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// User model representing a marketplace user
///
/// Uses Freezed for immutability, equality, and JSON serialization
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String username,
    String? displayName,
    String? avatarUrl,
    String? phoneNumber,
    String? bio,
    @Default([]) List<String> roles,
    UserLocation? location,
    UserStats? stats,
    UserVerification? verification,
    UserSettings? settings,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
    @Default(false) bool isActive,
    @Default(false) bool isVerified,
    @Default(false) bool isBlocked,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

/// User location information
@freezed
class UserLocation with _$UserLocation {
  const factory UserLocation({
    String? address,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    double? latitude,
    double? longitude,
  }) = _UserLocation;

  factory UserLocation.fromJson(Map<String, dynamic> json) =>
      _$UserLocationFromJson(json);
}

/// User statistics
@freezed
class UserStats with _$UserStats {
  const factory UserStats({
    @Default(0) int listingsCount,
    @Default(0) int activeListingsCount,
    @Default(0) int soldListingsCount,
    @Default(0) int bidsPlacedCount,
    @Default(0) int bidsWonCount,
    @Default(0) int reviewsCount,
    @Default(0.0) double averageRating,
    @Default(0) int followersCount,
    @Default(0) int followingCount,
  }) = _UserStats;

  factory UserStats.fromJson(Map<String, dynamic> json) =>
      _$UserStatsFromJson(json);
}

/// User verification information
@freezed
class UserVerification with _$UserVerification {
  const factory UserVerification({
    @Default(false) bool isEmailVerified,
    @Default(false) bool isPhoneVerified,
    @Default(false) bool isIdentityVerified,
    DateTime? emailVerifiedAt,
    DateTime? phoneVerifiedAt,
    DateTime? identityVerifiedAt,
  }) = _UserVerification;

  factory UserVerification.fromJson(Map<String, dynamic> json) =>
      _$UserVerificationFromJson(json);
}

/// User settings and preferences
@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    @Default(true) bool notificationsEnabled,
    @Default(true) bool emailNotificationsEnabled,
    @Default(true) bool pushNotificationsEnabled,
    @Default(true) bool bidNotificationsEnabled,
    @Default(true) bool messageNotificationsEnabled,
    @Default('light') String themeMode,
    @Default('en') String language,
    @Default('USD') String currency,
  }) = _UserSettings;

  factory UserSettings.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsFromJson(json);
}
