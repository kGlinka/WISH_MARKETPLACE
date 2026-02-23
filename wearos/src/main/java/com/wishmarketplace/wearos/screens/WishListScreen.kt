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
import com.wishmarketplace.wearos.models.WearWish
import com.wishmarketplace.wearos.theme.WearColors

/**
 * Wish List Screen - Display user's wishes
 *
 * Optimizations:
 * - Lazy loading with limited items (max 10)
 * - Compact card layout for small screens
 * - Color-coded priority indicators
 * - Progress bars for quick status check
 * - Swipe to dismiss to go back
 */
@Composable
fun WishListScreen(
    firebaseService: FirebaseService,
    onWishClick: (String) -> Unit
) {
    val userId = firebaseService.getCurrentUserId() ?: ""
    val wishes by firebaseService.getUserWishes(userId).collectAsState(initial = emptyList())
    val listState = rememberScalingLazyListState()

    Scaffold(
        timeText = {
            TimeText()
        },
        positionIndicator = {
            PositionIndicator(scalingLazyListState = listState)
        }
    ) {
        if (wishes.isEmpty()) {
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
                    imageVector = Icons.Filled.FavoriteBorder,
                    contentDescription = "No wishes",
                    tint = WearColors.OnSurfaceVariant,
                    modifier = Modifier.size(48.dp)
                )
                Spacer(modifier = Modifier.height(8.dp))
                Text(
                    text = "No active wishes",
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
                // Header
                item {
                    Text(
                        text = "My Wishes",
                        style = MaterialTheme.typography.title2,
                        color = WearColors.Primary,
                        textAlign = TextAlign.Center,
                        modifier = Modifier.padding(bottom = 12.dp)
                    )
                }

                // Wish items
                items(wishes) { wish ->
                    WishCard(
                        wish = wish,
                        onClick = { onWishClick(wish.id) }
                    )
                }
            }
        }
    }
}

/**
 * Wish Card - Compact representation of a wish
 *
 * Shows:
 * - Title
 * - Category
 * - Priority indicator
 * - Progress bar
 */
@Composable
fun WishCard(
    wish: WearWish,
    onClick: () -> Unit
) {
    Card(
        onClick = onClick,
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 4.dp),
        backgroundPainter = CardDefaults.cardBackgroundPainter(
            startBackgroundColor = WearColors.Surface,
            endBackgroundColor = WearColors.SurfaceVariant
        )
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(12.dp)
        ) {
            // Title and priority
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = wish.title,
                    style = MaterialTheme.typography.title3,
                    color = WearColors.OnSurface,
                    maxLines = 2,
                    overflow = TextOverflow.Ellipsis,
                    modifier = Modifier.weight(1f)
                )
                // Priority indicator dot
                Box(
                    modifier = Modifier
                        .size(8.dp)
                        .background(
                            color = wish.priorityColor,
                            shape = androidx.compose.foundation.shape.CircleShape
                        )
                )
            }

            Spacer(modifier = Modifier.height(4.dp))

            // Category
            Text(
                text = wish.categoryDisplay,
                style = MaterialTheme.typography.caption2,
                color = WearColors.OnSurfaceVariant,
                maxLines = 1,
                overflow = TextOverflow.Ellipsis
            )

            Spacer(modifier = Modifier.height(8.dp))

            // Progress bar
            ProgressBar(
                progress = wish.progress,
                modifier = Modifier.fillMaxWidth()
            )
        }
    }
}

/**
 * Progress Bar - Visual representation of wish progress
 */
@Composable
fun ProgressBar(
    progress: Int,
    modifier: Modifier = Modifier
) {
    Column(modifier = modifier) {
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Text(
                text = "Progress",
                style = MaterialTheme.typography.caption3,
                color = WearColors.OnSurfaceVariant
            )
            Text(
                text = "$progress%",
                style = MaterialTheme.typography.caption3,
                color = WearColors.OnSurface
            )
        }

        Spacer(modifier = Modifier.height(4.dp))

        Box(
            modifier = Modifier
                .fillMaxWidth()
                .height(4.dp)
                .background(
                    color = WearColors.SurfaceVariant,
                    shape = androidx.compose.foundation.shape.RoundedCornerShape(2.dp)
                )
        ) {
            Box(
                modifier = Modifier
                    .fillMaxWidth(progress / 100f)
                    .fillMaxHeight()
                    .background(
                        color = when {
                            progress >= 75 -> WearColors.Success
                            progress >= 50 -> WearColors.Info
                            progress >= 25 -> WearColors.Warning
                            else -> WearColors.OnSurfaceVariant
                        },
                        shape = androidx.compose.foundation.shape.RoundedCornerShape(2.dp)
                    )
            )
        }
    }
}
