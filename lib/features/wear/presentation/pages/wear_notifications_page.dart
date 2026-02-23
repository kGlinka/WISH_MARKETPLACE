import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/models/notification_model.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../core/wear_theme.dart';
import '../../core/wear_constants.dart';
import '../../core/wear_model_extensions.dart';
import '../../data/providers/wear_providers.dart';
import '../widgets/wear_scaffold.dart';
import '../widgets/wear_card.dart';
import '../widgets/wear_notification_icon.dart';
import '../widgets/wear_loading.dart';
import '../widgets/wear_empty_state.dart';
import '../widgets/wear_error_state.dart';

class WearNotificationsPage extends ConsumerWidget {
  final void Function(NotificationModel notification) onNotificationClick;

  const WearNotificationsPage({super.key, required this.onNotificationClick});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(wearNotificationsProvider);

    return WearScaffold(
      body: notificationsAsync.when(
        loading: () => const WearLoading(),
        error: (error, _) => WearErrorState(message: error.toString()),
        data: (notifications) {
          if (notifications.isEmpty) {
            return const WearEmptyState(
              icon: Icons.notifications,
              message: 'No new notifications',
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: WearConstants.listHorizontalPadding,
              vertical: WearConstants.listTopPadding,
            ),
            itemCount: notifications.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                    '${notifications.length} New',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: WearColors.primary),
                    textAlign: TextAlign.center,
                  ),
                );
              }

              final notification = notifications[index - 1];
              return _NotificationCard(
                notification: notification,
                onTap: () async {
                  // Mark as read
                  final firestoreService = ref.read(firestoreServiceProvider);
                  await firestoreService.updateDocument(
                    collection: 'notifications',
                    documentId: notification.id,
                    data: {'isRead': true},
                  );
                  onNotificationClick(notification);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const _NotificationCard({required this.notification, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return WearCard(
      onTap: onTap,
      backgroundColor: notification.priorityColorWear.withValues(alpha: 0.1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Type icon
          WearNotificationIcon(type: notification.type),
          const SizedBox(width: 8),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with priority indicator
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: WearColors.onSurface),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (notification.priority == NotificationPriority.urgent ||
                        notification.priority == NotificationPriority.high)
                      Container(
                        width: 8, height: 8,
                        decoration: BoxDecoration(
                          color: notification.priorityColorWear,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),

                // Body
                Text(
                  notification.body,
                  style: const TextStyle(fontSize: 14, color: WearColors.onSurfaceVariant),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
