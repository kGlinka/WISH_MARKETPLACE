// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wish_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WishModelImpl _$$WishModelImplFromJson(Map<String, dynamic> json) =>
    _$WishModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      category: $enumDecode(_$WishCategoryEnumMap, json['category']),
      priority: $enumDecode(_$WishPriorityEnumMap, json['priority']),
      status: $enumDecode(_$WishStatusEnumMap, json['status']),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      prerequisites: (json['prerequisites'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      targetDate: json['targetDate'] as String?,
      notes: json['notes'] as String?,
      progress: (json['progress'] as num?)?.toInt() ?? 0,
      milestones: (json['milestones'] as List<dynamic>?)
              ?.map((e) => WishMilestone.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      imageUrls: (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isPublic: json['isPublic'] as bool? ?? false,
      isFavorite: json['isFavorite'] as bool? ?? false,
      metadata: json['metadata'] == null
          ? null
          : WishMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$WishModelImplToJson(_$WishModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'category': _$WishCategoryEnumMap[instance.category]!,
      'priority': _$WishPriorityEnumMap[instance.priority]!,
      'status': _$WishStatusEnumMap[instance.status]!,
      'tags': instance.tags,
      'prerequisites': instance.prerequisites,
      'targetDate': instance.targetDate,
      'notes': instance.notes,
      'progress': instance.progress,
      'milestones': instance.milestones,
      'imageUrls': instance.imageUrls,
      'isPublic': instance.isPublic,
      'isFavorite': instance.isFavorite,
      'metadata': instance.metadata,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };

const _$WishCategoryEnumMap = {
  WishCategory.personalGrowth: 'personalGrowth',
  WishCategory.travel: 'travel',
  WishCategory.career: 'career',
  WishCategory.relationships: 'relationships',
  WishCategory.health: 'health',
  WishCategory.creativity: 'creativity',
  WishCategory.financial: 'financial',
  WishCategory.education: 'education',
  WishCategory.adventure: 'adventure',
  WishCategory.material: 'material',
  WishCategory.spiritual: 'spiritual',
  WishCategory.other: 'other',
};

const _$WishPriorityEnumMap = {
  WishPriority.low: 'low',
  WishPriority.medium: 'medium',
  WishPriority.high: 'high',
  WishPriority.urgent: 'urgent',
};

const _$WishStatusEnumMap = {
  WishStatus.active: 'active',
  WishStatus.inProgress: 'inProgress',
  WishStatus.completed: 'completed',
  WishStatus.deferred: 'deferred',
  WishStatus.cancelled: 'cancelled',
};

_$WishMilestoneImpl _$$WishMilestoneImplFromJson(Map<String, dynamic> json) =>
    _$WishMilestoneImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      isCompleted: json['isCompleted'] as bool,
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      order: (json['order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$WishMilestoneImplToJson(_$WishMilestoneImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isCompleted': instance.isCompleted,
      'completedAt': instance.completedAt?.toIso8601String(),
      'order': instance.order,
    };

_$WishMetadataImpl _$$WishMetadataImplFromJson(Map<String, dynamic> json) =>
    _$WishMetadataImpl(
      inspiration: json['inspiration'] as String?,
      motivation: json['motivation'] as String?,
      resources: (json['resources'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      obstacles: (json['obstacles'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      customFields: json['customFields'] as Map<String, dynamic>?,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      shareCount: (json['shareCount'] as num?)?.toInt() ?? 0,
      lastViewedAt: json['lastViewedAt'] == null
          ? null
          : DateTime.parse(json['lastViewedAt'] as String),
    );

Map<String, dynamic> _$$WishMetadataImplToJson(_$WishMetadataImpl instance) =>
    <String, dynamic>{
      'inspiration': instance.inspiration,
      'motivation': instance.motivation,
      'resources': instance.resources,
      'obstacles': instance.obstacles,
      'customFields': instance.customFields,
      'viewCount': instance.viewCount,
      'shareCount': instance.shareCount,
      'lastViewedAt': instance.lastViewedAt?.toIso8601String(),
    };
