// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listing_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ListingModel _$ListingModelFromJson(Map<String, dynamic> json) {
  return _ListingModel.fromJson(json);
}

/// @nodoc
mixin _$ListingModel {
  String get id => throw _privateConstructorUsedError;
  String get sellerId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  int get startingPrice => throw _privateConstructorUsedError; // in cents
  int? get currentBid => throw _privateConstructorUsedError; // in cents
  int? get buyNowPrice => throw _privateConstructorUsedError; // in cents
  List<String> get imageUrls => throw _privateConstructorUsedError;
  String? get videoUrl => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  ListingStatus get status => throw _privateConstructorUsedError;
  ListingCondition get condition => throw _privateConstructorUsedError;
  ListingSpecs? get specs => throw _privateConstructorUsedError;
  ListingLocation? get location => throw _privateConstructorUsedError;
  ListingStats? get stats => throw _privateConstructorUsedError;
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  DateTime? get soldAt => throw _privateConstructorUsedError;
  String? get winnerId => throw _privateConstructorUsedError;
  bool get isFeatured => throw _privateConstructorUsedError;
  bool get isPromoted => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  int get favoriteCount => throw _privateConstructorUsedError;
  int get bidCount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this ListingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListingModelCopyWith<ListingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListingModelCopyWith<$Res> {
  factory $ListingModelCopyWith(
          ListingModel value, $Res Function(ListingModel) then) =
      _$ListingModelCopyWithImpl<$Res, ListingModel>;
  @useResult
  $Res call(
      {String id,
      String sellerId,
      String title,
      String description,
      int startingPrice,
      int? currentBid,
      int? buyNowPrice,
      List<String> imageUrls,
      String? videoUrl,
      String category,
      List<String> tags,
      ListingStatus status,
      ListingCondition condition,
      ListingSpecs? specs,
      ListingLocation? location,
      ListingStats? stats,
      DateTime startTime,
      DateTime endTime,
      DateTime? soldAt,
      String? winnerId,
      bool isFeatured,
      bool isPromoted,
      int viewCount,
      int favoriteCount,
      int bidCount,
      DateTime createdAt,
      DateTime? updatedAt});

  $ListingSpecsCopyWith<$Res>? get specs;
  $ListingLocationCopyWith<$Res>? get location;
  $ListingStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class _$ListingModelCopyWithImpl<$Res, $Val extends ListingModel>
    implements $ListingModelCopyWith<$Res> {
  _$ListingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sellerId = null,
    Object? title = null,
    Object? description = null,
    Object? startingPrice = null,
    Object? currentBid = freezed,
    Object? buyNowPrice = freezed,
    Object? imageUrls = null,
    Object? videoUrl = freezed,
    Object? category = null,
    Object? tags = null,
    Object? status = null,
    Object? condition = null,
    Object? specs = freezed,
    Object? location = freezed,
    Object? stats = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? soldAt = freezed,
    Object? winnerId = freezed,
    Object? isFeatured = null,
    Object? isPromoted = null,
    Object? viewCount = null,
    Object? favoriteCount = null,
    Object? bidCount = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startingPrice: null == startingPrice
          ? _value.startingPrice
          : startingPrice // ignore: cast_nullable_to_non_nullable
              as int,
      currentBid: freezed == currentBid
          ? _value.currentBid
          : currentBid // ignore: cast_nullable_to_non_nullable
              as int?,
      buyNowPrice: freezed == buyNowPrice
          ? _value.buyNowPrice
          : buyNowPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ListingStatus,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as ListingCondition,
      specs: freezed == specs
          ? _value.specs
          : specs // ignore: cast_nullable_to_non_nullable
              as ListingSpecs?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as ListingLocation?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as ListingStats?,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      soldAt: freezed == soldAt
          ? _value.soldAt
          : soldAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      winnerId: freezed == winnerId
          ? _value.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      isFeatured: null == isFeatured
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
      isPromoted: null == isPromoted
          ? _value.isPromoted
          : isPromoted // ignore: cast_nullable_to_non_nullable
              as bool,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      favoriteCount: null == favoriteCount
          ? _value.favoriteCount
          : favoriteCount // ignore: cast_nullable_to_non_nullable
              as int,
      bidCount: null == bidCount
          ? _value.bidCount
          : bidCount // ignore: cast_nullable_to_non_nullable
              as int,
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

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ListingSpecsCopyWith<$Res>? get specs {
    if (_value.specs == null) {
      return null;
    }

    return $ListingSpecsCopyWith<$Res>(_value.specs!, (value) {
      return _then(_value.copyWith(specs: value) as $Val);
    });
  }

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ListingLocationCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $ListingLocationCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ListingStatsCopyWith<$Res>? get stats {
    if (_value.stats == null) {
      return null;
    }

    return $ListingStatsCopyWith<$Res>(_value.stats!, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ListingModelImplCopyWith<$Res>
    implements $ListingModelCopyWith<$Res> {
  factory _$$ListingModelImplCopyWith(
          _$ListingModelImpl value, $Res Function(_$ListingModelImpl) then) =
      __$$ListingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String sellerId,
      String title,
      String description,
      int startingPrice,
      int? currentBid,
      int? buyNowPrice,
      List<String> imageUrls,
      String? videoUrl,
      String category,
      List<String> tags,
      ListingStatus status,
      ListingCondition condition,
      ListingSpecs? specs,
      ListingLocation? location,
      ListingStats? stats,
      DateTime startTime,
      DateTime endTime,
      DateTime? soldAt,
      String? winnerId,
      bool isFeatured,
      bool isPromoted,
      int viewCount,
      int favoriteCount,
      int bidCount,
      DateTime createdAt,
      DateTime? updatedAt});

  @override
  $ListingSpecsCopyWith<$Res>? get specs;
  @override
  $ListingLocationCopyWith<$Res>? get location;
  @override
  $ListingStatsCopyWith<$Res>? get stats;
}

/// @nodoc
class __$$ListingModelImplCopyWithImpl<$Res>
    extends _$ListingModelCopyWithImpl<$Res, _$ListingModelImpl>
    implements _$$ListingModelImplCopyWith<$Res> {
  __$$ListingModelImplCopyWithImpl(
      _$ListingModelImpl _value, $Res Function(_$ListingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sellerId = null,
    Object? title = null,
    Object? description = null,
    Object? startingPrice = null,
    Object? currentBid = freezed,
    Object? buyNowPrice = freezed,
    Object? imageUrls = null,
    Object? videoUrl = freezed,
    Object? category = null,
    Object? tags = null,
    Object? status = null,
    Object? condition = null,
    Object? specs = freezed,
    Object? location = freezed,
    Object? stats = freezed,
    Object? startTime = null,
    Object? endTime = null,
    Object? soldAt = freezed,
    Object? winnerId = freezed,
    Object? isFeatured = null,
    Object? isPromoted = null,
    Object? viewCount = null,
    Object? favoriteCount = null,
    Object? bidCount = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
  }) {
    return _then(_$ListingModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sellerId: null == sellerId
          ? _value.sellerId
          : sellerId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      startingPrice: null == startingPrice
          ? _value.startingPrice
          : startingPrice // ignore: cast_nullable_to_non_nullable
              as int,
      currentBid: freezed == currentBid
          ? _value.currentBid
          : currentBid // ignore: cast_nullable_to_non_nullable
              as int?,
      buyNowPrice: freezed == buyNowPrice
          ? _value.buyNowPrice
          : buyNowPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      videoUrl: freezed == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ListingStatus,
      condition: null == condition
          ? _value.condition
          : condition // ignore: cast_nullable_to_non_nullable
              as ListingCondition,
      specs: freezed == specs
          ? _value.specs
          : specs // ignore: cast_nullable_to_non_nullable
              as ListingSpecs?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as ListingLocation?,
      stats: freezed == stats
          ? _value.stats
          : stats // ignore: cast_nullable_to_non_nullable
              as ListingStats?,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      soldAt: freezed == soldAt
          ? _value.soldAt
          : soldAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      winnerId: freezed == winnerId
          ? _value.winnerId
          : winnerId // ignore: cast_nullable_to_non_nullable
              as String?,
      isFeatured: null == isFeatured
          ? _value.isFeatured
          : isFeatured // ignore: cast_nullable_to_non_nullable
              as bool,
      isPromoted: null == isPromoted
          ? _value.isPromoted
          : isPromoted // ignore: cast_nullable_to_non_nullable
              as bool,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      favoriteCount: null == favoriteCount
          ? _value.favoriteCount
          : favoriteCount // ignore: cast_nullable_to_non_nullable
              as int,
      bidCount: null == bidCount
          ? _value.bidCount
          : bidCount // ignore: cast_nullable_to_non_nullable
              as int,
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
class _$ListingModelImpl implements _ListingModel {
  const _$ListingModelImpl(
      {required this.id,
      required this.sellerId,
      required this.title,
      required this.description,
      required this.startingPrice,
      this.currentBid,
      this.buyNowPrice,
      required final List<String> imageUrls,
      this.videoUrl,
      required this.category,
      final List<String> tags = const [],
      required this.status,
      required this.condition,
      this.specs,
      this.location,
      this.stats,
      required this.startTime,
      required this.endTime,
      this.soldAt,
      this.winnerId,
      this.isFeatured = false,
      this.isPromoted = false,
      this.viewCount = 0,
      this.favoriteCount = 0,
      this.bidCount = 0,
      required this.createdAt,
      this.updatedAt})
      : _imageUrls = imageUrls,
        _tags = tags;

  factory _$ListingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListingModelImplFromJson(json);

  @override
  final String id;
  @override
  final String sellerId;
  @override
  final String title;
  @override
  final String description;
  @override
  final int startingPrice;
// in cents
  @override
  final int? currentBid;
// in cents
  @override
  final int? buyNowPrice;
// in cents
  final List<String> _imageUrls;
// in cents
  @override
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  final String? videoUrl;
  @override
  final String category;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final ListingStatus status;
  @override
  final ListingCondition condition;
  @override
  final ListingSpecs? specs;
  @override
  final ListingLocation? location;
  @override
  final ListingStats? stats;
  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final DateTime? soldAt;
  @override
  final String? winnerId;
  @override
  @JsonKey()
  final bool isFeatured;
  @override
  @JsonKey()
  final bool isPromoted;
  @override
  @JsonKey()
  final int viewCount;
  @override
  @JsonKey()
  final int favoriteCount;
  @override
  @JsonKey()
  final int bidCount;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'ListingModel(id: $id, sellerId: $sellerId, title: $title, description: $description, startingPrice: $startingPrice, currentBid: $currentBid, buyNowPrice: $buyNowPrice, imageUrls: $imageUrls, videoUrl: $videoUrl, category: $category, tags: $tags, status: $status, condition: $condition, specs: $specs, location: $location, stats: $stats, startTime: $startTime, endTime: $endTime, soldAt: $soldAt, winnerId: $winnerId, isFeatured: $isFeatured, isPromoted: $isPromoted, viewCount: $viewCount, favoriteCount: $favoriteCount, bidCount: $bidCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListingModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sellerId, sellerId) ||
                other.sellerId == sellerId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.startingPrice, startingPrice) ||
                other.startingPrice == startingPrice) &&
            (identical(other.currentBid, currentBid) ||
                other.currentBid == currentBid) &&
            (identical(other.buyNowPrice, buyNowPrice) ||
                other.buyNowPrice == buyNowPrice) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.condition, condition) ||
                other.condition == condition) &&
            (identical(other.specs, specs) || other.specs == specs) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.stats, stats) || other.stats == stats) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.soldAt, soldAt) || other.soldAt == soldAt) &&
            (identical(other.winnerId, winnerId) ||
                other.winnerId == winnerId) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.isPromoted, isPromoted) ||
                other.isPromoted == isPromoted) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.favoriteCount, favoriteCount) ||
                other.favoriteCount == favoriteCount) &&
            (identical(other.bidCount, bidCount) ||
                other.bidCount == bidCount) &&
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
        sellerId,
        title,
        description,
        startingPrice,
        currentBid,
        buyNowPrice,
        const DeepCollectionEquality().hash(_imageUrls),
        videoUrl,
        category,
        const DeepCollectionEquality().hash(_tags),
        status,
        condition,
        specs,
        location,
        stats,
        startTime,
        endTime,
        soldAt,
        winnerId,
        isFeatured,
        isPromoted,
        viewCount,
        favoriteCount,
        bidCount,
        createdAt,
        updatedAt
      ]);

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListingModelImplCopyWith<_$ListingModelImpl> get copyWith =>
      __$$ListingModelImplCopyWithImpl<_$ListingModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListingModelImplToJson(
      this,
    );
  }
}

