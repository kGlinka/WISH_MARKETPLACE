// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) {
  return _TransactionModel.fromJson(json);
}

/// @nodoc
mixin _$TransactionModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get listingId => throw _privateConstructorUsedError;
  String? get bidId => throw _privateConstructorUsedError;
  String? get escrowId => throw _privateConstructorUsedError;
  TransactionType get type => throw _privateConstructorUsedError;
  TransactionStatus get status => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError; // in cents
  int? get fee => throw _privateConstructorUsedError; // platform fee in cents
  int? get netAmount =>
      throw _privateConstructorUsedError; // amount after fees in cents
  String get currency => throw _privateConstructorUsedError;
  PaymentMethod get paymentMethod => throw _privateConstructorUsedError;
  String? get paymentIntentId =>
      throw _privateConstructorUsedError; // Stripe payment intent ID
  String? get chargeId =>
      throw _privateConstructorUsedError; // Stripe charge ID
  String? get receiptUrl => throw _privateConstructorUsedError;
  String? get failureReason => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  DateTime? get refundedAt => throw _privateConstructorUsedError;

  /// Serializes this TransactionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TransactionModelCopyWith<TransactionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionModelCopyWith<$Res> {
  factory $TransactionModelCopyWith(
          TransactionModel value, $Res Function(TransactionModel) then) =
      _$TransactionModelCopyWithImpl<$Res, TransactionModel>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String listingId,
      String? bidId,
      String? escrowId,
      TransactionType type,
      TransactionStatus status,
      int amount,
      int? fee,
      int? netAmount,
      String currency,
      PaymentMethod paymentMethod,
      String? paymentIntentId,
      String? chargeId,
      String? receiptUrl,
      String? failureReason,
      String? description,
      Map<String, dynamic>? metadata,
      DateTime createdAt,
      DateTime? completedAt,
      DateTime? cancelledAt,
      DateTime? refundedAt});
}

/// @nodoc
class _$TransactionModelCopyWithImpl<$Res, $Val extends TransactionModel>
    implements $TransactionModelCopyWith<$Res> {
  _$TransactionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? listingId = null,
    Object? bidId = freezed,
    Object? escrowId = freezed,
    Object? type = null,
    Object? status = null,
    Object? amount = null,
    Object? fee = freezed,
    Object? netAmount = freezed,
    Object? currency = null,
    Object? paymentMethod = null,
    Object? paymentIntentId = freezed,
    Object? chargeId = freezed,
    Object? receiptUrl = freezed,
    Object? failureReason = freezed,
    Object? description = freezed,
    Object? metadata = freezed,
    Object? createdAt = null,
    Object? completedAt = freezed,
    Object? cancelledAt = freezed,
    Object? refundedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      listingId: null == listingId
          ? _value.listingId
          : listingId // ignore: cast_nullable_to_non_nullable
              as String,
      bidId: freezed == bidId
          ? _value.bidId
          : bidId // ignore: cast_nullable_to_non_nullable
              as String?,
      escrowId: freezed == escrowId
          ? _value.escrowId
          : escrowId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransactionStatus,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      fee: freezed == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int?,
      netAmount: freezed == netAmount
          ? _value.netAmount
          : netAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      paymentIntentId: freezed == paymentIntentId
          ? _value.paymentIntentId
          : paymentIntentId // ignore: cast_nullable_to_non_nullable
              as String?,
      chargeId: freezed == chargeId
          ? _value.chargeId
          : chargeId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      refundedAt: freezed == refundedAt
          ? _value.refundedAt
          : refundedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TransactionModelImplCopyWith<$Res>
    implements $TransactionModelCopyWith<$Res> {
  factory _$$TransactionModelImplCopyWith(_$TransactionModelImpl value,
          $Res Function(_$TransactionModelImpl) then) =
      __$$TransactionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String listingId,
      String? bidId,
      String? escrowId,
      TransactionType type,
      TransactionStatus status,
      int amount,
      int? fee,
      int? netAmount,
      String currency,
      PaymentMethod paymentMethod,
      String? paymentIntentId,
      String? chargeId,
      String? receiptUrl,
      String? failureReason,
      String? description,
      Map<String, dynamic>? metadata,
      DateTime createdAt,
      DateTime? completedAt,
      DateTime? cancelledAt,
      DateTime? refundedAt});
}

