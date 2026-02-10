// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bid_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BidModelImpl _$$BidModelImplFromJson(Map<String, dynamic> json) =>
    _$BidModelImpl(
      id: json['id'] as String,
      listingId: json['listingId'] as String,
      bidderId: json['bidderId'] as String,
      amount: (json['amount'] as num).toInt(),
      status: $enumDecode(_$BidStatusEnumMap, json['status']),
      message: json['message'] as String?,
      isAutoBid: json['isAutoBid'] as bool? ?? false,
      maxAutoBidAmount: (json['maxAutoBidAmount'] as num?)?.toInt(),
      isProxy: json['isProxy'] as bool? ?? false,
      proxyBidId: json['proxyBidId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      cancelledAt: json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
      cancellationReason: json['cancellationReason'] as String?,
    );

Map<String, dynamic> _$$BidModelImplToJson(_$BidModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'listingId': instance.listingId,
      'bidderId': instance.bidderId,
      'amount': instance.amount,
      'status': _$BidStatusEnumMap[instance.status]!,
      'message': instance.message,
      'isAutoBid': instance.isAutoBid,
      'maxAutoBidAmount': instance.maxAutoBidAmount,
      'isProxy': instance.isProxy,
      'proxyBidId': instance.proxyBidId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'cancellationReason': instance.cancellationReason,
    };

const _$BidStatusEnumMap = {
  BidStatus.active: 'active',
  BidStatus.outbid: 'outbid',
  BidStatus.winning: 'winning',
  BidStatus.won: 'won',
  BidStatus.lost: 'lost',
  BidStatus.cancelled: 'cancelled',
  BidStatus.expired: 'expired',
};

_$BidHistoryEntryImpl _$$BidHistoryEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$BidHistoryEntryImpl(
      bidId: json['bidId'] as String,
      bidderId: json['bidderId'] as String,
      bidderUsername: json['bidderUsername'] as String?,
      bidderAvatarUrl: json['bidderAvatarUrl'] as String?,
      amount: (json['amount'] as num).toInt(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$BidHistoryEntryImplToJson(
        _$BidHistoryEntryImpl instance) =>
    <String, dynamic>{
      'bidId': instance.bidId,
      'bidderId': instance.bidderId,
      'bidderUsername': instance.bidderUsername,
      'bidderAvatarUrl': instance.bidderAvatarUrl,
      'amount': instance.amount,
      'timestamp': instance.timestamp.toIso8601String(),
    };
