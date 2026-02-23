// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'listing_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListingModelImpl _$$ListingModelImplFromJson(Map<String, dynamic> json) =>
    _$ListingModelImpl(
      id: json['id'] as String,
      sellerId: json['sellerId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      startingPrice: (json['startingPrice'] as num).toInt(),
      currentBid: (json['currentBid'] as num?)?.toInt(),
      buyNowPrice: (json['buyNowPrice'] as num?)?.toInt(),
      imageUrls:
          (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
      videoUrl: json['videoUrl'] as String?,
      category: json['category'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      status: $enumDecode(_$ListingStatusEnumMap, json['status']),
      condition: $enumDecode(_$ListingConditionEnumMap, json['condition']),
      specs: json['specs'] == null
          ? null
          : ListingSpecs.fromJson(json['specs'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : ListingLocation.fromJson(json['location'] as Map<String, dynamic>),
      stats: json['stats'] == null
          ? null
          : ListingStats.fromJson(json['stats'] as Map<String, dynamic>),
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      soldAt: json['soldAt'] == null
          ? null
          : DateTime.parse(json['soldAt'] as String),
      winnerId: json['winnerId'] as String?,
      isFeatured: json['isFeatured'] as bool? ?? false,
      isPromoted: json['isPromoted'] as bool? ?? false,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      favoriteCount: (json['favoriteCount'] as num?)?.toInt() ?? 0,
      bidCount: (json['bidCount'] as num?)?.toInt() ?? 0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ListingModelImplToJson(_$ListingModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sellerId': instance.sellerId,
      'title': instance.title,
      'description': instance.description,
      'startingPrice': instance.startingPrice,
      'currentBid': instance.currentBid,
      'buyNowPrice': instance.buyNowPrice,
      'imageUrls': instance.imageUrls,
      'videoUrl': instance.videoUrl,
      'category': instance.category,
      'tags': instance.tags,
      'status': _$ListingStatusEnumMap[instance.status]!,
      'condition': _$ListingConditionEnumMap[instance.condition]!,
      'specs': instance.specs,
      'location': instance.location,
      'stats': instance.stats,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'soldAt': instance.soldAt?.toIso8601String(),
      'winnerId': instance.winnerId,
      'isFeatured': instance.isFeatured,
      'isPromoted': instance.isPromoted,
      'viewCount': instance.viewCount,
      'favoriteCount': instance.favoriteCount,
      'bidCount': instance.bidCount,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ListingStatusEnumMap = {
  ListingStatus.draft: 'draft',
  ListingStatus.active: 'active',
  ListingStatus.pending: 'pending',
  ListingStatus.sold: 'sold',
  ListingStatus.expired: 'expired',
  ListingStatus.cancelled: 'cancelled',
  ListingStatus.removed: 'removed',
};

const _$ListingConditionEnumMap = {
  ListingCondition.brandNew: 'brandNew',
  ListingCondition.likeNew: 'likeNew',
  ListingCondition.excellent: 'excellent',
  ListingCondition.good: 'good',
  ListingCondition.fair: 'fair',
  ListingCondition.poor: 'poor',
};

_$ListingSpecsImpl _$$ListingSpecsImplFromJson(Map<String, dynamic> json) =>
    _$ListingSpecsImpl(
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      color: json['color'] as String?,
      size: json['size'] as String?,
      material: json['material'] as String?,
      connectivity: json['connectivity'] as String?,
      compatibility: json['compatibility'] as String?,
      batteryLife: json['batteryLife'] as String?,
      displaySize: json['displaySize'] as String?,
      displayType: json['displayType'] as String?,
      waterResistance: json['waterResistance'] as String?,
      sensors: json['sensors'] as String?,
      storage: json['storage'] as String?,
      ram: json['ram'] as String?,
      processor: json['processor'] as String?,
      operatingSystem: json['operatingSystem'] as String?,
      releaseYear: json['releaseYear'] as String?,
      additionalSpecs: json['additionalSpecs'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ListingSpecsImplToJson(_$ListingSpecsImpl instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'model': instance.model,
      'color': instance.color,
      'size': instance.size,
      'material': instance.material,
      'connectivity': instance.connectivity,
      'compatibility': instance.compatibility,
      'batteryLife': instance.batteryLife,
      'displaySize': instance.displaySize,
      'displayType': instance.displayType,
      'waterResistance': instance.waterResistance,
      'sensors': instance.sensors,
      'storage': instance.storage,
      'ram': instance.ram,
      'processor': instance.processor,
      'operatingSystem': instance.operatingSystem,
      'releaseYear': instance.releaseYear,
      'additionalSpecs': instance.additionalSpecs,
    };

_$ListingLocationImpl _$$ListingLocationImplFromJson(
        Map<String, dynamic> json) =>
    _$ListingLocationImpl(
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      isLocalPickupAvailable: json['isLocalPickupAvailable'] as bool? ?? false,
      isShippingAvailable: json['isShippingAvailable'] as bool? ?? true,
      shippingCost: (json['shippingCost'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$ListingLocationImplToJson(
        _$ListingLocationImpl instance) =>
    <String, dynamic>{
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'postalCode': instance.postalCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'isLocalPickupAvailable': instance.isLocalPickupAvailable,
      'isShippingAvailable': instance.isShippingAvailable,
      'shippingCost': instance.shippingCost,
    };

_$ListingStatsImpl _$$ListingStatsImplFromJson(Map<String, dynamic> json) =>
    _$ListingStatsImpl(
      impressions: (json['impressions'] as num?)?.toInt() ?? 0,
      clicks: (json['clicks'] as num?)?.toInt() ?? 0,
      shares: (json['shares'] as num?)?.toInt() ?? 0,
      reports: (json['reports'] as num?)?.toInt() ?? 0,
      conversionRate: (json['conversionRate'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$ListingStatsImplToJson(_$ListingStatsImpl instance) =>
    <String, dynamic>{
      'impressions': instance.impressions,
      'clicks': instance.clicks,
      'shares': instance.shares,
      'reports': instance.reports,
      'conversionRate': instance.conversionRate,
    };
