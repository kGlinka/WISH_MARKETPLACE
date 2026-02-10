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
import com.wishmarketplace.wearos.models.WearWish
import com.wishmarketplace.wearos.theme.WearColors
import kotlinx.coroutines.launch

/**
 * Wish Detail Screen - Detailed view with progress tracking
 *
 * Features:
 * - Full wish details
 * - Interactive progress adjustment
 * - Quick status updates
 * - Minimal interaction required
 */
@Composable
fun WishDetailScreen(
    firebaseService: FirebaseService,
    wishId: String
) {
    var wish by remember { mutableStateOf<WearWish?>(null) }
    var isLoading by remember { mutableStateOf(true) }
    var errorMessage by remember { mutableStateOf<String?>(null) }
    var isUpdating by remember { mutableStateOf(false) }

    val listState = rememberScalingLazyListState()
    val scope = rememberCoroutineScope()

    LaunchedEffect(wishId) {
        scope.launch {
            firebaseService.getWish(wishId)
                .onSuccess {
                    wish = it
                    isLoading = false
                }
                .onFailure {
                    errorMessage = it.message
                    isLoading = false
                }
        }
    }

    fun updateProgress(newProgress: Int) {
        scope.launch {
            isUpdating = true
            firebaseService.updateWishProgress(wishId, newProgress)
                .onSuccess {
                    wish = wish?.copy(progress = newProgress)
                    isUpdating = false
                }
                .onFailure {
                    errorMessage = it.message
                    isUpdating = false
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
        when {
            isLoading -> {
                Box(
                    modifier = Modifier
                        .fillMaxSize()
                        .background(WearColors.Background),
                    contentAlignment = Alignment.Center
                ) {
                    CircularProgressIndicator(indicatorColor = WearColors.Primary)
                }
            }

            errorMessage != null && wish == null -> {
                Column(
                    modifier = Modifier
                        .fillMaxSize()
                        .background(WearColors.Background)
                        .padding(16.dp),
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.Center
                ) {
                    Icon(
                        imageVector = Icons.Filled.Error,
                        contentDescription = "Error",
                        tint = WearColors.Error,
                        modifier = Modifier.size(48.dp)
                    )
                    Spacer(modifier = Modifier.height(8.dp))
                    Text(
                        text = errorMessage ?: "Unknown error",
                        style = MaterialTheme.typography.body2,
                        color = WearColors.Error,
                        textAlign = TextAlign.Center
                    )
                }
            }

            wish != null -> {
                ScalingLazyColumn(
                    modifier = Modifier
                        .fillMaxSize()
                        .background(WearColors.Background),
                    state = listState,
                    horizontalAlignment = Alignment.CenterHorizontally,
                    contentPadding = PaddingValues(
                        top = 32.dp,
                        bottom = 32.dp,
                        start = 10.dp,
                        end = 10.dp
                    )
                ) {
                    // Title
                    item {
                        Text(
                            text = wish!!.title,
                            style = MaterialTheme.typography.title2,
                            color = WearColors.OnSurface,
                            textAlign = TextAlign.Center,
                            maxLines = 3,
                            overflow = TextOverflow.Ellipsis,
                            modifier = Modifier.padding(bottom = 8.dp)
                        )
                    }

                    // Status and Priority card
                    item {
                        Card(
                            onClick = {},
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(vertical = 4.dp),
                            enabled = false
                        ) {
                            Row(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(12.dp),
                                horizontalArrangement = Arrangement.SpaceBetween
                            ) {
                                Column {
                                    Text(
                                        text = "Status",
                                        style = MaterialTheme.typography.caption2,
                                        color = WearColors.OnSurfaceVariant
                                    )
                                    Text(
                                        text = wish!!.status.replaceFirstChar { it.uppercase() },
                                        style = MaterialTheme.typography.body1,
                                        color = wish!!.statusColor
                                    )
                                }
                                Column(horizontalAlignment = Alignment.End) {
                                    Text(
                                        text = "Priority",
                                        style = MaterialTheme.typography.caption2,
                                        color = WearColors.OnSurfaceVariant
                                    )
                                    Row(verticalAlignment = Alignment.CenterVertically) {
                                        Text(
                                            text = wish!!.priority.replaceFirstChar { it.uppercase() },
                                            style = MaterialTheme.typography.body1,
                                            color = wish!!.priorityColor
                                        )
                                        Spacer(modifier = Modifier.width(4.dp))
                                        Box(
                                            modifier = Modifier
                                                .size(8.dp)
                                                .background(
                                                    color = wish!!.priorityColor,
                                                    shape = androidx.compose.foundation.shape.CircleShape
                                                )
                                        )
                                    }
                                }
                            }
                        }
                    }

                    // Description
                    item {
                        Card(
                            onClick = {},
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(vertical = 4.dp),
                            enabled = false
                        ) {
                            Column(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(12.dp)
                            ) {
                                Text(
                                    text = "Description",
                                    style = MaterialTheme.typography.caption1,
                                    color = WearColors.OnSurfaceVariant,
                                    modifier = Modifier.padding(bottom = 4.dp)
                                )
                                Text(
                                    text = wish!!.description,
                                    style = MaterialTheme.typography.body2,
                                    color = WearColors.OnSurface,
                                    maxLines = 6,
                                    overflow = TextOverflow.Ellipsis
                                )
                            }
                        }
                    }

                    // Progress section
                    item {
                        Card(
                            onClick = {},
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(vertical = 4.dp),
                            enabled = false,
                            backgroundPainter = CardDefaults.cardBackgroundPainter(
                                startBackgroundColor = WearColors.Primary.copy(alpha = 0.1f)
                            )
                        ) {
                            Column(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(12.dp)
                            ) {
                                Text(
                                    text = "Progress",
                                    style = MaterialTheme.typography.caption1,
                                    color = WearColors.OnSurfaceVariant,
                                    modifier = Modifier.padding(bottom = 8.dp)
                                )
                                ProgressBar(
                                    progress = wish!!.progress,
                                    modifier = Modifier.fillMaxWidth()
                                )
                            }
                        }
                    }

                    // Progress adjustment buttons
                    item {
                        Text(
                            text = "Update Progress",
                            style = MaterialTheme.typography.caption1,
                            color = WearColors.OnSurfaceVariant,
                            modifier = Modifier.padding(vertical = 8.dp)
                        )
                    }

                    // +25% button
                    item {
                        Chip(
                            onClick = {
                                val newProgress = (wish!!.progress + 25).coerceIn(0, 100)
                                updateProgress(newProgress)
                            },
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(vertical = 2.dp),
                            enabled = !isUpdating && wish!!.progress < 100,
                            colors = ChipDefaults.secondaryChipColors(),
                            label = {
                                Text("+25%", modifier = Modifier.fillMaxWidth(), textAlign = TextAlign.Center)
                            }
                        )
                    }

                    // +10% button
                    item {
                        Chip(
                            onClick = {
                                val newProgress = (wish!!.progress + 10).coerceIn(0, 100)
                                updateProgress(newProgress)
                            },
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(vertical = 2.dp),
                            enabled = !isUpdating && wish!!.progress < 100,
                            colors = ChipDefaults.secondaryChipColors(),
                            label = {
                                Text("+10%", modifier = Modifier.fillMaxWidth(), textAlign = TextAlign.Center)
                            }
                        )
                    }

                    // Mark complete button
                    if (wish!!.progress < 100) {
                        item {
                            Chip(
                                onClick = { updateProgress(100) },
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(vertical = 4.dp),
                                enabled = !isUpdating,
                                colors = ChipDefaults.primaryChipColors(
                                    backgroundColor = WearColors.Success
                                ),
                                label = {
                                    Text(
                                        "Mark Complete",
                                        modifier = Modifier.fillMaxWidth(),
                                        textAlign = TextAlign.Center
                                    )
                                },
                                icon = {
                                    Icon(
                                        imageVector = Icons.Filled.CheckCircle,
                                        contentDescription = "Complete"
                                    )
                                }
                            )
                        }
                    }

                    // Category and target date
                    item {
                        Card(
                            onClick = {},
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(vertical = 4.dp),
                            enabled = false
                        ) {
                            Column(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(12.dp)
                            ) {
                                Row(
                                    modifier = Modifier.fillMaxWidth(),
                                    horizontalArrangement = Arrangement.SpaceBetween
                                ) {
                                    Text(
                                        text = "Category",
                                        style = MaterialTheme.typography.caption2,
                                        color = WearColors.OnSurfaceVariant
                                    )
                                    Text(
                                        text = wish!!.categoryDisplay,
                                        style = MaterialTheme.typography.body2,
                                        color = WearColors.OnSurface
                                    )
                                }
                                if (wish!!.targetDate != null) {
                                    Spacer(modifier = Modifier.height(4.dp))
                                    Row(
                                        modifier = Modifier.fillMaxWidth(),
                                        horizontalArrangement = Arrangement.SpaceBetween
                                    ) {
                                        Text(
                                            text = "Target Date",
                                            style = MaterialTheme.typography.caption2,
                                            color = WearColors.OnSurfaceVariant
                                        )
                                        Text(
                                            text = wish!!.targetDate!!,
                                            style = MaterialTheme.typography.body2,
                                            color = WearColors.OnSurface
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
