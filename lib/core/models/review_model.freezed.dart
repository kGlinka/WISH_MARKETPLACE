// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReviewModel _$ReviewModelFromJson(Map<String, dynamic> json) {
  return _ReviewModel.fromJson(json);
}

/// @nodoc
mixin _$ReviewModel {
  String get id => throw _privateConstructorUsedError;
  String get reviewerId => throw _privateConstructorUsedError;
  String get revieweeId => throw _privateConstructorUsedError;
  String get listingId => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  ReviewType get type => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError; // 1-5 stars
  String? get title => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  List<String>? get imageUrls => throw _privateConstructorUsedError;
  int get helpfulCount => throw _privateConstructorUsedError;
  bool get isVerifiedPurchase => throw _privateConstructorUsedError;
  String? get sellerResponse => throw _privateConstructorUsedError;
  DateTime? get sellerResponseAt => throw _privateConstructorUsedError;
  bool get isReported => throw _privateConstructorUsedError;
  int get reportCount => throw _privateConstructorUsedError;
  bool get isHidden => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ReviewModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewModelCopyWith<ReviewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewModelCopyWith<$Res> {
  factory $ReviewModelCopyWith(
          ReviewModel value, $Res Function(ReviewModel) then) =
      _$ReviewModelCopyWithImpl<$Res, ReviewModel>;
  @useResult
  $Res call(
      {String id,
      String reviewerId,
      String revieweeId,
      String listingId,
      String? transactionId,
      ReviewType type,
      double rating,
      String? title,
      String? comment,
      List<String>? imageUrls,
      int helpfulCount,
      bool isVerifiedPurchase,
      String? sellerResponse,
      DateTime? sellerResponseAt,
      bool isReported,
      int reportCount,
      bool isHidden,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$ReviewModelCopyWithImpl<$Res, $Val extends ReviewModel>
    implements $ReviewModelCopyWith<$Res> {
  _$ReviewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reviewerId = null,
    Object? revieweeId = null,
    Object? listingId = null,
    Object? transactionId = freezed,
    Object? type = null,
    Object? rating = null,
    Object? title = freezed,
    Object? comment = freezed,
    Object? imageUrls = freezed,
    Object? helpfulCount = null,
    Object? isVerifiedPurchase = null,
    Object? sellerResponse = freezed,
    Object? sellerResponseAt = freezed,
    Object? isReported = null,
    Object? reportCount = null,
    Object? isHidden = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      reviewerId: null == reviewerId
          ? _value.reviewerId
          : reviewerId // ignore: cast_nullable_to_non_nullable
              as String,
      revieweeId: null == revieweeId
          ? _value.revieweeId
          : revieweeId // ignore: cast_nullable_to_non_nullable
              as String,
      listingId: null == listingId
          ? _value.listingId
          : listingId // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ReviewType,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrls: freezed == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      helpfulCount: null == helpfulCount
          ? _value.helpfulCount
          : helpfulCount // ignore: cast_nullable_to_non_nullable
              as int,
      isVerifiedPurchase: null == isVerifiedPurchase
          ? _value.isVerifiedPurchase
          : isVerifiedPurchase // ignore: cast_nullable_to_non_nullable
              as bool,
      sellerResponse: freezed == sellerResponse
          ? _value.sellerResponse
          : sellerResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerResponseAt: freezed == sellerResponseAt
          ? _value.sellerResponseAt
          : sellerResponseAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isReported: null == isReported
          ? _value.isReported
          : isReported // ignore: cast_nullable_to_non_nullable
              as bool,
      reportCount: null == reportCount
          ? _value.reportCount
          : reportCount // ignore: cast_nullable_to_non_nullable
              as int,
      isHidden: null == isHidden
          ? _value.isHidden
          : isHidden // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$ReviewModelImplCopyWith<$Res>
    implements $ReviewModelCopyWith<$Res> {
  factory _$$ReviewModelImplCopyWith(
          _$ReviewModelImpl value, $Res Function(_$ReviewModelImpl) then) =
      __$$ReviewModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String reviewerId,
      String revieweeId,
      String listingId,
      String? transactionId,
      ReviewType type,
      double rating,
      String? title,
      String? comment,
      List<String>? imageUrls,
      int helpfulCount,
      bool isVerifiedPurchase,
      String? sellerResponse,
      DateTime? sellerResponseAt,
      bool isReported,
      int reportCount,
      bool isHidden,
      DateTime createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$ReviewModelImplCopyWithImpl<$Res>
    extends _$ReviewModelCopyWithImpl<$Res, _$ReviewModelImpl>
    implements _$$ReviewModelImplCopyWith<$Res> {
  __$$ReviewModelImplCopyWithImpl(
      _$ReviewModelImpl _value, $Res Function(_$ReviewModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? reviewerId = null,
    Object? revieweeId = null,
    Object? listingId = null,
    Object? transactionId = freezed,
    Object? type = null,
    Object? rating = null,
    Object? title = freezed,
    Object? comment = freezed,
    Object? imageUrls = freezed,
    Object? helpfulCount = null,
    Object? isVerifiedPurchase = null,
    Object? sellerResponse = freezed,
    Object? sellerResponseAt = freezed,
    Object? isReported = null,
    Object? reportCount = null,
    Object? isHidden = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ReviewModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      reviewerId: null == reviewerId
          ? _value.reviewerId
          : reviewerId // ignore: cast_nullable_to_non_nullable
              as String,
      revieweeId: null == revieweeId
          ? _value.revieweeId
          : revieweeId // ignore: cast_nullable_to_non_nullable
              as String,
      listingId: null == listingId
          ? _value.listingId
          : listingId // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ReviewType,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrls: freezed == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      helpfulCount: null == helpfulCount
          ? _value.helpfulCount
          : helpfulCount // ignore: cast_nullable_to_non_nullable
              as int,
      isVerifiedPurchase: null == isVerifiedPurchase
          ? _value.isVerifiedPurchase
          : isVerifiedPurchase // ignore: cast_nullable_to_non_nullable
              as bool,
      sellerResponse: freezed == sellerResponse
          ? _value.sellerResponse
          : sellerResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      sellerResponseAt: freezed == sellerResponseAt
          ? _value.sellerResponseAt
          : sellerResponseAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isReported: null == isReported
          ? _value.isReported
          : isReported // ignore: cast_nullable_to_non_nullable
              as bool,
      reportCount: null == reportCount
          ? _value.reportCount
          : reportCount // ignore: cast_nullable_to_non_nullable
              as int,
      isHidden: null == isHidden
          ? _value.isHidden
          : isHidden // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$ReviewModelImpl implements _ReviewModel {
  const _$ReviewModelImpl(
      {required this.id,
      required this.reviewerId,
      required this.revieweeId,
      required this.listingId,
      this.transactionId,
      required this.type,
      required this.rating,
      this.title,
      this.comment,
      final List<String>? imageUrls,
      this.helpfulCount = 0,
      this.isVerifiedPurchase = false,
      this.sellerResponse,
      this.sellerResponseAt,
      this.isReported = false,
      this.reportCount = 0,
      this.isHidden = false,
      required this.createdAt,
      this.updatedAt})
      : _imageUrls = imageUrls;

  factory _$ReviewModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewModelImplFromJson(json);

  @override
  final String id;
  @override
  final String reviewerId;
  @override
  final String revieweeId;
  @override
  final String listingId;
  @override
  final String? transactionId;
  @override
  final ReviewType type;
  @override
  final double rating;
// 1-5 stars
  @override
  final String? title;
  @override
  final String? comment;
  final List<String>? _imageUrls;
  @override
  List<String>? get imageUrls {
    final value = _imageUrls;
    if (value == null) return null;
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey()
  final int helpfulCount;
  @override
  @JsonKey()
  final bool isVerifiedPurchase;
  @override
  final String? sellerResponse;
  @override
  final DateTime? sellerResponseAt;
  @override
  @JsonKey()
  final bool isReported;
  @override
  @JsonKey()
  final int reportCount;
  @override
  @JsonKey()
  final bool isHidden;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ReviewModel(id: $id, reviewerId: $reviewerId, revieweeId: $revieweeId, listingId: $listingId, transactionId: $transactionId, type: $type, rating: $rating, title: $title, comment: $comment, imageUrls: $imageUrls, helpfulCount: $helpfulCount, isVerifiedPurchase: $isVerifiedPurchase, sellerResponse: $sellerResponse, sellerResponseAt: $sellerResponseAt, isReported: $isReported, reportCount: $reportCount, isHidden: $isHidden, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.reviewerId, reviewerId) ||
                other.reviewerId == reviewerId) &&
            (identical(other.revieweeId, revieweeId) ||
                other.revieweeId == revieweeId) &&
            (identical(other.listingId, listingId) ||
                other.listingId == listingId) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            (identical(other.helpfulCount, helpfulCount) ||
                other.helpfulCount == helpfulCount) &&
            (identical(other.isVerifiedPurchase, isVerifiedPurchase) ||
                other.isVerifiedPurchase == isVerifiedPurchase) &&
            (identical(other.sellerResponse, sellerResponse) ||
                other.sellerResponse == sellerResponse) &&
            (identical(other.sellerResponseAt, sellerResponseAt) ||
                other.sellerResponseAt == sellerResponseAt) &&
            (identical(other.isReported, isReported) ||
                other.isReported == isReported) &&
            (identical(other.reportCount, reportCount) ||
                other.reportCount == reportCount) &&
            (identical(other.isHidden, isHidden) ||
                other.isHidden == isHidden) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        reviewerId,
        revieweeId,
        listingId,
        transactionId,
        type,
        rating,
        title,
        comment,
        const DeepCollectionEquality().hash(_imageUrls),
        helpfulCount,
        isVerifiedPurchase,
        sellerResponse,
        sellerResponseAt,
        isReported,
        reportCount,
        isHidden,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewModelImplCopyWith<_$ReviewModelImpl> get copyWith =>
      __$$ReviewModelImplCopyWithImpl<_$ReviewModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewModelImplToJson(
      this,
    );
  }
}

abstract class _ReviewModel implements ReviewModel {
  const factory _ReviewModel(
      {required final String id,
      required final String reviewerId,
      required final String revieweeId,
      required final String listingId,
      final String? transactionId,
      required final ReviewType type,
      required final double rating,
      final String? title,
      final String? comment,
      final List<String>? imageUrls,
      final int helpfulCount,
      final bool isVerifiedPurchase,
      final String? sellerResponse,
      final DateTime? sellerResponseAt,
      final bool isReported,
      final int reportCount,
      final bool isHidden,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$ReviewModelImpl;

  factory _ReviewModel.fromJson(Map<String, dynamic> json) =
      _$ReviewModelImpl.fromJson;

  @override
  String get id;
  @override
  String get reviewerId;
  @override
  String get revieweeId;
  @override
  String get listingId;
  @override
  String? get transactionId;
  @override
  ReviewType get type;
  @override
  double get rating; // 1-5 stars
  @override
  String? get title;
  @override
  String? get comment;
  @override
  List<String>? get imageUrls;
  @override
  int get helpfulCount;
  @override
  bool get isVerifiedPurchase;
  @override
  String? get sellerResponse;
  @override
  DateTime? get sellerResponseAt;
  @override
  bool get isReported;
  @override
  int get reportCount;
  @override
  bool get isHidden;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ReviewModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewModelImplCopyWith<_$ReviewModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
