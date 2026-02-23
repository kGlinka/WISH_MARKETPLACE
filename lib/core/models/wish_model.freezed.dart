// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wish_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WishModel _$WishModelFromJson(Map<String, dynamic> json) {
  return _WishModel.fromJson(json);
}

/// @nodoc
mixin _$WishModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  WishCategory get category => throw _privateConstructorUsedError;
  WishPriority get priority => throw _privateConstructorUsedError;
  WishStatus get status => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  List<String> get prerequisites => throw _privateConstructorUsedError;
  String? get targetDate => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError; // 0-100
  List<WishMilestone> get milestones => throw _privateConstructorUsedError;
  List<String> get imageUrls => throw _privateConstructorUsedError;
  bool get isPublic => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  WishMetadata? get metadata => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;

  /// Serializes this WishModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WishModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WishModelCopyWith<WishModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WishModelCopyWith<$Res> {
  factory $WishModelCopyWith(WishModel value, $Res Function(WishModel) then) =
      _$WishModelCopyWithImpl<$Res, WishModel>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String description,
      WishCategory category,
      WishPriority priority,
      WishStatus status,
      List<String> tags,
      List<String> prerequisites,
      String? targetDate,
      String? notes,
      int progress,
      List<WishMilestone> milestones,
      List<String> imageUrls,
      bool isPublic,
      bool isFavorite,
      WishMetadata? metadata,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? completedAt});

  $WishMetadataCopyWith<$Res>? get metadata;
}

