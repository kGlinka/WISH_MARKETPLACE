import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_model.freezed.dart';
part 'notification_model.g.dart';

/// Notification type enum
enum NotificationType {
  bidPlaced,
  bidOutbid,
  bidWon,
  bidExpired,
  listingSold,
  listingExpired,
  message,
  payment,
  shipment,
  review,
  follow,
  system,
}

/// Notification priority enum
enum NotificationPriority {
  low,
  medium,
  high,
  urgent,
}

/// Notification model
///
/// Uses Freezed for immutability, equality, and JSON serialization
@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    required String id,
    required String userId,
    required NotificationType type,
    required String title,
    required String body,
    String? imageUrl,
    NotificationPriority? priority,
    Map<String, dynamic>? data,
    String? actionUrl,
    String? listingId,
    String? bidId,
    String? messageId,
    @Default(false) bool isRead,
    DateTime? readAt,
    @Default(false) bool isSent,
    DateTime? sentAt,
    required DateTime createdAt,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