abstract class _ListingModel implements ListingModel {
  const factory _ListingModel(
      {required final String id,
      required final String sellerId,
      required final String title,
      required final String description,
      required final int startingPrice,
      final int? currentBid,
      final int? buyNowPrice,
      required final List<String> imageUrls,
      final String? videoUrl,
      required final String category,
      final List<String> tags,
      required final ListingStatus status,
      required final ListingCondition condition,
      final ListingSpecs? specs,
      final ListingLocation? location,
      final ListingStats? stats,
      required final DateTime startTime,
      required final DateTime endTime,
      final DateTime? soldAt,
      final String? winnerId,
      final bool isFeatured,
      final bool isPromoted,
      final int viewCount,
      final int favoriteCount,
      final int bidCount,
      required final DateTime createdAt,
      final DateTime? updatedAt}) = _$ListingModelImpl;

  factory _ListingModel.fromJson(Map<String, dynamic> json) =
      _$ListingModelImpl.fromJson;

  @override
  String get id;
  @override
  String get sellerId;
  @override
  String get title;
  @override
  String get description;
  @override
  int get startingPrice; // in cents
  @override
  int? get currentBid; // in cents
  @override
  int? get buyNowPrice; // in cents
  @override
  List<String> get imageUrls;
  @override
  String? get videoUrl;
  @override
  String get category;
  @override
  List<String> get tags;
  @override
  ListingStatus get status;
  @override
  ListingCondition get condition;
  @override
  ListingSpecs? get specs;
  @override
  ListingLocation? get location;
  @override
  ListingStats? get stats;
  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  DateTime? get soldAt;
  @override
  String? get winnerId;
  @override
  bool get isFeatured;
  @override
  bool get isPromoted;
  @override
  int get viewCount;
  @override
  int get favoriteCount;
  @override
  int get bidCount;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of ListingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingModelImplCopyWith<_$ListingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ListingSpecs _$ListingSpecsFromJson(Map<String, dynamic> json) {
  return _ListingSpecs.fromJson(json);
}

/// @nodoc
mixin _$ListingSpecs {
  String? get brand => throw _privateConstructorUsedError;
  String? get model => throw _privateConstructorUsedError;
  String? get color => throw _privateConstructorUsedError;
  String? get size => throw _privateConstructorUsedError;
  String? get material => throw _privateConstructorUsedError;
  String? get connectivity =>
      throw _privateConstructorUsedError; // e.g., Bluetooth, WiFi, LTE
  String? get compatibility =>
      throw _privateConstructorUsedError; // e.g., iOS, Android, Both
  String? get batteryLife => throw _privateConstructorUsedError;
  String? get displaySize => throw _privateConstructorUsedError;
  String? get displayType => throw _privateConstructorUsedError;
  String? get waterResistance => throw _privateConstructorUsedError;
  String? get sensors => throw _privateConstructorUsedError;
  String? get storage => throw _privateConstructorUsedError;
  String? get ram => throw _privateConstructorUsedError;
  String? get processor => throw _privateConstructorUsedError;
  String? get operatingSystem => throw _privateConstructorUsedError;
  String? get releaseYear => throw _privateConstructorUsedError;
  Map<String, dynamic>? get additionalSpecs =>
      throw _privateConstructorUsedError;

  /// Serializes this ListingSpecs to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListingSpecs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListingSpecsCopyWith<ListingSpecs> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListingSpecsCopyWith<$Res> {
  factory $ListingSpecsCopyWith(
          ListingSpecs value, $Res Function(ListingSpecs) then) =
      _$ListingSpecsCopyWithImpl<$Res, ListingSpecs>;
  @useResult
  $Res call(
      {String? brand,
      String? model,
      String? color,
      String? size,
      String? material,
      String? connectivity,
      String? compatibility,
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
      Map<String, dynamic>? additionalSpecs});
}

/// @nodoc
class _$ListingSpecsCopyWithImpl<$Res, $Val extends ListingSpecs>
    implements $ListingSpecsCopyWith<$Res> {
  _$ListingSpecsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListingSpecs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brand = freezed,
    Object? model = freezed,
    Object? color = freezed,
    Object? size = freezed,
    Object? material = freezed,
    Object? connectivity = freezed,
    Object? compatibility = freezed,
    Object? batteryLife = freezed,
    Object? displaySize = freezed,
    Object? displayType = freezed,
    Object? waterResistance = freezed,
    Object? sensors = freezed,
    Object? storage = freezed,
    Object? ram = freezed,
    Object? processor = freezed,
    Object? operatingSystem = freezed,
    Object? releaseYear = freezed,
    Object? additionalSpecs = freezed,
  }) {
    return _then(_value.copyWith(
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      material: freezed == material
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as String?,
      connectivity: freezed == connectivity
          ? _value.connectivity
          : connectivity // ignore: cast_nullable_to_non_nullable
              as String?,
      compatibility: freezed == compatibility
          ? _value.compatibility
          : compatibility // ignore: cast_nullable_to_non_nullable
              as String?,
      batteryLife: freezed == batteryLife
          ? _value.batteryLife
          : batteryLife // ignore: cast_nullable_to_non_nullable
              as String?,
      displaySize: freezed == displaySize
          ? _value.displaySize
          : displaySize // ignore: cast_nullable_to_non_nullable
              as String?,
      displayType: freezed == displayType
          ? _value.displayType
          : displayType // ignore: cast_nullable_to_non_nullable
              as String?,
      waterResistance: freezed == waterResistance
          ? _value.waterResistance
          : waterResistance // ignore: cast_nullable_to_non_nullable
              as String?,
      sensors: freezed == sensors
          ? _value.sensors
          : sensors // ignore: cast_nullable_to_non_nullable
              as String?,
      storage: freezed == storage
          ? _value.storage
          : storage // ignore: cast_nullable_to_non_nullable
              as String?,
      ram: freezed == ram
          ? _value.ram
          : ram // ignore: cast_nullable_to_non_nullable
              as String?,
      processor: freezed == processor
          ? _value.processor
          : processor // ignore: cast_nullable_to_non_nullable
              as String?,
      operatingSystem: freezed == operatingSystem
          ? _value.operatingSystem
          : operatingSystem // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseYear: freezed == releaseYear
          ? _value.releaseYear
          : releaseYear // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalSpecs: freezed == additionalSpecs
          ? _value.additionalSpecs
          : additionalSpecs // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListingSpecsImplCopyWith<$Res>
    implements $ListingSpecsCopyWith<$Res> {
  factory _$$ListingSpecsImplCopyWith(
          _$ListingSpecsImpl value, $Res Function(_$ListingSpecsImpl) then) =
      __$$ListingSpecsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? brand,
      String? model,
      String? color,
      String? size,
      String? material,
      String? connectivity,
      String? compatibility,
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
      Map<String, dynamic>? additionalSpecs});
}

/// @nodoc
class __$$ListingSpecsImplCopyWithImpl<$Res>
    extends _$ListingSpecsCopyWithImpl<$Res, _$ListingSpecsImpl>
    implements _$$ListingSpecsImplCopyWith<$Res> {
  __$$ListingSpecsImplCopyWithImpl(
      _$ListingSpecsImpl _value, $Res Function(_$ListingSpecsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ListingSpecs
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? brand = freezed,
    Object? model = freezed,
    Object? color = freezed,
    Object? size = freezed,
    Object? material = freezed,
    Object? connectivity = freezed,
    Object? compatibility = freezed,
    Object? batteryLife = freezed,
    Object? displaySize = freezed,
    Object? displayType = freezed,
    Object? waterResistance = freezed,
    Object? sensors = freezed,
    Object? storage = freezed,
    Object? ram = freezed,
    Object? processor = freezed,
    Object? operatingSystem = freezed,
    Object? releaseYear = freezed,
    Object? additionalSpecs = freezed,
  }) {
    return _then(_$ListingSpecsImpl(
      brand: freezed == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String?,
      model: freezed == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String?,
      material: freezed == material
          ? _value.material
          : material // ignore: cast_nullable_to_non_nullable
              as String?,
      connectivity: freezed == connectivity
          ? _value.connectivity
          : connectivity // ignore: cast_nullable_to_non_nullable
              as String?,
      compatibility: freezed == compatibility
          ? _value.compatibility
          : compatibility // ignore: cast_nullable_to_non_nullable
              as String?,
      batteryLife: freezed == batteryLife
          ? _value.batteryLife
          : batteryLife // ignore: cast_nullable_to_non_nullable
              as String?,
      displaySize: freezed == displaySize
          ? _value.displaySize
          : displaySize // ignore: cast_nullable_to_non_nullable
              as String?,
      displayType: freezed == displayType
          ? _value.displayType
          : displayType // ignore: cast_nullable_to_non_nullable
              as String?,
      waterResistance: freezed == waterResistance
          ? _value.waterResistance
          : waterResistance // ignore: cast_nullable_to_non_nullable
              as String?,
      sensors: freezed == sensors
          ? _value.sensors
          : sensors // ignore: cast_nullable_to_non_nullable
              as String?,
      storage: freezed == storage
          ? _value.storage
          : storage // ignore: cast_nullable_to_non_nullable
              as String?,
      ram: freezed == ram
          ? _value.ram
          : ram // ignore: cast_nullable_to_non_nullable
              as String?,
      processor: freezed == processor
          ? _value.processor
          : processor // ignore: cast_nullable_to_non_nullable
              as String?,
      operatingSystem: freezed == operatingSystem
          ? _value.operatingSystem
          : operatingSystem // ignore: cast_nullable_to_non_nullable
              as String?,
      releaseYear: freezed == releaseYear
          ? _value.releaseYear
          : releaseYear // ignore: cast_nullable_to_non_nullable
              as String?,
      additionalSpecs: freezed == additionalSpecs
          ? _value._additionalSpecs
          : additionalSpecs // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListingSpecsImpl implements _ListingSpecs {
  const _$ListingSpecsImpl(
      {this.brand,
      this.model,
      this.color,
      this.size,
      this.material,
      this.connectivity,
      this.compatibility,
      this.batteryLife,
      this.displaySize,
      this.displayType,
      this.waterResistance,
      this.sensors,
      this.storage,
      this.ram,
      this.processor,
      this.operatingSystem,
      this.releaseYear,
      final Map<String, dynamic>? additionalSpecs})
      : _additionalSpecs = additionalSpecs;

  factory _$ListingSpecsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListingSpecsImplFromJson(json);

  @override
  final String? brand;
  @override
  final String? model;
  @override
  final String? color;
  @override
  final String? size;
  @override
  final String? material;
  @override
  final String? connectivity;
// e.g., Bluetooth, WiFi, LTE
  @override
  final String? compatibility;
// e.g., iOS, Android, Both
  @override
  final String? batteryLife;
  @override
  final String? displaySize;
  @override
  final String? displayType;
  @override
  final String? waterResistance;
  @override
  final String? sensors;
  @override
  final String? storage;
  @override
  final String? ram;
  @override
  final String? processor;
  @override
  final String? operatingSystem;
  @override
  final String? releaseYear;
  final Map<String, dynamic>? _additionalSpecs;
  @override
  Map<String, dynamic>? get additionalSpecs {
    final value = _additionalSpecs;
    if (value == null) return null;
    if (_additionalSpecs is EqualUnmodifiableMapView) return _additionalSpecs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ListingSpecs(brand: $brand, model: $model, color: $color, size: $size, material: $material, connectivity: $connectivity, compatibility: $compatibility, batteryLife: $batteryLife, displaySize: $displaySize, displayType: $displayType, waterResistance: $waterResistance, sensors: $sensors, storage: $storage, ram: $ram, processor: $processor, operatingSystem: $operatingSystem, releaseYear: $releaseYear, additionalSpecs: $additionalSpecs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListingSpecsImpl &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.model, model) || other.model == model) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.material, material) ||
                other.material == material) &&
            (identical(other.connectivity, connectivity) ||
                other.connectivity == connectivity) &&
            (identical(other.compatibility, compatibility) ||
                other.compatibility == compatibility) &&
            (identical(other.batteryLife, batteryLife) ||
                other.batteryLife == batteryLife) &&
            (identical(other.displaySize, displaySize) ||
                other.displaySize == displaySize) &&
            (identical(other.displayType, displayType) ||
                other.displayType == displayType) &&
            (identical(other.waterResistance, waterResistance) ||
                other.waterResistance == waterResistance) &&
            (identical(other.sensors, sensors) || other.sensors == sensors) &&
            (identical(other.storage, storage) || other.storage == storage) &&
            (identical(other.ram, ram) || other.ram == ram) &&
            (identical(other.processor, processor) ||
                other.processor == processor) &&
            (identical(other.operatingSystem, operatingSystem) ||
                other.operatingSystem == operatingSystem) &&
            (identical(other.releaseYear, releaseYear) ||
                other.releaseYear == releaseYear) &&
            const DeepCollectionEquality()
                .equals(other._additionalSpecs, _additionalSpecs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      brand,
      model,
      color,
      size,
      material,
      connectivity,
      compatibility,
      batteryLife,
      displaySize,
      displayType,
      waterResistance,
      sensors,
      storage,
      ram,
      processor,
      operatingSystem,
      releaseYear,
      const DeepCollectionEquality().hash(_additionalSpecs));

  /// Create a copy of ListingSpecs
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListingSpecsImplCopyWith<_$ListingSpecsImpl> get copyWith =>
      __$$ListingSpecsImplCopyWithImpl<_$ListingSpecsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListingSpecsImplToJson(
      this,
    );
  }
}

abstract class _ListingSpecs implements ListingSpecs {
  const factory _ListingSpecs(
      {final String? brand,
      final String? model,
      final String? color,
      final String? size,
      final String? material,
      final String? connectivity,
      final String? compatibility,
      final String? batteryLife,
      final String? displaySize,
      final String? displayType,
      final String? waterResistance,
      final String? sensors,
      final String? storage,
      final String? ram,
      final String? processor,
      final String? operatingSystem,
      final String? releaseYear,
      final Map<String, dynamic>? additionalSpecs}) = _$ListingSpecsImpl;

  factory _ListingSpecs.fromJson(Map<String, dynamic> json) =
      _$ListingSpecsImpl.fromJson;

  @override
  String? get brand;
  @override
  String? get model;
  @override
  String? get color;
  @override
  String? get size;
  @override
  String? get material;
  @override
  String? get connectivity; // e.g., Bluetooth, WiFi, LTE
  @override
  String? get compatibility; // e.g., iOS, Android, Both
  @override
  String? get batteryLife;
  @override
  String? get displaySize;
  @override
  String? get displayType;
  @override
  String? get waterResistance;
  @override
  String? get sensors;
  @override
  String? get storage;
  @override
  String? get ram;
  @override
  String? get processor;
  @override
  String? get operatingSystem;
  @override
  String? get releaseYear;
  @override
  Map<String, dynamic>? get additionalSpecs;

  /// Create a copy of ListingSpecs
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingSpecsImplCopyWith<_$ListingSpecsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ListingLocation _$ListingLocationFromJson(Map<String, dynamic> json) {
  return _ListingLocation.fromJson(json);
}

/// @nodoc
mixin _$ListingLocation {
  String? get address => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get postalCode => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  bool get isLocalPickupAvailable => throw _privateConstructorUsedError;
  bool get isShippingAvailable => throw _privateConstructorUsedError;
  int? get shippingCost => throw _privateConstructorUsedError;

  /// Serializes this ListingLocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListingLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListingLocationCopyWith<ListingLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListingLocationCopyWith<$Res> {
  factory $ListingLocationCopyWith(
          ListingLocation value, $Res Function(ListingLocation) then) =
      _$ListingLocationCopyWithImpl<$Res, ListingLocation>;
  @useResult
  $Res call(
      {String? address,
      String? city,
      String? state,
      String? country,
      String? postalCode,
      double? latitude,
      double? longitude,
      bool isLocalPickupAvailable,
      bool isShippingAvailable,
      int? shippingCost});
}

/// @nodoc
class _$ListingLocationCopyWithImpl<$Res, $Val extends ListingLocation>
    implements $ListingLocationCopyWith<$Res> {
  _$ListingLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListingLocation
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
    Object? isLocalPickupAvailable = null,
    Object? isShippingAvailable = null,
    Object? shippingCost = freezed,
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
      isLocalPickupAvailable: null == isLocalPickupAvailable
          ? _value.isLocalPickupAvailable
          : isLocalPickupAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isShippingAvailable: null == isShippingAvailable
          ? _value.isShippingAvailable
          : isShippingAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      shippingCost: freezed == shippingCost
          ? _value.shippingCost
          : shippingCost // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListingLocationImplCopyWith<$Res>
    implements $ListingLocationCopyWith<$Res> {
  factory _$$ListingLocationImplCopyWith(_$ListingLocationImpl value,
          $Res Function(_$ListingLocationImpl) then) =
      __$$ListingLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? address,
      String? city,
      String? state,
      String? country,
      String? postalCode,
      double? latitude,
      double? longitude,
      bool isLocalPickupAvailable,
      bool isShippingAvailable,
      int? shippingCost});
}

/// @nodoc
class __$$ListingLocationImplCopyWithImpl<$Res>
    extends _$ListingLocationCopyWithImpl<$Res, _$ListingLocationImpl>
    implements _$$ListingLocationImplCopyWith<$Res> {
  __$$ListingLocationImplCopyWithImpl(
      _$ListingLocationImpl _value, $Res Function(_$ListingLocationImpl) _then)
      : super(_value, _then);

  /// Create a copy of ListingLocation
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
    Object? isLocalPickupAvailable = null,
    Object? isShippingAvailable = null,
    Object? shippingCost = freezed,
  }) {
    return _then(_$ListingLocationImpl(
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
      isLocalPickupAvailable: null == isLocalPickupAvailable
          ? _value.isLocalPickupAvailable
          : isLocalPickupAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      isShippingAvailable: null == isShippingAvailable
          ? _value.isShippingAvailable
          : isShippingAvailable // ignore: cast_nullable_to_non_nullable
              as bool,
      shippingCost: freezed == shippingCost
          ? _value.shippingCost
          : shippingCost // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListingLocationImpl implements _ListingLocation {
  const _$ListingLocationImpl(
      {this.address,
      this.city,
      this.state,
      this.country,
      this.postalCode,
      this.latitude,
      this.longitude,
      this.isLocalPickupAvailable = false,
      this.isShippingAvailable = true,
      this.shippingCost});

  factory _$ListingLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListingLocationImplFromJson(json);

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
  @JsonKey()
  final bool isLocalPickupAvailable;
  @override
  @JsonKey()
  final bool isShippingAvailable;
  @override
  final int? shippingCost;

  @override
  String toString() {
    return 'ListingLocation(address: $address, city: $city, state: $state, country: $country, postalCode: $postalCode, latitude: $latitude, longitude: $longitude, isLocalPickupAvailable: $isLocalPickupAvailable, isShippingAvailable: $isShippingAvailable, shippingCost: $shippingCost)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListingLocationImpl &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.state, state) || other.state == state) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.isLocalPickupAvailable, isLocalPickupAvailable) ||
                other.isLocalPickupAvailable == isLocalPickupAvailable) &&
            (identical(other.isShippingAvailable, isShippingAvailable) ||
                other.isShippingAvailable == isShippingAvailable) &&
            (identical(other.shippingCost, shippingCost) ||
                other.shippingCost == shippingCost));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      address,
      city,
      state,
      country,
      postalCode,
      latitude,
      longitude,
      isLocalPickupAvailable,
      isShippingAvailable,
      shippingCost);

  /// Create a copy of ListingLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListingLocationImplCopyWith<_$ListingLocationImpl> get copyWith =>
      __$$ListingLocationImplCopyWithImpl<_$ListingLocationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListingLocationImplToJson(
      this,
    );
  }
}