/// @nodoc
class __$$TransactionModelImplCopyWithImpl<$Res>
    extends _$TransactionModelCopyWithImpl<$Res, _$TransactionModelImpl>
    implements _$$TransactionModelImplCopyWith<$Res> {
  __$$TransactionModelImplCopyWithImpl(_$TransactionModelImpl _value,
      $Res Function(_$TransactionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? listingId = null,
    Object? bidId = freezed,
    Object? escrowId = freezed,
    Object? type = null,
    Object? status = null,
    Object? amount = null,
    Object? fee = freezed,
    Object? netAmount = freezed,
    Object? currency = null,
    Object? paymentMethod = null,
    Object? paymentIntentId = freezed,
    Object? chargeId = freezed,
    Object? receiptUrl = freezed,
    Object? failureReason = freezed,
    Object? description = freezed,
    Object? metadata = freezed,
    Object? createdAt = null,
    Object? completedAt = freezed,
    Object? cancelledAt = freezed,
    Object? refundedAt = freezed,
  }) {
    return _then(_$TransactionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      listingId: null == listingId
          ? _value.listingId
          : listingId // ignore: cast_nullable_to_non_nullable
              as String,
      bidId: freezed == bidId
          ? _value.bidId
          : bidId // ignore: cast_nullable_to_non_nullable
              as String?,
      escrowId: freezed == escrowId
          ? _value.escrowId
          : escrowId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as TransactionType,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TransactionStatus,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      fee: freezed == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as int?,
      netAmount: freezed == netAmount
          ? _value.netAmount
          : netAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      paymentMethod: null == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as PaymentMethod,
      paymentIntentId: freezed == paymentIntentId
          ? _value.paymentIntentId
          : paymentIntentId // ignore: cast_nullable_to_non_nullable
              as String?,
      chargeId: freezed == chargeId
          ? _value.chargeId
          : chargeId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiptUrl: freezed == receiptUrl
          ? _value.receiptUrl
          : receiptUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      refundedAt: freezed == refundedAt
          ? _value.refundedAt
          : refundedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TransactionModelImpl implements _TransactionModel {
  const _$TransactionModelImpl(
      {required this.id,
      required this.userId,
      required this.listingId,
      this.bidId,
      this.escrowId,
      required this.type,
      required this.status,
      required this.amount,
      this.fee,
      this.netAmount,
      required this.currency,
      required this.paymentMethod,
      this.paymentIntentId,
      this.chargeId,
      this.receiptUrl,
      this.failureReason,
      this.description,
      final Map<String, dynamic>? metadata,
      required this.createdAt,
      this.completedAt,
      this.cancelledAt,
      this.refundedAt})
      : _metadata = metadata;

  factory _$TransactionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TransactionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String listingId;
  @override
  final String? bidId;
  @override
  final String? escrowId;
  @override
  final TransactionType type;
  @override
  final TransactionStatus status;
  @override
  final int amount;
// in cents
  @override
  final int? fee;
// platform fee in cents
  @override
  final int? netAmount;
// amount after fees in cents
  @override
  final String currency;
  @override
  final PaymentMethod paymentMethod;
  @override
  final String? paymentIntentId;
// Stripe payment intent ID
  @override
  final String? chargeId;
// Stripe charge ID
  @override
  final String? receiptUrl;
  @override
  final String? failureReason;
  @override
  final String? description;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? cancelledAt;
  @override
  final DateTime? refundedAt;

  @override
  String toString() {
    return 'TransactionModel(id: $id, userId: $userId, listingId: $listingId, bidId: $bidId, escrowId: $escrowId, type: $type, status: $status, amount: $amount, fee: $fee, netAmount: $netAmount, currency: $currency, paymentMethod: $paymentMethod, paymentIntentId: $paymentIntentId, chargeId: $chargeId, receiptUrl: $receiptUrl, failureReason: $failureReason, description: $description, metadata: $metadata, createdAt: $createdAt, completedAt: $completedAt, cancelledAt: $cancelledAt, refundedAt: $refundedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.listingId, listingId) ||
                other.listingId == listingId) &&
            (identical(other.bidId, bidId) || other.bidId == bidId) &&
            (identical(other.escrowId, escrowId) ||
                other.escrowId == escrowId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.netAmount, netAmount) ||
                other.netAmount == netAmount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.paymentIntentId, paymentIntentId) ||
                other.paymentIntentId == paymentIntentId) &&
            (identical(other.chargeId, chargeId) ||
                other.chargeId == chargeId) &&
            (identical(other.receiptUrl, receiptUrl) ||
                other.receiptUrl == receiptUrl) &&
            (identical(other.failureReason, failureReason) ||
                other.failureReason == failureReason) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            (identical(other.refundedAt, refundedAt) ||
                other.refundedAt == refundedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        listingId,
        bidId,
        escrowId,
        type,
        status,
        amount,
        fee,
        netAmount,
        currency,
        paymentMethod,
        paymentIntentId,
        chargeId,
        receiptUrl,
        failureReason,
        description,
        const DeepCollectionEquality().hash(_metadata),
        createdAt,
        completedAt,
        cancelledAt,
        refundedAt
      ]);

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      __$$TransactionModelImplCopyWithImpl<_$TransactionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TransactionModelImplToJson(
      this,
    );
  }
}