/// @nodoc
class _$WishModelCopyWithImpl<$Res, $Val extends WishModel>
    implements $WishModelCopyWith<$Res> {
  _$WishModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WishModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? priority = null,
    Object? status = null,
    Object? tags = null,
    Object? prerequisites = null,
    Object? targetDate = freezed,
    Object? notes = freezed,
    Object? progress = null,
    Object? milestones = null,
    Object? imageUrls = null,
    Object? isPublic = null,
    Object? isFavorite = null,
    Object? metadata = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? completedAt = freezed,
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
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as WishCategory,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as WishPriority,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as WishStatus,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      prerequisites: null == prerequisites
          ? _value.prerequisites
          : prerequisites // ignore: cast_nullable_to_non_nullable
              as List<String>,
      targetDate: freezed == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      milestones: null == milestones
          ? _value.milestones
          : milestones // ignore: cast_nullable_to_non_nullable
              as List<WishMilestone>,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as WishMetadata?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of WishModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $WishMetadataCopyWith<$Res>? get metadata {
    if (_value.metadata == null) {
      return null;
    }

    return $WishMetadataCopyWith<$Res>(_value.metadata!, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WishModelImplCopyWith<$Res>
    implements $WishModelCopyWith<$Res> {
  factory _$$WishModelImplCopyWith(
          _$WishModelImpl value, $Res Function(_$WishModelImpl) then) =
      __$$WishModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String description,
      WishCategory category,
      WishPriority priority,
      WishStatus status,
      List<String> tags,
      List<String> prerequisites,
      String? targetDate,
      String? notes,
      int progress,
      List<WishMilestone> milestones,
      List<String> imageUrls,
      bool isPublic,
      bool isFavorite,
      WishMetadata? metadata,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? completedAt});

  @override
  $WishMetadataCopyWith<$Res>? get metadata;
}

/// @nodoc
class __$$WishModelImplCopyWithImpl<$Res>
    extends _$WishModelCopyWithImpl<$Res, _$WishModelImpl>
    implements _$$WishModelImplCopyWith<$Res> {
  __$$WishModelImplCopyWithImpl(
      _$WishModelImpl _value, $Res Function(_$WishModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of WishModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? description = null,
    Object? category = null,
    Object? priority = null,
    Object? status = null,
    Object? tags = null,
    Object? prerequisites = null,
    Object? targetDate = freezed,
    Object? notes = freezed,
    Object? progress = null,
    Object? milestones = null,
    Object? imageUrls = null,
    Object? isPublic = null,
    Object? isFavorite = null,
    Object? metadata = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? completedAt = freezed,
  }) {
    return _then(_$WishModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as WishCategory,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as WishPriority,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as WishStatus,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      prerequisites: null == prerequisites
          ? _value._prerequisites
          : prerequisites // ignore: cast_nullable_to_non_nullable
              as List<String>,
      targetDate: freezed == targetDate
          ? _value.targetDate
          : targetDate // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      progress: null == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int,
      milestones: null == milestones
          ? _value._milestones
          : milestones // ignore: cast_nullable_to_non_nullable
              as List<WishMilestone>,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isPublic: null == isPublic
          ? _value.isPublic
          : isPublic // ignore: cast_nullable_to_non_nullable
              as bool,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as WishMetadata?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WishModelImpl implements _WishModel {
  const _$WishModelImpl(
      {required this.id,
      required this.userId,
      required this.title,
      required this.description,
      required this.category,
      required this.priority,
      required this.status,
      final List<String> tags = const [],
      final List<String> prerequisites = const [],
      this.targetDate,
      this.notes,
      this.progress = 0,
      final List<WishMilestone> milestones = const [],
      final List<String> imageUrls = const [],
      this.isPublic = false,
      this.isFavorite = false,
      this.metadata,
      required this.createdAt,
      this.updatedAt,
      this.completedAt})
      : _tags = tags,
        _prerequisites = prerequisites,
        _milestones = milestones,
        _imageUrls = imageUrls;

  factory _$WishModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WishModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String description;
  @override
  final WishCategory category;
  @override
  final WishPriority priority;
  @override
  final WishStatus status;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<String> _prerequisites;
  @override
  @JsonKey()
  List<String> get prerequisites {
    if (_prerequisites is EqualUnmodifiableListView) return _prerequisites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_prerequisites);
  }

  @override
  final String? targetDate;
  @override
  final String? notes;
  @override
  @JsonKey()
  final int progress;
// 0-100
  final List<WishMilestone> _milestones;
// 0-100
  @override
  @JsonKey()
  List<WishMilestone> get milestones {
    if (_milestones is EqualUnmodifiableListView) return _milestones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_milestones);
  }

  final List<String> _imageUrls;
  @override
  @JsonKey()
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  @JsonKey()
  final bool isPublic;
  @override
  @JsonKey()
  final bool isFavorite;
  @override
  final WishMetadata? metadata;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? completedAt;

  @override
  String toString() {
    return 'WishModel(id: $id, userId: $userId, title: $title, description: $description, category: $category, priority: $priority, status: $status, tags: $tags, prerequisites: $prerequisites, targetDate: $targetDate, notes: $notes, progress: $progress, milestones: $milestones, imageUrls: $imageUrls, isPublic: $isPublic, isFavorite: $isFavorite, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WishModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._prerequisites, _prerequisites) &&
            (identical(other.targetDate, targetDate) ||
                other.targetDate == targetDate) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            const DeepCollectionEquality()
                .equals(other._milestones, _milestones) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            (identical(other.isPublic, isPublic) ||
                other.isPublic == isPublic) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        userId,
        title,
        description,
        category,
        priority,
        status,
        const DeepCollectionEquality().hash(_tags),
        const DeepCollectionEquality().hash(_prerequisites),
        targetDate,
        notes,
        progress,
        const DeepCollectionEquality().hash(_milestones),
        const DeepCollectionEquality().hash(_imageUrls),
        isPublic,
        isFavorite,
        metadata,
        createdAt,
        updatedAt,
        completedAt
      ]);

  /// Create a copy of WishModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WishModelImplCopyWith<_$WishModelImpl> get copyWith =>
      __$$WishModelImplCopyWithImpl<_$WishModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WishModelImplToJson(
      this,
    );
  }
}

abstract class _WishModel implements WishModel {
  const factory _WishModel(
      {required final String id,
      required final String userId,
      required final String title,
      required final String description,
      required final WishCategory category,
      required final WishPriority priority,
      required final WishStatus status,
      final List<String> tags,
      final List<String> prerequisites,
      final String? targetDate,
      final String? notes,
      final int progress,
      final List<WishMilestone> milestones,
      final List<String> imageUrls,
      final bool isPublic,
      final bool isFavorite,
      final WishMetadata? metadata,
      required final DateTime createdAt,
      final DateTime? updatedAt,
      final DateTime? completedAt}) = _$WishModelImpl;

