// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: $enumDecode(_$NotificationTypeEnumMap, json['type']),
      title: json['title'] as String,
      body: json['body'] as String,
      imageUrl: json['imageUrl'] as String?,
      priority:
          $enumDecodeNullable(_$NotificationPriorityEnumMap, json['priority']),
      data: json['data'] as Map<String, dynamic>?,
      actionUrl: json['actionUrl'] as String?,
      listingId: json['listingId'] as String?,
      bidId: json['bidId'] as String?,
      messageId: json['messageId'] as String?,
      isRead: json['isRead'] as bool? ?? false,
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      isSent: json['isSent'] as bool? ?? false,
      sentAt: json['sentAt'] == null
          ? null
          : DateTime.parse(json['sentAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'type': _$NotificationTypeEnumMap[instance.type]!,
      'title': instance.title,
      'body': instance.body,
      'imageUrl': instance.imageUrl,
      'priority': _$NotificationPriorityEnumMap[instance.priority],
      'data': instance.data,
      'actionUrl': instance.actionUrl,
      'listingId': instance.listingId,
      'bidId': instance.bidId,
      'messageId': instance.messageId,
      'isRead': instance.isRead,
      'readAt': instance.readAt?.toIso8601String(),
      'isSent': instance.isSent,
      'sentAt': instance.sentAt?.toIso8601String(),
      'createdAt': instance.createdAt.toIso8601String(),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.bidPlaced: 'bidPlaced',
  NotificationType.bidOutbid: 'bidOutbid',
  NotificationType.bidWon: 'bidWon',
  NotificationType.bidExpired: 'bidExpired',
  NotificationType.listingSold: 'listingSold',
  NotificationType.listingExpired: 'listingExpired',
  NotificationType.message: 'message',
  NotificationType.payment: 'payment',
  NotificationType.shipment: 'shipment',
  NotificationType.review: 'review',
  NotificationType.follow: 'follow',
  NotificationType.system: 'system',
};

const _$NotificationPriorityEnumMap = {
  NotificationPriority.low: 'low',
  NotificationPriority.medium: 'medium',
  NotificationPriority.high: 'high',
  NotificationPriority.urgent: 'urgent',
};