abstract class _TransactionModel implements TransactionModel {
  const factory _TransactionModel(
      {required final String id,
      required final String userId,
      required final String listingId,
      final String? bidId,
      final String? escrowId,
      required final TransactionType type,
      required final TransactionStatus status,
      required final int amount,
      final int? fee,
      final int? netAmount,
      required final String currency,
      required final PaymentMethod paymentMethod,
      final String? paymentIntentId,
      final String? chargeId,
      final String? receiptUrl,
      final String? failureReason,
      final String? description,
      final Map<String, dynamic>? metadata,
      required final DateTime createdAt,
      final DateTime? completedAt,
      final DateTime? cancelledAt,
      final DateTime? refundedAt}) = _$TransactionModelImpl;

  factory _TransactionModel.fromJson(Map<String, dynamic> json) =
      _$TransactionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get listingId;
  @override
  String? get bidId;
  @override
  String? get escrowId;
  @override
  TransactionType get type;
  @override
  TransactionStatus get status;
  @override
  int get amount; // in cents
  @override
  int? get fee; // platform fee in cents
  @override
  int? get netAmount; // amount after fees in cents
  @override
  String get currency;
  @override
  PaymentMethod get paymentMethod;
  @override
  String? get paymentIntentId; // Stripe payment intent ID
  @override
  String? get chargeId; // Stripe charge ID
  @override
  String? get receiptUrl;
  @override
  String? get failureReason;
  @override
  String? get description;
  @override
  Map<String, dynamic>? get metadata;
  @override
  DateTime get createdAt;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get cancelledAt;
  @override
  DateTime? get refundedAt;