  factory _WishModel.fromJson(Map<String, dynamic> json) =
      _$WishModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get title;
  @override
  String get description;
  @override
  WishCategory get category;
  @override
  WishPriority get priority;
  @override
  WishStatus get status;
  @override
  List<String> get tags;
  @override
  List<String> get prerequisites;
  @override
  String? get targetDate;
  @override
  String? get notes;
  @override
  int get progress; // 0-100
  @override
  List<WishMilestone> get milestones;
  @override
  List<String> get imageUrls;
  @override
  bool get isPublic;
  @override
  bool get isFavorite;
  @override
  WishMetadata? get metadata;
  @override
  DateTime get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get completedAt;

  /// Create a copy of WishModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WishModelImplCopyWith<_$WishModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WishMilestone _$WishMilestoneFromJson(Map<String, dynamic> json) {
  return _WishMilestone.fromJson(json);
}

/// @nodoc
mixin _$WishMilestone {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  int get order => throw _privateConstructorUsedError;

  /// Serializes this WishMilestone to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WishMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WishMilestoneCopyWith<WishMilestone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WishMilestoneCopyWith<$Res> {
  factory $WishMilestoneCopyWith(
          WishMilestone value, $Res Function(WishMilestone) then) =
      _$WishMilestoneCopyWithImpl<$Res, WishMilestone>;
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      bool isCompleted,
      DateTime? completedAt,
      int order});
}

/// @nodoc
class _$WishMilestoneCopyWithImpl<$Res, $Val extends WishMilestone>
    implements $WishMilestoneCopyWith<$Res> {
  _$WishMilestoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WishMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? order = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WishMilestoneImplCopyWith<$Res>
    implements $WishMilestoneCopyWith<$Res> {
  factory _$$WishMilestoneImplCopyWith(
          _$WishMilestoneImpl value, $Res Function(_$WishMilestoneImpl) then) =
      __$$WishMilestoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? description,
      bool isCompleted,
      DateTime? completedAt,
      int order});
}

