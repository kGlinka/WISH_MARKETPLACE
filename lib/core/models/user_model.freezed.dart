// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get displayName => throw _privateConstructorUsedError;
  String? get avatarUrl => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  List<String> get roles => throw _privateConstructorUsedError;
  UserLocation? get location => throw _privateConstructorUsedError;
  UserStats? get stats => throw _privateConstructorUsedError;
  UserVerification? get verification => throw _privateConstructorUsedError;
  UserSettings? get settings => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get lastActiveAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get isVerified => throw _privateConstructorUsedError;
  bool get isBlocked => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String id,
      String email,
      String username,
      String? displayName,
      String? avatarUrl,
      String? phoneNumber,
      String? bio,
      List<String> roles,
      UserLocation? location,
      UserStats? stats,
      UserVerification? verification,
      UserSettings? settings,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? lastActiveAt,
      bool isActive,
      bool isVerified,
      bool isBlocked});

  $UserLocationCopyWith<$Res>? get location;
  $UserStatsCopyWith<$Res>? get stats;
  $UserVerificationCopyWith<$Res>? get verification;
  $UserSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? username = null,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? phoneNumber = freezed,
    Object? bio = freezed,
    Object? roles = null,
    Object? location = freezed,
    Object? stats = freezed,
    Object? verification = freezed,
    Object? settings = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? lastActiveAt = freezed,
    Object? isActive = null,
    Object? isVerified = null,
    Object? isBlocked = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      roles: null == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as UserLocation?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as UserStats?,
      verification: freezed == verification
          ? _value.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as UserVerification?,
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as UserSettings?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastActiveAt: freezed == lastActiveAt
          ? _value.lastActiveAt
          : lastActiveAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserLocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $UserLocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserStatsCopyWith<$Res>? get stats {
    if (_value.stats == null) {
      return null;
    }

    return $UserStatsCopyWith<$Res>(_value.stats!, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserVerificationCopyWith<$Res>? get verification {
    if (_value.verification == null) {
      return null;
    }

    return $UserVerificationCopyWith<$Res>(_value.verification!, (value) {
      return _then(_value.copyWith(verification: value) as $Val);
    });
  }

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserSettingsCopyWith<$Res>? get settings {
    if (_value.settings == null) {
      return null;
    }

    return $UserSettingsCopyWith<$Res>(_value.settings!, (value) {
      return _then(_value.copyWith(settings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String username,
      String? displayName,
      String? avatarUrl,
      String? phoneNumber,
      String? bio,
      List<String> roles,
      UserLocation? location,
      UserStats? stats,
      UserVerification? verification,
      UserSettings? settings,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? lastActiveAt,
      bool isActive,
      bool isVerified,
      bool isBlocked});

  @override
  $UserLocationCopyWith<$Res>? get location;
  @override
  $UserStatsCopyWith<$Res>? get stats;
  @override
  $UserVerificationCopyWith<$Res>? get verification;
  @override
  $UserSettingsCopyWith<$Res>? get settings;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? username = null,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? phoneNumber = freezed,
    Object? bio = freezed,
    Object? roles = null,
    Object? location = freezed,
    Object? stats = freezed,
    Object? verification = freezed,
    Object? settings = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? lastActiveAt = freezed,
    Object? isActive = null,
    Object? isVerified = null,
    Object? isBlocked = null,
  }) {
    return _then(_$UserModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _value.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      roles: null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as UserLocation?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as UserStats?,
      verification: freezed == verification
          ? _value.verification
          : verification // ignore: cast_nullable_to_non_nullable
              as UserVerification?,
      settings: freezed == settings
          ? _value.settings
          : settings // ignore: cast_nullable_to_non_nullable
              as UserSettings?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastActiveAt: freezed == lastActiveAt
          ? _value.lastActiveAt
          : lastActiveAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      isVerified: null == isVerified
          ? _value.isVerified
          : isVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isBlocked: null == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.id,
      required this.email,
      required this.username,
      this.displayName,
      this.avatarUrl,
      this.phoneNumber,
      this.bio,
      final List<String> roles = const [],
      this.location,
      this.stats,
      this.verification,
      this.settings,
      required this.createdAt,
      this.updatedAt,
      this.lastActiveAt,
      this.isActive = false,
      this.isVerified = false,
      this.isBlocked = false})
      : _roles = roles;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String username;
  @override
  final String? displayName;
  @override
  final String? avatarUrl;
  @override
  final String? phoneNumber;
  @override
  final String? bio;
  final List<String> _roles;
  @override
  @JsonKey()
  List<String> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  final UserLocation? location;
  @override
  final UserStats? stats;
  @override
  final UserVerification? verification;
  @override
  final UserSettings? settings;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? lastActiveAt;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool isVerified;
  @override
  @JsonKey()
  final bool isBlocked;

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, username: $username, displayName: $displayName, avatarUrl: $avatarUrl, phoneNumber: $phoneNumber, bio: $bio, roles: $roles, location: $location, stats: $stats, verification: $verification, settings: $settings, createdAt: $createdAt, updatedAt: $updatedAt, lastActiveAt: $lastActiveAt, isActive: $isActive, isVerified: $isVerified, isBlocked: $isBlocked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.stats, stats) || other.stats == stats) &&
            (identical(other.verification, verification) ||
                other.verification == verification) &&
            (identical(other.settings, settings) ||
                other.settings == settings) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastActiveAt, lastActiveAt) ||
                other.lastActiveAt == lastActiveAt) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.isBlocked, isBlocked) ||
                other.isBlocked == isBlocked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      username,
      displayName,
      avatarUrl,
      phoneNumber,
      bio,
      const DeepCollectionEquality().hash(_roles),
      location,
      stats,
      verification,
      settings,
      createdAt,
      updatedAt,
      lastActiveAt,
      isActive,
      isVerified,
      isBlocked);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String id,
      required final String email,
      required final String username,
      final String? displayName,
      final String? avatarUrl,
      final String? phoneNumber,
      final String? bio,
      final List<String> roles,
      final UserLocation? location,
      final UserStats? stats,
      final UserVerification? verification,
      final UserSettings? settings,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final DateTime? lastActiveAt,
      final bool isActive,
      final bool isVerified,
      final bool isBlocked}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get username;
  @override
  String? get displayName;
  @override
  String? get avatarUrl;
  @override
  String? get phoneNumber;
  @override
  String? get bio;
  @override
  List<String> get roles;
  @override
  UserLocation? get location;
  @override
  UserStats? get stats;
  @override
  UserVerification? get verification;
  @override
  UserSettings? get settings;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get lastActiveAt;
  @override
  bool get isActive;
  @override
  bool get isVerified;
  @override
  bool get isBlocked;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserLocation _$UserLocationFromJson(Map<String, dynamic> json) {
  return _UserLocation.fromJson(json);
}