abstract class _ListingLocation implements ListingLocation {
  const factory _ListingLocation(
      {final String? address,
      final String? city,
      final String? state,
      final String? country,
      final String? postalCode,
      final double? latitude,
      final double? longitude,
      final bool isLocalPickupAvailable,
      final bool isShippingAvailable,
      final int? shippingCost}) = _$ListingLocationImpl;

  factory _ListingLocation.fromJson(Map<String, dynamic> json) =
      _$ListingLocationImpl.fromJson;

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
  @override
  bool get isLocalPickupAvailable;
  @override
  bool get isShippingAvailable;
  @override
  int? get shippingCost;

  /// Create a copy of ListingLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingLocationImplCopyWith<_$ListingLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ListingStats _$ListingStatsFromJson(Map<String, dynamic> json) {
  return _ListingStats.fromJson(json);
}

/// @nodoc
mixin _$ListingStats {
  int get impressions => throw _privateConstructorUsedError;
  int get clicks => throw _privateConstructorUsedError;
  int get shares => throw _privateConstructorUsedError;
  int get reports => throw _privateConstructorUsedError;
  double get conversionRate => throw _privateConstructorUsedError;

  /// Serializes this ListingStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ListingStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ListingStatsCopyWith<ListingStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListingStatsCopyWith<$Res> {
  factory $ListingStatsCopyWith(
          ListingStats value, $Res Function(ListingStats) then) =
      _$ListingStatsCopyWithImpl<$Res, ListingStats>;
  @useResult
  $Res call(
      {int impressions,
      int clicks,
      int shares,
      int reports,
      double conversionRate});
}

