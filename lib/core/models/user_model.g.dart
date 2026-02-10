// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      bio: json['bio'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      location: json['location'] == null
          ? null
          : UserLocation.fromJson(json['location'] as Map<String, dynamic>),
      stats: json['stats'] == null
          ? null
          : UserStats.fromJson(json['stats'] as Map<String, dynamic>),
      verification: json['verification'] == null
          ? null
          : UserVerification.fromJson(
              json['verification'] as Map<String, dynamic>),
      settings: json['settings'] == null
          ? null
          : UserSettings.fromJson(json['settings'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      lastActiveAt: json['lastActiveAt'] == null
          ? null
          : DateTime.parse(json['lastActiveAt'] as String),
      isActive: json['isActive'] as bool? ?? false,
      isVerified: json['isVerified'] as bool? ?? false,
      isBlocked: json['isBlocked'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'displayName': instance.displayName,
      'avatarUrl': instance.avatarUrl,
      'phoneNumber': instance.phoneNumber,
      'bio': instance.bio,
      'roles': instance.roles,
      'location': instance.location,
      'stats': instance.stats,
      'verification': instance.verification,
      'settings': instance.settings,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
      'isActive': instance.isActive,
      'isVerified': instance.isVerified,
      'isBlocked': instance.isBlocked,
    };

_$UserLocationImpl _$$UserLocationImplFromJson(Map<String, dynamic> json) =>
    _$UserLocationImpl(
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$UserLocationImplToJson(_$UserLocationImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'postalCode': instance.postalCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };

_$UserStatsImpl _$$UserStatsImplFromJson(Map<String, dynamic> json) =>
    _$UserStatsImpl(
      listingsCount: (json['listingsCount'] as num?)?.toInt() ?? 0,
      activeListingsCount: (json['activeListingsCount'] as num?)?.toInt() ?? 0,
      soldListingsCount: (json['soldListingsCount'] as num?)?.toInt() ?? 0,
      bidsPlacedCount: (json['bidsPlacedCount'] as num?)?.toInt() ?? 0,
      bidsWonCount: (json['bidsWonCount'] as num?)?.toInt() ?? 0,
      reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      followersCount: (json['followersCount'] as num?)?.toInt() ?? 0,
      followingCount: (json['followingCount'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserStatsImplToJson(_$UserStatsImpl instance) =>
    <String, dynamic>{
      'listingsCount': instance.listingsCount,
      'activeListingsCount': instance.activeListingsCount,
      'soldListingsCount': instance.soldListingsCount,
      'bidsPlacedCount': instance.bidsPlacedCount,
      'bidsWonCount': instance.bidsWonCount,
      'reviewsCount': instance.reviewsCount,
      'averageRating': instance.averageRating,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
    };

_$UserVerificationImpl _$$UserVerificationImplFromJson(
        Map<String, dynamic> json) =>
    _$UserVerificationImpl(
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
      isIdentityVerified: json['isIdentityVerified'] as bool? ?? false,
      emailVerifiedAt: json['emailVerifiedAt'] == null
          ? null
          : DateTime.parse(json['emailVerifiedAt'] as String),
      phoneVerifiedAt: json['phoneVerifiedAt'] == null
          ? null
          : DateTime.parse(json['phoneVerifiedAt'] as String),
      identityVerifiedAt: json['identityVerifiedAt'] == null
          ? null
          : DateTime.parse(json['identityVerifiedAt'] as String),
    );

Map<String, dynamic> _$$UserVerificationImplToJson(
        _$UserVerificationImpl instance) =>
    <String, dynamic>{
      'isEmailVerified': instance.isEmailVerified,
      'isPhoneVerified': instance.isPhoneVerified,
      'isIdentityVerified': instance.isIdentityVerified,
      'emailVerifiedAt': instance.emailVerifiedAt?.toIso8601String(),
      'phoneVerifiedAt': instance.phoneVerifiedAt?.toIso8601String(),
      'identityVerifiedAt': instance.identityVerifiedAt?.toIso8601String(),
    };

_$UserSettingsImpl _$$UserSettingsImplFromJson(Map<String, dynamic> json) =>
    _$UserSettingsImpl(
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      emailNotificationsEnabled:
          json['emailNotificationsEnabled'] as bool? ?? true,
      pushNotificationsEnabled:
          json['pushNotificationsEnabled'] as bool? ?? true,
      bidNotificationsEnabled: json['bidNotificationsEnabled'] as bool? ?? true,
      messageNotificationsEnabled:
          json['messageNotificationsEnabled'] as bool? ?? true,
      themeMode: json['themeMode'] as String? ?? 'light',
      language: json['language'] as String? ?? 'en',
      currency: json['currency'] as String? ?? 'USD',
    );

Map<String, dynamic> _$$UserSettingsImplToJson(_$UserSettingsImpl instance) =>
    <String, dynamic>{
      'notificationsEnabled': instance.notificationsEnabled,
      'emailNotificationsEnabled': instance.emailNotificationsEnabled,
      'pushNotificationsEnabled': instance.pushNotificationsEnabled,
      'bidNotificationsEnabled': instance.bidNotificationsEnabled,
      'messageNotificationsEnabled': instance.messageNotificationsEnabled,
      'themeMode': instance.themeMode,
      'language': instance.language,
      'currency': instance.currency,
    };