/// @nodoc
class __$$WishMilestoneImplCopyWithImpl<$Res>
    extends _$WishMilestoneCopyWithImpl<$Res, _$WishMilestoneImpl>
    implements _$$WishMilestoneImplCopyWith<$Res> {
  __$$WishMilestoneImplCopyWithImpl(
      _$WishMilestoneImpl _value, $Res Function(_$WishMilestoneImpl) _then)
      : super(_value, _then);

  /// Create a copy of WishMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = freezed,
    Object? isCompleted = null,
    Object? completedAt = freezed,
    Object? order = null,
  }) {
    return _then(_$WishMilestoneImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WishMilestoneImpl implements _WishMilestone {
  const _$WishMilestoneImpl(
      {required this.id,
      required this.title,
      this.description,
      required this.isCompleted,
      this.completedAt,
      this.order = 0});

  factory _$WishMilestoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$WishMilestoneImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? description;
  @override
  final bool isCompleted;
  @override
  final DateTime? completedAt;
  @override
  @JsonKey()
  final int order;

  @override
  String toString() {
    return 'WishMilestone(id: $id, title: $title, description: $description, isCompleted: $isCompleted, completedAt: $completedAt, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WishMilestoneImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, title, description, isCompleted, completedAt, order);

  /// Create a copy of WishMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WishMilestoneImplCopyWith<_$WishMilestoneImpl> get copyWith =>
      __$$WishMilestoneImplCopyWithImpl<_$WishMilestoneImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WishMilestoneImplToJson(
      this,
    );
  }
}

abstract class _WishMilestone implements WishMilestone {
  const factory _WishMilestone(
      {required final String id,
      required final String title,
      final String? description,
      required final bool isCompleted,
      final DateTime? completedAt,
      final int order}) = _$WishMilestoneImpl;

  factory _WishMilestone.fromJson(Map<String, dynamic> json) =
      _$WishMilestoneImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  bool get isCompleted;
  @override
  DateTime? get completedAt;
  @override
  int get order;

  /// Create a copy of WishMilestone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WishMilestoneImplCopyWith<_$WishMilestoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WishMetadata _$WishMetadataFromJson(Map<String, dynamic> json) {
  return _WishMetadata.fromJson(json);
}

/// @nodoc
mixin _$WishMetadata {
  String? get inspiration =>
      throw _privateConstructorUsedError; // What inspired this wish
  String? get motivation =>
      throw _privateConstructorUsedError; // Why this wish matters
  List<String> get resources =>
      throw _privateConstructorUsedError; // Helpful resources
  List<String> get obstacles =>
      throw _privateConstructorUsedError; // Known obstacles
  Map<String, dynamic>? get customFields => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  int get shareCount => throw _privateConstructorUsedError;
  DateTime? get lastViewedAt => throw _privateConstructorUsedError;

  /// Serializes this WishMetadata to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WishMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WishMetadataCopyWith<WishMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WishMetadataCopyWith<$Res> {
  factory $WishMetadataCopyWith(
          WishMetadata value, $Res Function(WishMetadata) then) =
      _$WishMetadataCopyWithImpl<$Res, WishMetadata>;
  @useResult
  $Res call(
      {String? inspiration,
      String? motivation,
      List<String> resources,
      List<String> obstacles,
      Map<String, dynamic>? customFields,
      int viewCount,
      int shareCount,
      DateTime? lastViewedAt});
}

/// @nodoc
class _$WishMetadataCopyWithImpl<$Res, $Val extends WishMetadata>
    implements $WishMetadataCopyWith<$Res> {
  _$WishMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WishMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inspiration = freezed,
    Object? motivation = freezed,
    Object? resources = null,
    Object? obstacles = null,
    Object? customFields = freezed,
    Object? viewCount = null,
    Object? shareCount = null,
    Object? lastViewedAt = freezed,
  }) {
    return _then(_value.copyWith(
      inspiration: freezed == inspiration
          ? _value.inspiration
          : inspiration // ignore: cast_nullable_to_non_nullable
              as String?,
      motivation: freezed == motivation
          ? _value.motivation
          : motivation // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: null == resources
          ? _value.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>,
      obstacles: null == obstacles
          ? _value.obstacles
          : obstacles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customFields: freezed == customFields
          ? _value.customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      shareCount: null == shareCount
          ? _value.shareCount
          : shareCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastViewedAt: freezed == lastViewedAt
          ? _value.lastViewedAt
          : lastViewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WishMetadataImplCopyWith<$Res>
    implements $WishMetadataCopyWith<$Res> {
  factory _$$WishMetadataImplCopyWith(
          _$WishMetadataImpl value, $Res Function(_$WishMetadataImpl) then) =
      __$$WishMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? inspiration,
      String? motivation,
      List<String> resources,
      List<String> obstacles,
      Map<String, dynamic>? customFields,
      int viewCount,
      int shareCount,
      DateTime? lastViewedAt});
}

/// @nodoc
class __$$WishMetadataImplCopyWithImpl<$Res>
    extends _$WishMetadataCopyWithImpl<$Res, _$WishMetadataImpl>
    implements _$$WishMetadataImplCopyWith<$Res> {
  __$$WishMetadataImplCopyWithImpl(
      _$WishMetadataImpl _value, $Res Function(_$WishMetadataImpl) _then)
      : super(_value, _then);

  /// Create a copy of WishMetadata
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? inspiration = freezed,
    Object? motivation = freezed,
    Object? resources = null,
    Object? obstacles = null,
    Object? customFields = freezed,
    Object? viewCount = null,
    Object? shareCount = null,
    Object? lastViewedAt = freezed,
  }) {
    return _then(_$WishMetadataImpl(
      inspiration: freezed == inspiration
          ? _value.inspiration
          : inspiration // ignore: cast_nullable_to_non_nullable
              as String?,
      motivation: freezed == motivation
          ? _value.motivation
          : motivation // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: null == resources
          ? _value._resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>,
      obstacles: null == obstacles
          ? _value._obstacles
          : obstacles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      customFields: freezed == customFields
          ? _value._customFields
          : customFields // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      viewCount: null == viewCount
          ? _value.viewCount
          : viewCount // ignore: cast_nullable_to_non_nullable
              as int,
      shareCount: null == shareCount
          ? _value.shareCount
          : shareCount // ignore: cast_nullable_to_non_nullable
              as int,
      lastViewedAt: freezed == lastViewedAt
          ? _value.lastViewedAt
          : lastViewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WishMetadataImpl implements _WishMetadata {
  const _$WishMetadataImpl(
      {this.inspiration,
      this.motivation,
      final List<String> resources = const [],
      final List<String> obstacles = const [],
      final Map<String, dynamic>? customFields,
      this.viewCount = 0,
      this.shareCount = 0,
      this.lastViewedAt})
      : _resources = resources,
        _obstacles = obstacles,
        _customFields = customFields;

  factory _$WishMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$WishMetadataImplFromJson(json);

  @override
  final String? inspiration;
// What inspired this wish
  @override
  final String? motivation;
// Why this wish matters
  final List<String> _resources;
// Why this wish matters
  @override
  @JsonKey()
  List<String> get resources {
    if (_resources is EqualUnmodifiableListView) return _resources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_resources);
  }

// Helpful resources
  final List<String> _obstacles;
// Helpful resources
  @override
  @JsonKey()
  List<String> get obstacles {
    if (_obstacles is EqualUnmodifiableListView) return _obstacles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_obstacles);
  }

// Known obstacles
  final Map<String, dynamic>? _customFields;
// Known obstacles
  @override
  Map<String, dynamic>? get customFields {
    final value = _customFields;
    if (value == null) return null;
    if (_customFields is EqualUnmodifiableMapView) return _customFields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey()
  final int viewCount;
  @override
  @JsonKey()
  final int shareCount;
  @override
  final DateTime? lastViewedAt;

  @override
  String toString() {
    return 'WishMetadata(inspiration: $inspiration, motivation: $motivation, resources: $resources, obstacles: $obstacles, customFields: $customFields, viewCount: $viewCount, shareCount: $shareCount, lastViewedAt: $lastViewedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WishMetadataImpl &&
            (identical(other.inspiration, inspiration) ||
                other.inspiration == inspiration) &&
            (identical(other.motivation, motivation) ||
                other.motivation == motivation) &&
            const DeepCollectionEquality()
                .equals(other._resources, _resources) &&
            const DeepCollectionEquality()
                .equals(other._obstacles, _obstacles) &&
            const DeepCollectionEquality()
                .equals(other._customFields, _customFields) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.shareCount, shareCount) ||
                other.shareCount == shareCount) &&
            (identical(other.lastViewedAt, lastViewedAt) ||
                other.lastViewedAt == lastViewedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      inspiration,
      motivation,
      const DeepCollectionEquality().hash(_resources),
      const DeepCollectionEquality().hash(_obstacles),
      const DeepCollectionEquality().hash(_customFields),
      viewCount,
      shareCount,
      lastViewedAt);

  /// Create a copy of WishMetadata
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WishMetadataImplCopyWith<_$WishMetadataImpl> get copyWith =>
      __$$WishMetadataImplCopyWithImpl<_$WishMetadataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WishMetadataImplToJson(
      this,
    );
  }
}

abstract class _WishMetadata implements WishMetadata {
  const factory _WishMetadata(
      {final String? inspiration,
      final String? motivation,
      final List<String> resources,
      final List<String> obstacles,
      final Map<String, dynamic>? customFields,
      final int viewCount,
      final int shareCount,
      final DateTime? lastViewedAt}) = _$WishMetadataImpl;

  factory _WishMetadata.fromJson(Map<String, dynamic> json) =
      _$WishMetadataImpl.fromJson;

  @override
  String? get inspiration; // What inspired this wish
  @override
  String? get motivation; // Why this wish matters
  @override
  List<String> get resources; // Helpful resources
  @override
  List<String> get obstacles; // Known obstacles
  @override
  Map<String, dynamic>? get customFields;
  @override
  int get viewCount;
  @override
  int get shareCount;
  @override
  DateTime? get lastViewedAt;

  /// Create a copy of WishMetadata
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WishMetadataImplCopyWith<_$WishMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
