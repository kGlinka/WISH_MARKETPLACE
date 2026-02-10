import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

/// Message type enum
enum MessageType {
  text,
  image,
  listing,
  offer,
  system,
}

/// Message model representing a chat message
///
/// Uses Freezed for immutability, equality, and JSON serialization
@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,
    required String conversationId,
    required String senderId,
    required String recipientId,
    required MessageType type,
    required String content,
    String? imageUrl,
    String? listingId,
    int? offerAmount, // in cents
    @Default(false) bool isRead,
    DateTime? readAt,
    @Default(false) bool isDeleted,
    DateTime? deletedAt,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}

/// Conversation model representing a chat thread
@freezed
class ConversationModel with _$ConversationModel {
  const factory ConversationModel({
    required String id,
    required List<String> participantIds,
    String? listingId,
    MessageModel? lastMessage,
    @Default(0) int unreadCount,
    @Default(false) bool isMuted,
    @Default(false) bool isArchived,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _ConversationModel;

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);
}