/// @nodoc
mixin _$UserLocation {
  String? get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;

  /// Serializes this UserLocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserLocationCopyWith<UserLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserLocationCopyWith<$Res> {
  factory $UserLocationCopyWith(
          UserLocation value, $Res Function(UserLocation) then) =
      _$UserLocationCopyWithImpl<$Res, UserLocation>;
  @useResult
  $Res call(
      {String? address,
      String? city,
      String? state,
      String? country,
      String? postalCode,
      double? latitude,
      double? longitude});
}

/// @nodoc
class _$UserLocationCopyWithImpl<$Res, $Val extends UserLocation>
    implements $UserLocationCopyWith<$Res> {
  _$UserLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? postalCode = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_value.copyWith(
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserLocationImplCopyWith<$Res>
    implements $UserLocationCopyWith<$Res> {
  factory _$$UserLocationImplCopyWith(
          _$UserLocationImpl value, $Res Function(_$UserLocationImpl) then) =
      __$$UserLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? address,
      String? city,
      String? state,
      String? country,
      String? postalCode,
      double? latitude,
      double? longitude});
}

/// @nodoc
class __$$UserLocationImplCopyWithImpl<$Res>
    extends _$UserLocationCopyWithImpl<$Res, _$UserLocationImpl>
    implements _$$UserLocationImplCopyWith<$Res> {
  __$$UserLocationImplCopyWithImpl(
      _$UserLocationImpl _value, $Res Function(_$UserLocationImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = freezed,
    Object? city = freezed,
    Object? state = freezed,
    Object? country = freezed,
    Object? postalCode = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_$UserLocationImpl(
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserLocationImpl implements _UserLocation {
  const _$UserLocationImpl(
      {this.address,
      this.city,
      this.state,
      this.country,
      this.postalCode,
      this.latitude,
      this.longitude});

  factory _$UserLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserLocationImplFromJson(json);

  @override
  final String? address;
  @override
  final String? city;
  @override
  final String? state;
  @override
  final String? country;
  @override
  final String? postalCode;
  @override
  final double? latitude;
  @override
  final double? longitude;

  @override
  String toString() {
    return 'UserLocation(address: $address, city: $city, state: $state, country: $country, postalCode: $postalCode, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserLocationImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, address, city, state, country,
      postalCode, latitude, longitude);

  /// Create a copy of UserLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserLocationImplCopyWith<_$UserLocationImpl> get copyWith =>
      __$$UserLocationImplCopyWithImpl<_$UserLocationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserLocationImplToJson(
      this,
    );
  }
}

abstract class _UserLocation implements UserLocation {
  const factory _UserLocation(
      {final String? address,
      final String? city,
      final String? state,
      final String? country,
      final String? postalCode,
      final double? latitude,
      final double? longitude}) = _$UserLocationImpl;

  factory _UserLocation.fromJson(Map<String, dynamic> json) =
      _$UserLocationImpl.fromJson;

  @override
  String? get address;
  @override
  String? get city;
  @override
  String? get state;
  @override
  String? get country;
  @override
  String? get postalCode;
  @override
  double? get latitude;
  @override
  double? get longitude;

  /// Create a copy of UserLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserLocationImplCopyWith<_$UserLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserStats _$UserStatsFromJson(Map<String, dynamic> json) {
  return _UserStats.fromJson(json);
}

/// @nodoc
mixin _$UserStats {
  int get listingsCount => throw _privateConstructorUsedError;
  int get activeListingsCount => throw _privateConstructorUsedError;
  int get soldListingsCount => throw _privateConstructorUsedError;
  int get bidsPlacedCount => throw _privateConstructorUsedError;
  int get bidsWonCount => throw _privateConstructorUsedError;
  int get reviewsCount => throw _privateConstructorUsedError;
  double get averageRating => throw _privateConstructorUsedError;
  int get followersCount => throw _privateConstructorUsedError;
  int get followingCount => throw _privateConstructorUsedError;

  /// Serializes this UserStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserStatsCopyWith<UserStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserStatsCopyWith<$Res> {
  factory $UserStatsCopyWith(UserStats value, $Res Function(UserStats) then) =
      _$UserStatsCopyWithImpl<$Res, UserStats>;
  @useResult
  $Res call(
      {int listingsCount,
      int activeListingsCount,
      int soldListingsCount,
      int bidsPlacedCount,
      int bidsWonCount,
      int reviewsCount,
      double averageRating,
      int followersCount,
      int followingCount});
}

/// @nodoc
class _$UserStatsCopyWithImpl<$Res, $Val extends UserStats>
    implements $UserStatsCopyWith<$Res> {
  _$UserStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listingsCount = null,
    Object? activeListingsCount = null,
    Object? soldListingsCount = null,
    Object? bidsPlacedCount = null,
    Object? bidsWonCount = null,
    Object? reviewsCount = null,
    Object? averageRating = null,
    Object? followersCount = null,
    Object? followingCount = null,
  }) {
    return _then(_value.copyWith(
      listingsCount: null == listingsCount
          ? _value.listingsCount
          : listingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      activeListingsCount: null == activeListingsCount
          ? _value.activeListingsCount
          : activeListingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      soldListingsCount: null == soldListingsCount
          ? _value.soldListingsCount
          : soldListingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      bidsPlacedCount: null == bidsPlacedCount
          ? _value.bidsPlacedCount
          : bidsPlacedCount // ignore: cast_nullable_to_non_nullable
              as int,
      bidsWonCount: null == bidsWonCount
          ? _value.bidsWonCount
          : bidsWonCount // ignore: cast_nullable_to_non_nullable
              as int,
      reviewsCount: null == reviewsCount
          ? _value.reviewsCount
          : reviewsCount // ignore: cast_nullable_to_non_nullable
              as int,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      followersCount: null == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _value.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserStatsImplCopyWith<$Res>
    implements $UserStatsCopyWith<$Res> {
  factory _$$UserStatsImplCopyWith(
          _$UserStatsImpl value, $Res Function(_$UserStatsImpl) then) =
      __$$UserStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int listingsCount,
      int activeListingsCount,
      int soldListingsCount,
      int bidsPlacedCount,
      int bidsWonCount,
      int reviewsCount,
      double averageRating,
      int followersCount,
      int followingCount});
}

/// @nodoc
class __$$UserStatsImplCopyWithImpl<$Res>
    extends _$UserStatsCopyWithImpl<$Res, _$UserStatsImpl>
    implements _$$UserStatsImplCopyWith<$Res> {
  __$$UserStatsImplCopyWithImpl(
      _$UserStatsImpl _value, $Res Function(_$UserStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? listingsCount = null,
    Object? activeListingsCount = null,
    Object? soldListingsCount = null,
    Object? bidsPlacedCount = null,
    Object? bidsWonCount = null,
    Object? reviewsCount = null,
    Object? averageRating = null,
    Object? followersCount = null,
    Object? followingCount = null,
  }) {
    return _then(_$UserStatsImpl(
      listingsCount: null == listingsCount
          ? _value.listingsCount
          : listingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      activeListingsCount: null == activeListingsCount
          ? _value.activeListingsCount
          : activeListingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      soldListingsCount: null == soldListingsCount
          ? _value.soldListingsCount
          : soldListingsCount // ignore: cast_nullable_to_non_nullable
              as int,
      bidsPlacedCount: null == bidsPlacedCount
          ? _value.bidsPlacedCount
          : bidsPlacedCount // ignore: cast_nullable_to_non_nullable
              as int,
      bidsWonCount: null == bidsWonCount
          ? _value.bidsWonCount
          : bidsWonCount // ignore: cast_nullable_to_non_nullable
              as int,
      reviewsCount: null == reviewsCount
          ? _value.reviewsCount
          : reviewsCount // ignore: cast_nullable_to_non_nullable
              as int,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      followersCount: null == followersCount
          ? _value.followersCount
          : followersCount // ignore: cast_nullable_to_non_nullable
              as int,
      followingCount: null == followingCount
          ? _value.followingCount
          : followingCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserStatsImpl implements _UserStats {
  const _$UserStatsImpl(
      {this.listingsCount = 0,
      this.activeListingsCount = 0,
      this.soldListingsCount = 0,
      this.bidsPlacedCount = 0,
      this.bidsWonCount = 0,
      this.reviewsCount = 0,
      this.averageRating = 0.0,
      this.followersCount = 0,
      this.followingCount = 0});

  factory _$UserStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserStatsImplFromJson(json);

  @override
  @JsonKey()
  final int listingsCount;
  @override
  @JsonKey()
  final int activeListingsCount;
  @override
  @JsonKey()
  final int soldListingsCount;
  @override
  @JsonKey()
  final int bidsPlacedCount;
  @override
  @JsonKey()
  final int bidsWonCount;
  @override
  @JsonKey()
  final int reviewsCount;
  @override
  @JsonKey()
  final double averageRating;
  @override
  @JsonKey()
  final int followersCount;
  @override
  @JsonKey()
  final int followingCount;

  @override
  String toString() {
    return 'UserStats(listingsCount: $listingsCount, activeListingsCount: $activeListingsCount, soldListingsCount: $soldListingsCount, bidsPlacedCount: $bidsPlacedCount, bidsWonCount: $bidsWonCount, reviewsCount: $reviewsCount, averageRating: $averageRating, followersCount: $followersCount, followingCount: $followingCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStatsImpl &&
            (identical(other.listingsCount, listingsCount) ||
                other.listingsCount == listingsCount) &&
            (identical(other.activeListingsCount, activeListingsCount) ||
                other.activeListingsCount == activeListingsCount) &&
            (identical(other.soldListingsCount, soldListingsCount) ||
                other.soldListingsCount == soldListingsCount) &&
            (identical(other.bidsPlacedCount, bidsPlacedCount) ||
                other.bidsPlacedCount == bidsPlacedCount) &&
            (identical(other.bidsWonCount, bidsWonCount) ||
                other.bidsWonCount == bidsWonCount) &&
            (identical(other.reviewsCount, reviewsCount) ||
                other.reviewsCount == reviewsCount) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.followersCount, followersCount) ||
                other.followersCount == followersCount) &&
            (identical(other.followingCount, followingCount) ||
                other.followingCount == followingCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      listingsCount,
      activeListingsCount,
      soldListingsCount,
      bidsPlacedCount,
      bidsWonCount,
      reviewsCount,
      averageRating,
      followersCount,
      followingCount);

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      __$$UserStatsImplCopyWithImpl<_$UserStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserStatsImplToJson(
      this,
    );
  }
}

abstract class _UserStats implements UserStats {
  const factory _UserStats(
      {final int listingsCount,
      final int activeListingsCount,
      final int soldListingsCount,
      final int bidsPlacedCount,
      final int bidsWonCount,
      final int reviewsCount,
      final double averageRating,
      final int followersCount,
      final int followingCount}) = _$UserStatsImpl;

  factory _UserStats.fromJson(Map<String, dynamic> json) =
      _$UserStatsImpl.fromJson;

  @override
  int get listingsCount;
  @override
  int get activeListingsCount;
  @override
  int get soldListingsCount;
  @override
  int get bidsPlacedCount;
  @override
  int get bidsWonCount;
  @override
  int get reviewsCount;
  @override
  double get averageRating;
  @override
  int get followersCount;
  @override
  int get followingCount;

  /// Create a copy of UserStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserStatsImplCopyWith<_$UserStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserVerification _$UserVerificationFromJson(Map<String, dynamic> json) {
  return _UserVerification.fromJson(json);
}

/// @nodoc
mixin _$UserVerification {
  bool get isEmailVerified => throw _privateConstructorUsedError;
  bool get isPhoneVerified => throw _privateConstructorUsedError;
  bool get isIdentityVerified => throw _privateConstructorUsedError;
  DateTime? get emailVerifiedAt => throw _privateConstructorUsedError;
  DateTime? get phoneVerifiedAt => throw _privateConstructorUsedError;
  DateTime? get identityVerifiedAt => throw _privateConstructorUsedError;

  /// Serializes this UserVerification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserVerification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserVerificationCopyWith<UserVerification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserVerificationCopyWith<$Res> {
  factory $UserVerificationCopyWith(
          UserVerification value, $Res Function(UserVerification) then) =
      _$UserVerificationCopyWithImpl<$Res, UserVerification>;
  @useResult
  $Res call(
      {bool isEmailVerified,
      bool isPhoneVerified,
      bool isIdentityVerified,
      DateTime? emailVerifiedAt,
      DateTime? phoneVerifiedAt,
      DateTime? identityVerifiedAt});
}

/// @nodoc
class _$UserVerificationCopyWithImpl<$Res, $Val extends UserVerification>
    implements $UserVerificationCopyWith<$Res> {
  _$UserVerificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserVerification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEmailVerified = null,
    Object? isPhoneVerified = null,
    Object? isIdentityVerified = null,
    Object? emailVerifiedAt = freezed,
    Object? phoneVerifiedAt = freezed,
    Object? identityVerifiedAt = freezed,
  }) {
    return _then(_value.copyWith(
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isPhoneVerified: null == isPhoneVerified
          ? _value.isPhoneVerified
          : isPhoneVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isIdentityVerified: null == isIdentityVerified
          ? _value.isIdentityVerified
          : isIdentityVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      emailVerifiedAt: freezed == emailVerifiedAt
          ? _value.emailVerifiedAt
          : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      phoneVerifiedAt: freezed == phoneVerifiedAt
          ? _value.phoneVerifiedAt
          : phoneVerifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      identityVerifiedAt: freezed == identityVerifiedAt
          ? _value.identityVerifiedAt
          : identityVerifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserVerificationImplCopyWith<$Res>
    implements $UserVerificationCopyWith<$Res> {
  factory _$$UserVerificationImplCopyWith(_$UserVerificationImpl value,
          $Res Function(_$UserVerificationImpl) then) =
      __$$UserVerificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isEmailVerified,
      bool isPhoneVerified,
      bool isIdentityVerified,
      DateTime? emailVerifiedAt,
      DateTime? phoneVerifiedAt,
      DateTime? identityVerifiedAt});
}

/// @nodoc
class __$$UserVerificationImplCopyWithImpl<$Res>
    extends _$UserVerificationCopyWithImpl<$Res, _$UserVerificationImpl>
    implements _$$UserVerificationImplCopyWith<$Res> {
  __$$UserVerificationImplCopyWithImpl(_$UserVerificationImpl _value,
      $Res Function(_$UserVerificationImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserVerification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isEmailVerified = null,
    Object? isPhoneVerified = null,
    Object? isIdentityVerified = null,
    Object? emailVerifiedAt = freezed,
    Object? phoneVerifiedAt = freezed,
    Object? identityVerifiedAt = freezed,
  }) {
    return _then(_$UserVerificationImpl(
      isEmailVerified: null == isEmailVerified
          ? _value.isEmailVerified
          : isEmailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isPhoneVerified: null == isPhoneVerified
          ? _value.isPhoneVerified
          : isPhoneVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      isIdentityVerified: null == isIdentityVerified
          ? _value.isIdentityVerified
          : isIdentityVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      emailVerifiedAt: freezed == emailVerifiedAt
          ? _value.emailVerifiedAt
          : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      phoneVerifiedAt: freezed == phoneVerifiedAt
          ? _value.phoneVerifiedAt
          : phoneVerifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      identityVerifiedAt: freezed == identityVerifiedAt
          ? _value.identityVerifiedAt
          : identityVerifiedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserVerificationImpl implements _UserVerification {
  const _$UserVerificationImpl(
      {this.isEmailVerified = false,
      this.isPhoneVerified = false,
      this.isIdentityVerified = false,
      this.emailVerifiedAt,
      this.phoneVerifiedAt,
      this.identityVerifiedAt});

  factory _$UserVerificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserVerificationImplFromJson(json);

  @override
  @JsonKey()
  final bool isEmailVerified;
  @override
  @JsonKey()
  final bool isPhoneVerified;
  @override
  @JsonKey()
  final bool isIdentityVerified;
  @override
  final DateTime? emailVerifiedAt;
  @override
  final DateTime? phoneVerifiedAt;
  @override
  final DateTime? identityVerifiedAt;

  @override
  String toString() {
    return 'UserVerification(isEmailVerified: $isEmailVerified, isPhoneVerified: $isPhoneVerified, isIdentityVerified: $isIdentityVerified, emailVerifiedAt: $emailVerifiedAt, phoneVerifiedAt: $phoneVerifiedAt, identityVerifiedAt: $identityVerifiedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserVerificationImpl &&
            (identical(other.isEmailVerified, isEmailVerified) ||
                other.isEmailVerified == isEmailVerified) &&
            (identical(other.isPhoneVerified, isPhoneVerified) ||
                other.isPhoneVerified == isPhoneVerified) &&
            (identical(other.isIdentityVerified, isIdentityVerified) ||
                other.isIdentityVerified == isIdentityVerified) &&
            (identical(other.emailVerifiedAt, emailVerifiedAt) ||
                other.emailVerifiedAt == emailVerifiedAt) &&
            (identical(other.phoneVerifiedAt, phoneVerifiedAt) ||
                other.phoneVerifiedAt == phoneVerifiedAt) &&
            (identical(other.identityVerifiedAt, identityVerifiedAt) ||
                other.identityVerifiedAt == identityVerifiedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isEmailVerified, isPhoneVerified,
      isIdentityVerified, emailVerifiedAt, phoneVerifiedAt, identityVerifiedAt);

  /// Create a copy of UserVerification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserVerificationImplCopyWith<_$UserVerificationImpl> get copyWith =>
      __$$UserVerificationImplCopyWithImpl<_$UserVerificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserVerificationImplToJson(
      this,
    );
  }
}

abstract class _UserVerification implements UserVerification {
  const factory _UserVerification(
      {final bool isEmailVerified,
      final bool isPhoneVerified,
      final bool isIdentityVerified,
      final DateTime? emailVerifiedAt,
      final DateTime? phoneVerifiedAt,
      final DateTime? identityVerifiedAt}) = _$UserVerificationImpl;

  factory _UserVerification.fromJson(Map<String, dynamic> json) =
      _$UserVerificationImpl.fromJson;

  @override
  bool get isEmailVerified;
  @override
  bool get isPhoneVerified;
  @override
  bool get isIdentityVerified;
  @override
  DateTime? get emailVerifiedAt;
  @override
  DateTime? get phoneVerifiedAt;
  @override
  DateTime? get identityVerifiedAt;

  /// Create a copy of UserVerification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserVerificationImplCopyWith<_$UserVerificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserSettings _$UserSettingsFromJson(Map<String, dynamic> json) {
  return _UserSettings.fromJson(json);
}

/// @nodoc
mixin _$UserSettings {
  bool get notificationsEnabled => throw _privateConstructorUsedError;
  bool get emailNotificationsEnabled => throw _privateConstructorUsedError;
  bool get pushNotificationsEnabled => throw _privateConstructorUsedError;
  bool get bidNotificationsEnabled => throw _privateConstructorUsedError;
  bool get messageNotificationsEnabled => throw _privateConstructorUsedError;
  String get themeMode => throw _privateConstructorUsedError;
  String get language => throw _privateConstructorUsedError;
  String get currency => throw _privateConstructorUsedError;

  /// Serializes this UserSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserSettingsCopyWith<UserSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSettingsCopyWith<$Res> {
  factory $UserSettingsCopyWith(
          UserSettings value, $Res Function(UserSettings) then) =
      _$UserSettingsCopyWithImpl<$Res, UserSettings>;
  @useResult
  $Res call(
      {bool notificationsEnabled,
      bool emailNotificationsEnabled,
      bool pushNotificationsEnabled,
      bool bidNotificationsEnabled,
      bool messageNotificationsEnabled,
      String themeMode,
      String language,
      String currency});
}

/// @nodoc
class _$UserSettingsCopyWithImpl<$Res, $Val extends UserSettings>
    implements $UserSettingsCopyWith<$Res> {
  _$UserSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationsEnabled = null,
    Object? emailNotificationsEnabled = null,
    Object? pushNotificationsEnabled = null,
    Object? bidNotificationsEnabled = null,
    Object? messageNotificationsEnabled = null,
    Object? themeMode = null,
    Object? language = null,
    Object? currency = null,
  }) {
    return _then(_value.copyWith(
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailNotificationsEnabled: null == emailNotificationsEnabled
          ? _value.emailNotificationsEnabled
          : emailNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      pushNotificationsEnabled: null == pushNotificationsEnabled
          ? _value.pushNotificationsEnabled
          : pushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      bidNotificationsEnabled: null == bidNotificationsEnabled
          ? _value.bidNotificationsEnabled
          : bidNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      messageNotificationsEnabled: null == messageNotificationsEnabled
          ? _value.messageNotificationsEnabled
          : messageNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserSettingsImplCopyWith<$Res>
    implements $UserSettingsCopyWith<$Res> {
  factory _$$UserSettingsImplCopyWith(
          _$UserSettingsImpl value, $Res Function(_$UserSettingsImpl) then) =
      __$$UserSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool notificationsEnabled,
      bool emailNotificationsEnabled,
      bool pushNotificationsEnabled,
      bool bidNotificationsEnabled,
      bool messageNotificationsEnabled,
      String themeMode,
      String language,
      String currency});
}

/// @nodoc
class __$$UserSettingsImplCopyWithImpl<$Res>
    extends _$UserSettingsCopyWithImpl<$Res, _$UserSettingsImpl>
    implements _$$UserSettingsImplCopyWith<$Res> {
  __$$UserSettingsImplCopyWithImpl(
      _$UserSettingsImpl _value, $Res Function(_$UserSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationsEnabled = null,
    Object? emailNotificationsEnabled = null,
    Object? pushNotificationsEnabled = null,
    Object? bidNotificationsEnabled = null,
    Object? messageNotificationsEnabled = null,
    Object? themeMode = null,
    Object? language = null,
    Object? currency = null,
  }) {
    return _then(_$UserSettingsImpl(
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      emailNotificationsEnabled: null == emailNotificationsEnabled
          ? _value.emailNotificationsEnabled
          : emailNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      pushNotificationsEnabled: null == pushNotificationsEnabled
          ? _value.pushNotificationsEnabled
          : pushNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      bidNotificationsEnabled: null == bidNotificationsEnabled
          ? _value.bidNotificationsEnabled
          : bidNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      messageNotificationsEnabled: null == messageNotificationsEnabled
          ? _value.messageNotificationsEnabled
          : messageNotificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserSettingsImpl implements _UserSettings {
  const _$UserSettingsImpl(
      {this.notificationsEnabled = true,
      this.emailNotificationsEnabled = true,
      this.pushNotificationsEnabled = true,
      this.bidNotificationsEnabled = true,
      this.messageNotificationsEnabled = true,
      this.themeMode = 'light',
      this.language = 'en',
      this.currency = 'USD'});

  factory _$UserSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserSettingsImplFromJson(json);

  @override
  @JsonKey()
  final bool notificationsEnabled;
  @override
  @JsonKey()
  final bool emailNotificationsEnabled;
  @override
  @JsonKey()
  final bool pushNotificationsEnabled;
  @override
  @JsonKey()
  final bool bidNotificationsEnabled;
  @override
  @JsonKey()
  final bool messageNotificationsEnabled;
  @override
  @JsonKey()
  final String themeMode;
  @override
  @JsonKey()
  final String language;
  @override
  @JsonKey()
  final String currency;

  @override
  String toString() {
    return 'UserSettings(notificationsEnabled: $notificationsEnabled, emailNotificationsEnabled: $emailNotificationsEnabled, pushNotificationsEnabled: $pushNotificationsEnabled, bidNotificationsEnabled: $bidNotificationsEnabled, messageNotificationsEnabled: $messageNotificationsEnabled, themeMode: $themeMode, language: $language, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserSettingsImpl &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            (identical(other.emailNotificationsEnabled,
                    emailNotificationsEnabled) ||
                other.emailNotificationsEnabled == emailNotificationsEnabled) &&
            (identical(
                    other.pushNotificationsEnabled, pushNotificationsEnabled) ||
                other.pushNotificationsEnabled == pushNotificationsEnabled) &&
            (identical(
                    other.bidNotificationsEnabled, bidNotificationsEnabled) ||
                other.bidNotificationsEnabled == bidNotificationsEnabled) &&
            (identical(other.messageNotificationsEnabled,
                    messageNotificationsEnabled) ||
                other.messageNotificationsEnabled ==
                    messageNotificationsEnabled) &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.currency, currency) ||
                other.currency == currency));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      notificationsEnabled,
      emailNotificationsEnabled,
      pushNotificationsEnabled,
      bidNotificationsEnabled,
      messageNotificationsEnabled,
      themeMode,
      language,
      currency);

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      __$$UserSettingsImplCopyWithImpl<_$UserSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserSettingsImplToJson(
      this,
    );
  }
}

abstract class _UserSettings implements UserSettings {
  const factory _UserSettings(
      {final bool notificationsEnabled,
      final bool emailNotificationsEnabled,
      final bool pushNotificationsEnabled,
      final bool bidNotificationsEnabled,
      final bool messageNotificationsEnabled,
      final String themeMode,
      final String language,
      final String currency}) = _$UserSettingsImpl;

  factory _UserSettings.fromJson(Map<String, dynamic> json) =
      _$UserSettingsImpl.fromJson;

  @override
  bool get notificationsEnabled;
  @override
  bool get emailNotificationsEnabled;
  @override
  bool get pushNotificationsEnabled;
  @override
  bool get bidNotificationsEnabled;
  @override
  bool get messageNotificationsEnabled;
  @override
  String get themeMode;
  @override
  String get language;
  @override
  String get currency;

  /// Create a copy of UserSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserSettingsImplCopyWith<_$UserSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
