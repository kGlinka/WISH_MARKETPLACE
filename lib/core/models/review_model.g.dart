// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewModelImpl _$$ReviewModelImplFromJson(Map<String, dynamic> json) =>
    _$ReviewModelImpl(
      id: json['id'] as String,
      reviewerId: json['reviewerId'] as String,
      revieweeId: json['revieweeId'] as String,
      listingId: json['listingId'] as String,
      transactionId: json['transactionId'] as String?,
      type: $enumDecode(_$ReviewTypeEnumMap, json['type']),
      rating: (json['rating'] as num).toDouble(),
      title: json['title'] as String?,
      comment: json['comment'] as String?,
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      helpfulCount: (json['helpfulCount'] as num?)?.toInt() ?? 0,
      isVerifiedPurchase: json['isVerifiedPurchase'] as bool? ?? false,
      sellerResponse: json['sellerResponse'] as String?,
      sellerResponseAt: json['sellerResponseAt'] == null
          ? null
          : DateTime.parse(json['sellerResponseAt'] as String),
      isReported: json['isReported'] as bool? ?? false,
      reportCount: (json['reportCount'] as num?)?.toInt() ?? 0,
      isHidden: json['isHidden'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$ReviewModelImplToJson(_$ReviewModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reviewerId': instance.reviewerId,
      'revieweeId': instance.revieweeId,
      'listingId': instance.listingId,
      'transactionId': instance.transactionId,
      'type': _$ReviewTypeEnumMap[instance.type]!,
      'rating': instance.rating,
      'title': instance.title,
      'comment': instance.comment,
      'imageUrls': instance.imageUrls,
      'helpfulCount': instance.helpfulCount,
      'isVerifiedPurchase': instance.isVerifiedPurchase,
      'sellerResponse': instance.sellerResponse,
      'sellerResponseAt': instance.sellerResponseAt?.toIso8601String(),
      'isReported': instance.isReported,
      'reportCount': instance.reportCount,
      'isHidden': instance.isHidden,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ReviewTypeEnumMap = {
  ReviewType.buyer: 'buyer',
  ReviewType.seller: 'seller',
  ReviewType.product: 'product',
};
