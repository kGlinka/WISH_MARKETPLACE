import 'package:flutter/material.dart';
import '../../../core/models/wish_model.dart';
import '../../../core/models/listing_model.dart';
import '../../../core/models/bid_model.dart';
import '../../../core/models/notification_model.dart';
import 'wear_theme.dart';

/// Wear OS extensions for WishModel
extension WearWishModelExtension on WishModel {
  Color get priorityColor {
    switch (priority) {
      case WishPriority.urgent:
        return WearColors.error;
      case WishPriority.high:
        return WearColors.warning;
      case WishPriority.medium:
        return WearColors.info;
      case WishPriority.low:
        return const Color(0xFF6B7280);
    }
  }

  Color get statusColor {
    switch (status) {
      case WishStatus.active:
        return WearColors.success;
      case WishStatus.inProgress:
        return WearColors.info;
      case WishStatus.completed:
        return WearColors.primary;
      case WishStatus.deferred:
        return const Color(0xFF6B7280);
      case WishStatus.cancelled:
        return const Color(0xFF6B7280);
    }
  }

  String get categoryDisplay {
    return category.name
        .replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (m) => '${m[1]} ${m[2]}')
        .replaceFirst(category.name[0], category.name[0].toUpperCase());
  }
}

/// Wear OS extensions for ListingModel
extension WearListingModelExtension on ListingModel {
  String get currentBidFormatted {
    final bid = currentBid ?? startingPrice;
    return '\$${(bid / 100).toStringAsFixed(2)}';
  }

  String get startingBidFormatted {
    return '\$${(startingPrice / 100).toStringAsFixed(2)}';
  }

  String? get buyNowPriceFormatted {
    if (buyNowPrice == null) return null;
    return '\$${(buyNowPrice! / 100).toStringAsFixed(2)}';
  }

  String get timeRemaining {
    final now = DateTime.now();
    final diff = endTime.difference(now);

    if (diff.isNegative) return 'Ended';
    if (diff.inHours < 1) return '${diff.inMinutes}m';
    if (diff.inDays < 1) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  bool get isEndingSoon {
    final diff = endTime.difference(DateTime.now());
    return !diff.isNegative && diff.inHours < 1;
  }

  int get effectiveBidIncrement {
    // Default bid increment if not available from specs
    return 100; // $1.00 in cents
  }
}

/// Wear OS extensions for BidModel
extension WearBidModelExtension on BidModel {
  String get amountFormatted {
    return '\$${(amount / 100).toStringAsFixed(2)}';
  }

  Color get statusColor {
    switch (status) {
      case BidStatus.winning:
        return WearColors.winningGold;
      case BidStatus.won:
        return WearColors.success;
      case BidStatus.outbid:
        return WearColors.error;
      case BidStatus.active:
        return WearColors.info;
      case BidStatus.lost:
        return const Color(0xFF6B7280);
      case BidStatus.cancelled:
        return const Color(0xFF6B7280);
      case BidStatus.expired:
        return const Color(0xFF6B7280);
    }
  }
}

/// Wear OS extensions for NotificationModel
extension WearNotificationModelExtension on NotificationModel {
  IconData get typeIcon {
    switch (type) {
      case NotificationType.bidPlaced:
        return Icons.gavel;
      case NotificationType.bidOutbid:
        return Icons.warning;
      case NotificationType.bidWon:
        return Icons.emoji_events;
      case NotificationType.bidExpired:
        return Icons.schedule;
      case NotificationType.message:
        return Icons.message;
      case NotificationType.payment:
        return Icons.payment;
      default:
        return Icons.notifications;
    }
  }

  Color get typeColor {
    switch (type) {
      case NotificationType.bidPlaced:
        return WearColors.info;
      case NotificationType.bidOutbid:
        return WearColors.warning;
      case NotificationType.bidWon:
        return WearColors.winningGold;
      case NotificationType.bidExpired:
        return WearColors.onSurfaceVariant;
      case NotificationType.message:
        return WearColors.info;
      case NotificationType.payment:
        return WearColors.success;
      default:
        return WearColors.primary;
    }
  }

  Color get priorityColorWear {
    switch (priority) {
      case NotificationPriority.urgent:
        return WearColors.error;
      case NotificationPriority.high:
        return WearColors.warning;
      case NotificationPriority.medium:
        return WearColors.info;
      case NotificationPriority.low:
        return const Color(0xFF6B7280);
      case null:
        return WearColors.info;
    }
  }
}
