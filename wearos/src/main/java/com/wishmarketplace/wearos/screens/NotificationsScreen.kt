package com.wishmarketplace.wearos.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.*
import androidx.wear.compose.foundation.lazy.ScalingLazyColumn
import androidx.wear.compose.foundation.lazy.items
import androidx.wear.compose.foundation.lazy.rememberScalingLazyListState
import androidx.wear.compose.material.*
import com.wishmarketplace.wearos.data.FirebaseService
import com.wishmarketplace.wearos.models.WearNotification
import com.wishmarketplace.wearos.theme.WearColors
import kotlinx.coroutines.launch

/**
 * Notifications Screen - Display unread notifications
 *
 * Features:
 * - Priority-based sorting
 * - Swipe to mark as read
 * - Tap to navigate to related content
 * - Color-coded by type and priority
 */
@Composable
fun NotificationsScreen(
    firebaseService: FirebaseService,
    onNotificationClick: (WearNotification) -> Unit
) {
    val userId = firebaseService.getCurrentUserId() ?: ""
    val notifications by firebaseService.getUserNotifications(userId)
        .collectAsState(initial = emptyList())
    val listState = rememberScalingLazyListState()
    val scope = rememberCoroutineScope()

    Scaffold(
        timeText = {
            TimeText()
        },
        positionIndicator = {
            PositionIndicator(scalingLazyListState = listState)
        }
    ) {
        if (notifications.isEmpty()) {
            // Empty state
            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .background(WearColors.Background)
                    .padding(16.dp),
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center
            ) {
                Icon(
                    imageVector = Icons.Filled.Notifications,
                    contentDescription = "No notifications",
                    tint = WearColors.OnSurfaceVariant,
                    modifier = Modifier.size(48.dp)
                )
                Spacer(modifier = Modifier.height(8.dp))
                Text(
                    text = "No new notifications",
                    style = MaterialTheme.typography.body2,
                    color = WearColors.OnSurfaceVariant,
                    textAlign = TextAlign.Center
                )
            }
        } else {
            ScalingLazyColumn(
                modifier = Modifier
                    .fillMaxSize()
                    .background(WearColors.Background),
                state = listState,
                horizontalAlignment = Alignment.CenterHorizontally,
                contentPadding = PaddingValues(
                    top = 32.dp,
                    bottom = 32.dp,
                    start = 8.dp,
                    end = 8.dp
                )
            ) {
                // Header with count
                item {
                    Text(
                        text = "${notifications.size} New",
                        style = MaterialTheme.typography.title2,
                        color = WearColors.Primary,
                        textAlign = TextAlign.Center,
                        modifier = Modifier.padding(bottom = 12.dp)
                    )
                }

                // Notification items
                items(notifications) { notification ->
                    NotificationCard(
                        notification = notification,
                        onClick = {
                            // Mark as read and navigate
                            scope.launch {
                                firebaseService.markNotificationAsRead(notification.id)
                                onNotificationClick(notification)
                            }
                        }
                    )
                }
            }
        }
    }
}

/**
 * Notification Card - Compact notification display
 *
 * Shows:
 * - Type icon
 * - Title and body
 * - Priority indicator
 * - Time indicator (implicit via ordering)
 */
@Composable
fun NotificationCard(
    notification: WearNotification,
    onClick: () -> Unit
) {
    Card(
        onClick = onClick,
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 4.dp),
        backgroundPainter = CardDefaults.cardBackgroundPainter(
            startBackgroundColor = notification.priorityColor.copy(alpha = 0.1f),
            endBackgroundColor = WearColors.SurfaceVariant
        )
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(12.dp),
            verticalAlignment = Alignment.Top
        ) {
            // Type icon
            NotificationIcon(type = notification.type)

            Spacer(modifier = Modifier.width(8.dp))

            // Content
            Column(modifier = Modifier.weight(1f)) {
                // Title with priority indicator
                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = notification.title,
                        style = MaterialTheme.typography.title3,
                        color = WearColors.OnSurface,
                        maxLines = 1,
                        overflow = TextOverflow.Ellipsis,
                        modifier = Modifier.weight(1f)
                    )
                    if (notification.priority == "urgent" || notification.priority == "high") {
                        Box(
                            modifier = Modifier
                                .size(8.dp)
                                .background(
                                    color = notification.priorityColor,
                                    shape = androidx.compose.foundation.shape.CircleShape
                                )
                        )
                    }
                }

                Spacer(modifier = Modifier.height(4.dp))

                // Body
                Text(
                    text = notification.body,
                    style = MaterialTheme.typography.body2,
                    color = WearColors.OnSurfaceVariant,
                    maxLines = 2,
                    overflow = TextOverflow.Ellipsis
                )
            }
        }
    }
}

/**
 * Notification Icon - Type-specific icon display
 */
@Composable
fun NotificationIcon(type: String) {
    val (icon, color) = when (type) {
        "bidPlaced" -> Icons.Filled.Gavel to WearColors.Info
        "bidOutbid" -> Icons.Filled.Warning to WearColors.Warning
        "bidWon" -> Icons.Filled.EmojiEvents to WearColors.WinningGold
        "bidExpired" -> Icons.Filled.Schedule to WearColors.OnSurfaceVariant
        "message" -> Icons.Filled.Message to WearColors.Info
        "payment" -> Icons.Filled.Payment to WearColors.Success
        else -> Icons.Filled.Notifications to WearColors.Primary
    }

    Icon(
        imageVector = icon,
        contentDescription = type,
        tint = color,
        modifier = Modifier.size(24.dp)
    )
}
