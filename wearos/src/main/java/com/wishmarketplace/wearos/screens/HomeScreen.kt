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
import androidx.wear.compose.foundation.lazy.rememberScalingLazyListState
import androidx.wear.compose.material.*
import com.wishmarketplace.wearos.data.FirebaseService
import com.wishmarketplace.wearos.theme.WearColors
import com.wishmarketplace.wearos.theme.WearSpacing

/**
 * Home Screen - Main hub for Wear OS app
 *
 * Design considerations:
 * - Centered content for round screens
 * - Large touch targets (min 48dp)
 * - Glanceable information at a glance
 * - Scaling lazy column for smooth scrolling
 * - Position indicator for scroll feedback
 */
@Composable
fun HomeScreen(
    firebaseService: FirebaseService,
    onNavigateToWishes: () -> Unit,
    onNavigateToMarketplace: () -> Unit,
    onNavigateToMyBids: () -> Unit,
    onNavigateToNotifications: () -> Unit,
    onNavigateToSettings: () -> Unit
) {
    val listState = rememberScalingLazyListState()
    val userId = firebaseService.getCurrentUserId() ?: ""

    // Collect notification count for badge
    var notificationCount by remember { mutableStateOf(0) }
    var activeBidsCount by remember { mutableStateOf(0) }

    LaunchedEffect(userId) {
        if (userId.isNotEmpty()) {
            // Listen to notifications
            firebaseService.getUserNotifications(userId).collect { notifications ->
                notificationCount = notifications.size
            }
        }
    }

    LaunchedEffect(userId) {
        if (userId.isNotEmpty()) {
            // Listen to active bids
            firebaseService.getUserBids(userId).collect { bids ->
                activeBidsCount = bids.count { it.status in listOf("active", "winning") }
            }
        }
    }

    Scaffold(
        timeText = {
            TimeText()
        },
        positionIndicator = {
            PositionIndicator(scalingLazyListState = listState)
        }
    ) {
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
            // App title
            item {
                Text(
                    text = "Wish Marketplace",
                    style = MaterialTheme.typography.title2,
                    color = WearColors.Primary,
                    textAlign = TextAlign.Center,
                    modifier = Modifier.padding(bottom = 16.dp)
                )
            }

            // My Wishes button
            item {
                Chip(
                    onClick = onNavigateToWishes,
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = 4.dp),
                    colors = ChipDefaults.primaryChipColors(
                        backgroundColor = WearColors.Primary
                    ),
                    label = {
                        Text(
                            text = "My Wishes",
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis
                        )
                    },
                    icon = {
                        Icon(
                            imageVector = Icons.Filled.Favorite,
                            contentDescription = "My Wishes"
                        )
                    }
                )
            }

            // Marketplace button
            item {
                Chip(
                    onClick = onNavigateToMarketplace,
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = 4.dp),
                    colors = ChipDefaults.secondaryChipColors(
                        backgroundColor = WearColors.Secondary
                    ),
                    label = {
                        Text(
                            text = "Marketplace",
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis
                        )
                    },
                    icon = {
                        Icon(
                            imageVector = Icons.Filled.Store,
                            contentDescription = "Marketplace"
                        )
                    }
                )
            }

            // My Bids button with badge
            item {
                Chip(
                    onClick = onNavigateToMyBids,
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = 4.dp),
                    colors = ChipDefaults.secondaryChipColors(),
                    label = {
                        Row(
                            verticalAlignment = Alignment.CenterVertically,
                            horizontalArrangement = Arrangement.SpaceBetween,
                            modifier = Modifier.fillMaxWidth()
                        ) {
                            Text(
                                text = "My Bids",
                                maxLines = 1,
                                overflow = TextOverflow.Ellipsis,
                                modifier = Modifier.weight(1f)
                            )
                            if (activeBidsCount > 0) {
                                Badge(
                                    modifier = Modifier.padding(start = 4.dp),
                                    backgroundColor = WearColors.ActiveBid
                                ) {
                                    Text(
                                        text = activeBidsCount.toString(),
                                        style = MaterialTheme.typography.caption3
                                    )
                                }
                            }
                        }
                    },
                    icon = {
                        Icon(
                            imageVector = Icons.Filled.Gavel,
                            contentDescription = "My Bids"
                        )
                    }
                )
            }

            // Notifications button with badge
            item {
                Chip(
                    onClick = onNavigateToNotifications,
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = 4.dp),
                    colors = ChipDefaults.secondaryChipColors(),
                    label = {
                        Row(
                            verticalAlignment = Alignment.CenterVertically,
                            horizontalArrangement = Arrangement.SpaceBetween,
                            modifier = Modifier.fillMaxWidth()
                        ) {
                            Text(
                                text = "Notifications",
                                maxLines = 1,
                                overflow = TextOverflow.Ellipsis,
                                modifier = Modifier.weight(1f)
                            )
                            if (notificationCount > 0) {
                                Badge(
                                    modifier = Modifier.padding(start = 4.dp),
                                    backgroundColor = WearColors.Error
                                ) {
                                    Text(
                                        text = notificationCount.toString(),
                                        style = MaterialTheme.typography.caption3
                                    )
                                }
                            }
                        }
                    },
                    icon = {
                        Icon(
                            imageVector = Icons.Filled.Notifications,
                            contentDescription = "Notifications"
                        )
                    }
                )
            }

            // Settings button
            item {
                Chip(
                    onClick = onNavigateToSettings,
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = 4.dp),
                    colors = ChipDefaults.secondaryChipColors(),
                    label = {
                        Text(
                            text = "Settings",
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis
                        )
                    },
                    icon = {
                        Icon(
                            imageVector = Icons.Filled.Settings,
                            contentDescription = "Settings"
                        )
                    }
                )
            }
        }
    }
}

/**
 * Badge component for displaying counts
 */
@Composable
fun Badge(
    modifier: Modifier = Modifier,
    backgroundColor: androidx.compose.ui.graphics.Color = WearColors.Error,
    content: @Composable () -> Unit
) {
    Box(
        modifier = modifier
            .background(
                color = backgroundColor,
                shape = androidx.compose.foundation.shape.CircleShape
            )
            .padding(horizontal = 6.dp, vertical = 2.dp),
        contentAlignment = Alignment.Center
    ) {
        content()
    }
}