  /// Create a copy of TransactionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TransactionModelImplCopyWith<_$TransactionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

EscrowModel _$EscrowModelFromJson(Map<String, dynamic> json) {
  return _EscrowModel.fromJson(json);
}

/// @nodoc
mixin _$EscrowModel {
  String get id => throw _privateConstructorUsedError;
  String get transactionId => throw _privateConstructorUsedError;
  String get buyerId => throw _privateConstructorUsedError;
  String get sellerId => throw _privateConstructorUsedError;
  String get listingId => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError; // in cents
  String get status =>
      throw _privateConstructorUsedError; // pending, funded, released, refunded, disputed
  String? get releaseConditions => throw _privateConstructorUsedError;
  DateTime? get fundedAt => throw _privateConstructorUsedError;
  DateTime? get releasedAt => throw _privateConstructorUsedError;
  DateTime? get refundedAt => throw _privateConstructorUsedError;
  DateTime? get disputedAt => throw _privateConstructorUsedError;
  String? get disputeReason => throw _privateConstructorUsedError;
  String? get resolutionNotes => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this EscrowModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of EscrowModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EscrowModelCopyWith<EscrowModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EscrowModelCopyWith<$Res> {
  factory $EscrowModelCopyWith(
          EscrowModel value, $Res Function(EscrowModel) then) =
      _$EscrowModelCopyWithImpl<$Res, EscrowModel>;
  @useResult
  $Res call(
      {String id,
      String transactionId,
      String buyerId,
      String sellerId,
      String listingId,
      int amount,
      String status,
      String? releaseConditions,
      DateTime? fundedAt,
      DateTime? releasedAt,
      DateTime? refundedAt,
      DateTime? disputedAt,
      String? disputeReason,
      String? resolutionNotes,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$EscrowModelCopyWithImpl<$Res, $Val extends EscrowModel>
    implements $EscrowModelCopyWith<$Res> {
  _$EscrowModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EscrowModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? transactionId = null,
    Object? buyerId = null,
    Object? sellerId = null,
    Object? listingId = null,
    Object? amount = null,
    Object? status = null,
    Object? releaseConditions = freezed,
    Object? fundedAt = freezed,
    Object? releasedAt = freezed,
    Object? refundedAt = freezed,
    Object? disputedAt = freezed,
    Object? disputeReason = freezed,
    Object? resolutionNotes = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      buyerId: null == buyerId
          ? _value.buyerId
          : buyerId // ignore: cast_nullable_to_non_nullable
              as String,
      sellerId: null == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String,
      listingId: null == listingId
          ? _value.listingId
          : listingId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      releaseConditions: freezed == releaseConditions
          ? _value.releaseConditions
          : releaseConditions // ignore: cast_nullable_to_non_nullable
              as String?,
      fundedAt: freezed == fundedAt
          ? _value.fundedAt
          : fundedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      releasedAt: freezed == releasedAt
          ? _value.releasedAt
          : releasedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      refundedAt: freezed == refundedAt
          ? _value.refundedAt
          : refundedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      disputedAt: freezed == disputedAt
          ? _value.disputedAt
          : disputedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      disputeReason: freezed == disputeReason
          ? _value.disputeReason
          : disputeReason // ignore: cast_nullable_to_non_nullable
              as String?,
      resolutionNotes: freezed == resolutionNotes
          ? _value.resolutionNotes
          : resolutionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EscrowModelImplCopyWith<$Res>
    implements $EscrowModelCopyWith<$Res> {
  factory _$$EscrowModelImplCopyWith(
          _$EscrowModelImpl value, $Res Function(_$EscrowModelImpl) then) =
      __$$EscrowModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String transactionId,
      String buyerId,
      String sellerId,
      String listingId,
      int amount,
      String status,
      String? releaseConditions,
      DateTime? fundedAt,
      DateTime? releasedAt,
      DateTime? refundedAt,
      DateTime? disputedAt,
      String? disputeReason,
      String? resolutionNotes,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$EscrowModelImplCopyWithImpl<$Res>
    extends _$EscrowModelCopyWithImpl<$Res, _$EscrowModelImpl>
    implements _$$EscrowModelImplCopyWith<$Res> {
  __$$EscrowModelImplCopyWithImpl(
      _$EscrowModelImpl _value, $Res Function(_$EscrowModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of EscrowModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? transactionId = null,
    Object? buyerId = null,
    Object? sellerId = null,
    Object? listingId = null,
    Object? amount = null,
    Object? status = null,
    Object? releaseConditions = freezed,
    Object? fundedAt = freezed,
    Object? releasedAt = freezed,
    Object? refundedAt = freezed,
    Object? disputedAt = freezed,
    Object? disputeReason = freezed,
    Object? resolutionNotes = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$EscrowModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      buyerId: null == buyerId
          ? _value.buyerId
          : buyerId // ignore: cast_nullable_to_non_nullable
              as String,
      sellerId: null == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String,
      listingId: null == listingId
          ? _value.listingId
          : listingId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      releaseConditions: freezed == releaseConditions
          ? _value.releaseConditions
          : releaseConditions // ignore: cast_nullable_to_non_nullable
              as String?,
      fundedAt: freezed == fundedAt
          ? _value.fundedAt
          : fundedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      releasedAt: freezed == releasedAt
          ? _value.releasedAt
          : releasedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      refundedAt: freezed == refundedAt
          ? _value.refundedAt
          : refundedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      disputedAt: freezed == disputedAt
          ? _value.disputedAt
          : disputedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      disputeReason: freezed == disputeReason
          ? _value.disputeReason
          : disputeReason // ignore: cast_nullable_to_non_nullable
              as String?,
      resolutionNotes: freezed == resolutionNotes
          ? _value.resolutionNotes
          : resolutionNotes // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EscrowModelImpl implements _EscrowModel {
  const _$EscrowModelImpl(
      {required this.id,
      required this.transactionId,
      required this.buyerId,
      required this.sellerId,
      required this.listingId,
      required this.amount,
      required this.status,
      this.releaseConditions,
      this.fundedAt,
      this.releasedAt,
      this.refundedAt,
      this.disputedAt,
      this.disputeReason,
      this.resolutionNotes,
      required this.createdAt,
      this.updatedAt});

  factory _$EscrowModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EscrowModelImplFromJson(json);

  @override
  final String id;
  @override
  final String transactionId;
  @override
  final String buyerId;
  @override
  final String sellerId;
  @override
  final String listingId;
  @override
  final int amount;
// in cents
  @override
  final String status;
// pending, funded, released, refunded, disputed
  @override
  final String? releaseConditions;
  @override
  final DateTime? fundedAt;
  @override
  final DateTime? releasedAt;
  @override
  final DateTime? refundedAt;
  @override
  final DateTime? disputedAt;
  @override
  final String? disputeReason;
  @override
  final String? resolutionNotes;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'EscrowModel(id: $id, transactionId: $transactionId, buyerId: $buyerId, sellerId: $sellerId, listingId: $listingId, amount: $amount, status: $status, releaseConditions: $releaseConditions, fundedAt: $fundedAt, releasedAt: $releasedAt, refundedAt: $refundedAt, disputedAt: $disputedAt, disputeReason: $disputeReason, resolutionNotes: $resolutionNotes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EscrowModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.buyerId, buyerId) || other.buyerId == buyerId) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId) &&
            (identical(other.listingId, listingId) ||
                other.listingId == listingId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.releaseConditions, releaseConditions) ||
                other.releaseConditions == releaseConditions) &&
            (identical(other.fundedAt, fundedAt) ||
                other.fundedAt == fundedAt) &&
            (identical(other.releasedAt, releasedAt) ||
                other.releasedAt == releasedAt) &&
            (identical(other.refundedAt, refundedAt) ||
                other.refundedAt == refundedAt) &&
            (identical(other.disputedAt, disputedAt) ||
                other.disputedAt == disputedAt) &&
            (identical(other.disputeReason, disputeReason) ||
                other.disputeReason == disputeReason) &&
            (identical(other.resolutionNotes, resolutionNotes) ||
                other.resolutionNotes == resolutionNotes) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      transactionId,
      buyerId,
      sellerId,
      listingId,
      amount,
      status,
      releaseConditions,
      fundedAt,
      releasedAt,
      refundedAt,
      disputedAt,
      disputeReason,
      resolutionNotes,
      createdAt,
      updatedAt);

  /// Create a copy of EscrowModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EscrowModelImplCopyWith<_$EscrowModelImpl> get copyWith =>
      __$$EscrowModelImplCopyWithImpl<_$EscrowModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EscrowModelImplToJson(
      this,
    );
  }
}

abstract class _EscrowModel implements EscrowModel {
  const factory _EscrowModel(
      {required final String id,
      required final String transactionId,
      required final String buyerId,
      required final String sellerId,
      required final String listingId,
      required final int amount,
      required final String status,
      final String? releaseConditions,
      final DateTime? fundedAt,
      final DateTime? releasedAt,
      final DateTime? refundedAt,
      final DateTime? disputedAt,
      final String? disputeReason,
      final String? resolutionNotes,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$EscrowModelImpl;

  factory _EscrowModel.fromJson(Map<String, dynamic> json) =
      _$EscrowModelImpl.fromJson;

  @override
  String get id;
  @override
  String get transactionId;
  @override
  String get buyerId;
  @override
  String get sellerId;
  @override
  String get listingId;
  @override
  int get amount; // in cents
  @override
  String get status; // pending, funded, released, refunded, disputed
  @override
  String? get releaseConditions;
  @override
  DateTime? get fundedAt;
  @override
  DateTime? get releasedAt;
  @override
  DateTime? get refundedAt;
  @override
  DateTime? get disputedAt;
  @override
  String? get disputeReason;
  @override
  String? get resolutionNotes;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of EscrowModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EscrowModelImplCopyWith<_$EscrowModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PayoutModel _$PayoutModelFromJson(Map<String, dynamic> json) {
  return _PayoutModel.fromJson(json);
}

/// @nodoc
mixin _$PayoutModel {
  String get id => throw _privateConstructorUsedError;
  String get sellerId => throw _privateConstructorUsedError;
  int get amount => throw _privateConstructorUsedError; // in cents
  String get currency => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // pending, processing, paid, failed
  String? get stripePayoutId => throw _privateConstructorUsedError;
  String? get bankAccountId => throw _privateConstructorUsedError;
  String? get failureReason => throw _privateConstructorUsedError;
  List<String>? get transactionIds =>
      throw _privateConstructorUsedError; // list of transaction IDs included
  DateTime? get estimatedArrival => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get paidAt => throw _privateConstructorUsedError;
  DateTime? get failedAt => throw _privateConstructorUsedError;

  /// Serializes this PayoutModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PayoutModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PayoutModelCopyWith<PayoutModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayoutModelCopyWith<$Res> {
  factory $PayoutModelCopyWith(
          PayoutModel value, $Res Function(PayoutModel) then) =
      _$PayoutModelCopyWithImpl<$Res, PayoutModel>;
  @useResult
  $Res call(
      {String id,
      String sellerId,
      int amount,
      String currency,
      String status,
      String? stripePayoutId,
      String? bankAccountId,
      String? failureReason,
      List<String>? transactionIds,
      DateTime? estimatedArrival,
      DateTime createdAt,
      DateTime? paidAt,
      DateTime? failedAt});
}

/// @nodoc
class _$PayoutModelCopyWithImpl<$Res, $Val extends PayoutModel>
    implements $PayoutModelCopyWith<$Res> {
  _$PayoutModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PayoutModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sellerId = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? stripePayoutId = freezed,
    Object? bankAccountId = freezed,
    Object? failureReason = freezed,
    Object? transactionIds = freezed,
    Object? estimatedArrival = freezed,
    Object? createdAt = null,
    Object? paidAt = freezed,
    Object? failedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sellerId: null == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      stripePayoutId: freezed == stripePayoutId
          ? _value.stripePayoutId
          : stripePayoutId // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAccountId: freezed == bankAccountId
          ? _value.bankAccountId
          : bankAccountId // ignore: cast_nullable_to_non_nullable
              as String?,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionIds: freezed == transactionIds
          ? _value.transactionIds
          : transactionIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      estimatedArrival: freezed == estimatedArrival
          ? _value.estimatedArrival
          : estimatedArrival // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      failedAt: freezed == failedAt
          ? _value.failedAt
          : failedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PayoutModelImplCopyWith<$Res>
    implements $PayoutModelCopyWith<$Res> {
  factory _$$PayoutModelImplCopyWith(
          _$PayoutModelImpl value, $Res Function(_$PayoutModelImpl) then) =
      __$$PayoutModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sellerId,
      int amount,
      String currency,
      String status,
      String? stripePayoutId,
      String? bankAccountId,
      String? failureReason,
      List<String>? transactionIds,
      DateTime? estimatedArrival,
      DateTime createdAt,
      DateTime? paidAt,
      DateTime? failedAt});
}

/// @nodoc
class __$$PayoutModelImplCopyWithImpl<$Res>
    extends _$PayoutModelCopyWithImpl<$Res, _$PayoutModelImpl>
    implements _$$PayoutModelImplCopyWith<$Res> {
  __$$PayoutModelImplCopyWithImpl(
      _$PayoutModelImpl _value, $Res Function(_$PayoutModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PayoutModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sellerId = null,
    Object? amount = null,
    Object? currency = null,
    Object? status = null,
    Object? stripePayoutId = freezed,
    Object? bankAccountId = freezed,
    Object? failureReason = freezed,
    Object? transactionIds = freezed,
    Object? estimatedArrival = freezed,
    Object? createdAt = null,
    Object? paidAt = freezed,
    Object? failedAt = freezed,
  }) {
    return _then(_$PayoutModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sellerId: null == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      currency: null == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      stripePayoutId: freezed == stripePayoutId
          ? _value.stripePayoutId
          : stripePayoutId // ignore: cast_nullable_to_non_nullable
              as String?,
      bankAccountId: freezed == bankAccountId
          ? _value.bankAccountId
          : bankAccountId // ignore: cast_nullable_to_non_nullable
              as String?,
      failureReason: freezed == failureReason
          ? _value.failureReason
          : failureReason // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionIds: freezed == transactionIds
          ? _value._transactionIds
          : transactionIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      estimatedArrival: freezed == estimatedArrival
          ? _value.estimatedArrival
          : estimatedArrival // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      paidAt: freezed == paidAt
          ? _value.paidAt
          : paidAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      failedAt: freezed == failedAt
          ? _value.failedAt
          : failedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PayoutModelImpl implements _PayoutModel {
  const _$PayoutModelImpl(
      {required this.id,
      required this.sellerId,
      required this.amount,
      required this.currency,
      required this.status,
      this.stripePayoutId,
      this.bankAccountId,
      this.failureReason,
      final List<String>? transactionIds,
      this.estimatedArrival,
      required this.createdAt,
      this.paidAt,
      this.failedAt})
      : _transactionIds = transactionIds;

  factory _$PayoutModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PayoutModelImplFromJson(json);

  @override
  final String id;
  @override
  final String sellerId;
  @override
  final int amount;
// in cents
  @override
  final String currency;
  @override
  final String status;
// pending, processing, paid, failed
  @override
  final String? stripePayoutId;
  @override
  final String? bankAccountId;
  @override
  final String? failureReason;
  final List<String>? _transactionIds;
  @override
  List<String>? get transactionIds {
    final value = _transactionIds;
    if (value == null) return null;
    if (_transactionIds is EqualUnmodifiableListView) return _transactionIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

// list of transaction IDs included
  @override
  final DateTime? estimatedArrival;
  @override
  final DateTime createdAt;
  @override
  final DateTime? paidAt;
  @override
  final DateTime? failedAt;

  @override
  String toString() {
    return 'PayoutModel(id: $id, sellerId: $sellerId, amount: $amount, currency: $currency, status: $status, stripePayoutId: $stripePayoutId, bankAccountId: $bankAccountId, failureReason: $failureReason, transactionIds: $transactionIds, estimatedArrival: $estimatedArrival, createdAt: $createdAt, paidAt: $paidAt, failedAt: $failedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PayoutModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.stripePayoutId, stripePayoutId) ||
                other.stripePayoutId == stripePayoutId) &&
            (identical(other.bankAccountId, bankAccountId) ||
                other.bankAccountId == bankAccountId) &&
            (identical(other.failureReason, failureReason) ||
                other.failureReason == failureReason) &&
            const DeepCollectionEquality()
                .equals(other._transactionIds, _transactionIds) &&
            (identical(other.estimatedArrival, estimatedArrival) ||
                other.estimatedArrival == estimatedArrival) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.paidAt, paidAt) || other.paidAt == paidAt) &&
            (identical(other.failedAt, failedAt) ||
                other.failedAt == failedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      sellerId,
      amount,
      currency,
      status,
      stripePayoutId,
      bankAccountId,
      failureReason,
      const DeepCollectionEquality().hash(_transactionIds),
      estimatedArrival,
      createdAt,
      paidAt,
      failedAt);

  /// Create a copy of PayoutModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PayoutModelImplCopyWith<_$PayoutModelImpl> get copyWith =>
      __$$PayoutModelImplCopyWithImpl<_$PayoutModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PayoutModelImplToJson(
      this,
    );
  }
}

abstract class _PayoutModel implements PayoutModel {
  const factory _PayoutModel(
      {required final String id,
      required final String sellerId,
      required final int amount,
      required final String currency,
      required final String status,
      final String? stripePayoutId,
      final String? bankAccountId,
      final String? failureReason,
      final List<String>? transactionIds,
      final DateTime? estimatedArrival,
      required final DateTime createdAt,
      final DateTime? paidAt,
      final DateTime? failedAt}) = _$PayoutModelImpl;

  factory _PayoutModel.fromJson(Map<String, dynamic> json) =
      _$PayoutModelImpl.fromJson;

  @override
  String get id;
  @override
  String get sellerId;
  @override
  int get amount; // in cents
  @override
  String get currency;
  @override
  String get status; // pending, processing, paid, failed
  @override
  String? get stripePayoutId;
  @override
  String? get bankAccountId;
  @override
  String? get failureReason;
  @override
  List<String>? get transactionIds; // list of transaction IDs included
  @override
  DateTime? get estimatedArrival;
  @override
  DateTime get createdAt;
  @override
  DateTime? get paidAt;
  @override
  DateTime? get failedAt;

  /// Create a copy of PayoutModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PayoutModelImplCopyWith<_$PayoutModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
