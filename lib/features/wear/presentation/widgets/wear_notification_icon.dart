import 'package:flutter/material.dart';
import '../../../../core/models/notification_model.dart';
import '../../core/wear_theme.dart';


/// Type-specific icon for notifications on Wear OS
class WearNotificationIcon extends StatelessWidget {
  final NotificationType type;

  const WearNotificationIcon({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    // Create a temporary notification to get icon/color from extension
    final iconData = _getIcon(type);
    final color = _getColor(type);

    return Icon(iconData, size: 24, color: color);
  }

  IconData _getIcon(NotificationType type) {
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

  Color _getColor(NotificationType type) {
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
}
