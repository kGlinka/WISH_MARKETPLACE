// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bid_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BidModel _$BidModelFromJson(Map<String, dynamic> json) {
  return _BidModel.fromJson(json);
}

/// @nodoc
mixin _$BidModel {
  String get id => throw _privateConstructorUsedError;
  String get listingId => throw _privateConstructorUsedError;
  String get bidderId => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError; // in cents
  BidStatus get status => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  bool get isAutoBid => throw _privateConstructorUsedError;
  int? get maxAutoBidAmount =>
      throw _privateConstructorUsedError; // in cents for auto-bidding
  bool get isProxy => throw _privateConstructorUsedError;
  String? get proxyBidId =>
      throw _privateConstructorUsedError; // reference to the proxy bid if this is an auto-increment
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  String? get cancellationReason => throw _privateConstructorUsedError;

  /// Serializes this BidModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BidModelCopyWith<BidModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BidModelCopyWith<$Res> {
  factory $BidModelCopyWith(BidModel value, $Res Function(BidModel) then) =
      _$BidModelCopyWithImpl<$Res, BidModel>;
  @useResult
  $Res call(
      {String id,
      String listingId,
      String bidderId,
      int amount,
      BidStatus status,
      String? message,
      bool isAutoBid,
      int? maxAutoBidAmount,
      bool isProxy,
      String? proxyBidId,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? cancelledAt,
      String? cancellationReason});
}

/// @nodoc
class _$BidModelCopyWithImpl<$Res, $Val extends BidModel>
    implements $BidModelCopyWith<$Res> {
  _$BidModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listingId = null,
    Object? bidderId = null,
    Object? amount = null,
    Object? status = null,
    Object? message = freezed,
    Object? isAutoBid = null,
    Object? maxAutoBidAmount = freezed,
    Object? isProxy = null,
    Object? proxyBidId = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? cancelledAt = freezed,
    Object? cancellationReason = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      listingId: null == listingId
          ? _value.listingId
          : listingId // ignore: cast_nullable_to_non_nullable
              as String,
      bidderId: null == bidderId
          ? _value.bidderId
          : bidderId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BidStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      isAutoBid: null == isAutoBid
          ? _value.isAutoBid
          : isAutoBid // ignore: cast_nullable_to_non_nullable
              as bool,
      maxAutoBidAmount: freezed == maxAutoBidAmount
          ? _value.maxAutoBidAmount
          : maxAutoBidAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      isProxy: null == isProxy
          ? _value.isProxy
          : isProxy // ignore: cast_nullable_to_non_nullable
              as bool,
      proxyBidId: freezed == proxyBidId
          ? _value.proxyBidId
          : proxyBidId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancellationReason: freezed == cancellationReason
          ? _value.cancellationReason
          : cancellationReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BidModelImplCopyWith<$Res>
    implements $BidModelCopyWith<$Res> {
  factory _$$BidModelImplCopyWith(
          _$BidModelImpl value, $Res Function(_$BidModelImpl) then) =
      __$$BidModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String listingId,
      String bidderId,
      int amount,
      BidStatus status,
      String? message,
      bool isAutoBid,
      int? maxAutoBidAmount,
      bool isProxy,
      String? proxyBidId,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? cancelledAt,
      String? cancellationReason});
}