/// @nodoc
class _$ListingStatsCopyWithImpl<$Res, $Val extends ListingStats>
    implements $ListingStatsCopyWith<$Res> {
  _$ListingStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ListingStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? impressions = null,
    Object? clicks = null,
    Object? shares = null,
    Object? reports = null,
    Object? conversionRate = null,
  }) {
    return _then(_value.copyWith(
      impressions: null == impressions
          ? _value.impressions
          : impressions // ignore: cast_nullable_to_non_nullable
              as int,
      clicks: null == clicks
          ? _value.clicks
          : clicks // ignore: cast_nullable_to_non_nullable
              as int,
      shares: null == shares
          ? _value.shares
          : shares // ignore: cast_nullable_to_non_nullable
              as int,
      reports: null == reports
          ? _value.reports
          : reports // ignore: cast_nullable_to_non_nullable
              as int,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListingStatsImplCopyWith<$Res>
    implements $ListingStatsCopyWith<$Res> {
  factory _$$ListingStatsImplCopyWith(
          _$ListingStatsImpl value, $Res Function(_$ListingStatsImpl) then) =
      __$$ListingStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int impressions,
      int clicks,
      int shares,
      int reports,
      double conversionRate});
}

/// @nodoc
class __$$ListingStatsImplCopyWithImpl<$Res>
    extends _$ListingStatsCopyWithImpl<$Res, _$ListingStatsImpl>
    implements _$$ListingStatsImplCopyWith<$Res> {
  __$$ListingStatsImplCopyWithImpl(
      _$ListingStatsImpl _value, $Res Function(_$ListingStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ListingStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? impressions = null,
    Object? clicks = null,
    Object? shares = null,
    Object? reports = null,
    Object? conversionRate = null,
  }) {
    return _then(_$ListingStatsImpl(
      impressions: null == impressions
          ? _value.impressions
          : impressions // ignore: cast_nullable_to_non_nullable
              as int,
      clicks: null == clicks
          ? _value.clicks
          : clicks // ignore: cast_nullable_to_non_nullable
              as int,
      shares: null == shares
          ? _value.shares
          : shares // ignore: cast_nullable_to_non_nullable
              as int,
      reports: null == reports
          ? _value.reports
          : reports // ignore: cast_nullable_to_non_nullable
              as int,
      conversionRate: null == conversionRate
          ? _value.conversionRate
          : conversionRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListingStatsImpl implements _ListingStats {
  const _$ListingStatsImpl(
      {this.impressions = 0,
      this.clicks = 0,
      this.shares = 0,
      this.reports = 0,
      this.conversionRate = 0.0});

  factory _$ListingStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListingStatsImplFromJson(json);

  @override
  @JsonKey()
  final int impressions;
  @override
  @JsonKey()
  final int clicks;
  @override
  @JsonKey()
  final int shares;
  @override
  @JsonKey()
  final int reports;
  @override
  @JsonKey()
  final double conversionRate;

  @override
  String toString() {
    return 'ListingStats(impressions: $impressions, clicks: $clicks, shares: $shares, reports: $reports, conversionRate: $conversionRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListingStatsImpl &&
            (identical(other.impressions, impressions) ||
                other.impressions == impressions) &&
            (identical(other.clicks, clicks) || other.clicks == clicks) &&
            (identical(other.shares, shares) || other.shares == shares) &&
            (identical(other.reports, reports) || other.reports == reports) &&
            (identical(other.conversionRate, conversionRate) ||
                other.conversionRate == conversionRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, impressions, clicks, shares, reports, conversionRate);

  /// Create a copy of ListingStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ListingStatsImplCopyWith<_$ListingStatsImpl> get copyWith =>
      __$$ListingStatsImplCopyWithImpl<_$ListingStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListingStatsImplToJson(
      this,
    );
  }
}

abstract class _ListingStats implements ListingStats {
  const factory _ListingStats(
      {final int impressions,
      final int clicks,
      final int shares,
      final int reports,
      final double conversionRate}) = _$ListingStatsImpl;

  factory _ListingStats.fromJson(Map<String, dynamic> json) =
      _$ListingStatsImpl.fromJson;

  @override
  int get impressions;
  @override
  int get clicks;
  @override
  int get shares;
  @override
  int get reports;
  @override
  double get conversionRate;

  /// Create a copy of ListingStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ListingStatsImplCopyWith<_$ListingStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