/// @nodoc
class __$$BidModelImplCopyWithImpl<$Res>
    extends _$BidModelCopyWithImpl<$Res, _$BidModelImpl>
    implements _$$BidModelImplCopyWith<$Res> {
  __$$BidModelImplCopyWithImpl(
      _$BidModelImpl _value, $Res Function(_$BidModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? listingId = null,
    Object? bidderId = null,
    Object? amount = null,
    Object? status = null,
    Object? message = freezed,
    Object? isAutoBid = null,
    Object? maxAutoBidAmount = freezed,
    Object? isProxy = null,
    Object? proxyBidId = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? cancelledAt = freezed,
    Object? cancellationReason = freezed,
  }) {
    return _then(_$BidModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      listingId: null == listingId
          ? _value.listingId
          : listingId // ignore: cast_nullable_to_non_nullable
              as String,
      bidderId: null == bidderId
          ? _value.bidderId
          : bidderId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as BidStatus,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      isAutoBid: null == isAutoBid
          ? _value.isAutoBid
          : isAutoBid // ignore: cast_nullable_to_non_nullable
              as bool,
      maxAutoBidAmount: freezed == maxAutoBidAmount
          ? _value.maxAutoBidAmount
          : maxAutoBidAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      isProxy: null == isProxy
          ? _value.isProxy
          : isProxy // ignore: cast_nullable_to_non_nullable
              as bool,
      proxyBidId: freezed == proxyBidId
          ? _value.proxyBidId
          : proxyBidId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancellationReason: freezed == cancellationReason
          ? _value.cancellationReason
          : cancellationReason // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BidModelImpl implements _BidModel {
  const _$BidModelImpl(
      {required this.id,
      required this.listingId,
      required this.bidderId,
      required this.amount,
      required this.status,
      this.message,
      this.isAutoBid = false,
      this.maxAutoBidAmount,
      this.isProxy = false,
      this.proxyBidId,
      required this.createdAt,
      this.updatedAt,
      this.cancelledAt,
      this.cancellationReason});

  factory _$BidModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BidModelImplFromJson(json);

  @override
  final String id;
  @override
  final String listingId;
  @override
  final String bidderId;
  @override
  final int amount;
// in cents
  @override
  final BidStatus status;
  @override
  final String? message;
  @override
  @JsonKey()
  final bool isAutoBid;
  @override
  final int? maxAutoBidAmount;
// in cents for auto-bidding
  @override
  @JsonKey()
  final bool isProxy;
  @override
  final String? proxyBidId;
// reference to the proxy bid if this is an auto-increment
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? cancelledAt;
  @override
  final String? cancellationReason;

  @override
  String toString() {
    return 'BidModel(id: $id, listingId: $listingId, bidderId: $bidderId, amount: $amount, status: $status, message: $message, isAutoBid: $isAutoBid, maxAutoBidAmount: $maxAutoBidAmount, isProxy: $isProxy, proxyBidId: $proxyBidId, createdAt: $createdAt, updatedAt: $updatedAt, cancelledAt: $cancelledAt, cancellationReason: $cancellationReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BidModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.listingId, listingId) ||
                other.listingId == listingId) &&
            (identical(other.bidderId, bidderId) ||
                other.bidderId == bidderId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isAutoBid, isAutoBid) ||
                other.isAutoBid == isAutoBid) &&
            (identical(other.maxAutoBidAmount, maxAutoBidAmount) ||
                other.maxAutoBidAmount == maxAutoBidAmount) &&
            (identical(other.isProxy, isProxy) || other.isProxy == isProxy) &&
            (identical(other.proxyBidId, proxyBidId) ||
                other.proxyBidId == proxyBidId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.cancellationReason, cancellationReason) ||
                other.cancellationReason == cancellationReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      listingId,
      bidderId,
      amount,
      status,
      message,
      isAutoBid,
      maxAutoBidAmount,
      isProxy,
      proxyBidId,
      createdAt,
      updatedAt,
      cancelledAt,
      cancellationReason);

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BidModelImplCopyWith<_$BidModelImpl> get copyWith =>
      __$$BidModelImplCopyWithImpl<_$BidModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BidModelImplToJson(
      this,
    );
  }
}

abstract class _BidModel implements BidModel {
  const factory _BidModel(
      {required final String id,
      required final String listingId,
      required final String bidderId,
      required final int amount,
      required final BidStatus status,
      final String? message,
      final bool isAutoBid,
      final int? maxAutoBidAmount,
      final bool isProxy,
      final String? proxyBidId,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final DateTime? cancelledAt,
      final String? cancellationReason}) = _$BidModelImpl;

  factory _BidModel.fromJson(Map<String, dynamic> json) =
      _$BidModelImpl.fromJson;

  @override
  String get id;
  @override
  String get listingId;
  @override
  String get bidderId;
  @override
  int get amount; // in cents
  @override
  BidStatus get status;
  @override
  String? get message;
  @override
  bool get isAutoBid;
  @override
  int? get maxAutoBidAmount; // in cents for auto-bidding
  @override
  bool get isProxy;
  @override
  String?
      get proxyBidId; // reference to the proxy bid if this is an auto-increment
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get cancelledAt;
  @override
  String? get cancellationReason;

  /// Create a copy of BidModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BidModelImplCopyWith<_$BidModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BidHistoryEntry _$BidHistoryEntryFromJson(Map<String, dynamic> json) {
  return _BidHistoryEntry.fromJson(json);
}

/// @nodoc
mixin _$BidHistoryEntry {
  String get bidId => throw _privateConstructorUsedError;
  String get bidderId => throw _privateConstructorUsedError;
  String? get bidderUsername => throw _privateConstructorUsedError;
  String? get bidderAvatarUrl => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Serializes this BidHistoryEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BidHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BidHistoryEntryCopyWith<BidHistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BidHistoryEntryCopyWith<$Res> {
  factory $BidHistoryEntryCopyWith(
          BidHistoryEntry value, $Res Function(BidHistoryEntry) then) =
      _$BidHistoryEntryCopyWithImpl<$Res, BidHistoryEntry>;
  @useResult
  $Res call(
      {String bidId,
      String bidderId,
      String? bidderUsername,
      String? bidderAvatarUrl,
      int amount,
      DateTime timestamp});
}

/// @nodoc
class _$BidHistoryEntryCopyWithImpl<$Res, $Val extends BidHistoryEntry>
    implements $BidHistoryEntryCopyWith<$Res> {
  _$BidHistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BidHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bidId = null,
    Object? bidderId = null,
    Object? bidderUsername = freezed,
    Object? bidderAvatarUrl = freezed,
    Object? amount = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      bidId: null == bidId
          ? _value.bidId
          : bidId // ignore: cast_nullable_to_non_nullable
              as String,
      bidderId: null == bidderId
          ? _value.bidderId
          : bidderId // ignore: cast_nullable_to_non_nullable
              as String,
      bidderUsername: freezed == bidderUsername
          ? _value.bidderUsername
          : bidderUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      bidderAvatarUrl: freezed == bidderAvatarUrl
          ? _value.bidderAvatarUrl
          : bidderAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BidHistoryEntryImplCopyWith<$Res>
    implements $BidHistoryEntryCopyWith<$Res> {
  factory _$$BidHistoryEntryImplCopyWith(_$BidHistoryEntryImpl value,
          $Res Function(_$BidHistoryEntryImpl) then) =
      __$$BidHistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String bidId,
      String bidderId,
      String? bidderUsername,
      String? bidderAvatarUrl,
      int amount,
      DateTime timestamp});
}

/// @nodoc
class __$$BidHistoryEntryImplCopyWithImpl<$Res>
    extends _$BidHistoryEntryCopyWithImpl<$Res, _$BidHistoryEntryImpl>
    implements _$$BidHistoryEntryImplCopyWith<$Res> {
  __$$BidHistoryEntryImplCopyWithImpl(
      _$BidHistoryEntryImpl _value, $Res Function(_$BidHistoryEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of BidHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bidId = null,
    Object? bidderId = null,
    Object? bidderUsername = freezed,
    Object? bidderAvatarUrl = freezed,
    Object? amount = null,
    Object? timestamp = null,
  }) {
    return _then(_$BidHistoryEntryImpl(
      bidId: null == bidId
          ? _value.bidId
          : bidId // ignore: cast_nullable_to_non_nullable
              as String,
      bidderId: null == bidderId
          ? _value.bidderId
          : bidderId // ignore: cast_nullable_to_non_nullable
              as String,
      bidderUsername: freezed == bidderUsername
          ? _value.bidderUsername
          : bidderUsername // ignore: cast_nullable_to_non_nullable
              as String?,
      bidderAvatarUrl: freezed == bidderAvatarUrl
          ? _value.bidderAvatarUrl
          : bidderAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$BidHistoryEntryImpl implements _BidHistoryEntry {
  const _$BidHistoryEntryImpl(
      {required this.bidId,
      required this.bidderId,
      this.bidderUsername,
      this.bidderAvatarUrl,
      required this.amount,
      required this.timestamp});

  factory _$BidHistoryEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$BidHistoryEntryImplFromJson(json);

  @override
  final String bidId;
  @override
  final String bidderId;
  @override
  final String? bidderUsername;
  @override
  final String? bidderAvatarUrl;
  @override
  final int amount;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'BidHistoryEntry(bidId: $bidId, bidderId: $bidderId, bidderUsername: $bidderUsername, bidderAvatarUrl: $bidderAvatarUrl, amount: $amount, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BidHistoryEntryImpl &&
            (identical(other.bidId, bidId) || other.bidId == bidId) &&
            (identical(other.bidderId, bidderId) ||
                other.bidderId == bidderId) &&
            (identical(other.bidderUsername, bidderUsername) ||
                other.bidderUsername == bidderUsername) &&
            (identical(other.bidderAvatarUrl, bidderAvatarUrl) ||
                other.bidderAvatarUrl == bidderAvatarUrl) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, bidId, bidderId, bidderUsername,
      bidderAvatarUrl, amount, timestamp);

  /// Create a copy of BidHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BidHistoryEntryImplCopyWith<_$BidHistoryEntryImpl> get copyWith =>
      __$$BidHistoryEntryImplCopyWithImpl<_$BidHistoryEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BidHistoryEntryImplToJson(
      this,
    );
  }
}

abstract class _BidHistoryEntry implements BidHistoryEntry {
  const factory _BidHistoryEntry(
      {required final String bidId,
      required final String bidderId,
      final String? bidderUsername,
      final String? bidderAvatarUrl,
      required final int amount,
      required final DateTime timestamp}) = _$BidHistoryEntryImpl;

  factory _BidHistoryEntry.fromJson(Map<String, dynamic> json) =
      _$BidHistoryEntryImpl.fromJson;

  @override
  String get bidId;
  @override
  String get bidderId;
  @override
  String? get bidderUsername;
  @override
  String? get bidderAvatarUrl;
  @override
  int get amount;
  @override
  DateTime get timestamp;

  /// Create a copy of BidHistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BidHistoryEntryImplCopyWith<_$BidHistoryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
