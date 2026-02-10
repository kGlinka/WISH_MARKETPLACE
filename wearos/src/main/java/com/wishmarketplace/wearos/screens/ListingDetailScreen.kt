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
import com.wishmarketplace.wearos.models.WearListing
import com.wishmarketplace.wearos.theme.WearColors
import kotlinx.coroutines.launch

/**
 * Listing Detail Screen - Detailed view of marketplace listing
 *
 * Optimized for quick decision-making:
 * - Essential information at top
 * - Large, tappable bid button
 * - Clear visual hierarchy
 * - Minimal scrolling required
 */
@Composable
fun ListingDetailScreen(
    firebaseService: FirebaseService,
    listingId: String,
    onPlaceBid: () -> Unit
) {
    var listing by remember { mutableStateOf<WearListing?>(null) }
    var isLoading by remember { mutableStateOf(true) }
    var errorMessage by remember { mutableStateOf<String?>(null) }

    val listState = rememberScalingLazyListState()
    val scope = rememberCoroutineScope()

    LaunchedEffect(listingId) {
        scope.launch {
            firebaseService.getListing(listingId)
                .onSuccess {
                    listing = it
                    isLoading = false
                }
                .onFailure {
                    errorMessage = it.message
                    isLoading = false
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
                    CircularProgressIndicator(
                        indicatorColor = WearColors.Primary
                    )
                }
            }

            errorMessage != null -> {
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

            listing != null -> {
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
                            text = listing!!.title,
                            style = MaterialTheme.typography.title2,
                            color = WearColors.OnSurface,
                            textAlign = TextAlign.Center,
                            maxLines = 3,
                            overflow = TextOverflow.Ellipsis,
                            modifier = Modifier.padding(bottom = 8.dp)
                        )
                    }

                    // Current bid card
                    item {
                        Card(
                            onClick = {},
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(vertical = 4.dp),
                            enabled = false,
                            backgroundPainter = CardDefaults.cardBackgroundPainter(
                                startBackgroundColor = WearColors.Success.copy(alpha = 0.2f),
                                endBackgroundColor = WearColors.Surface
                            )
                        ) {
                            Column(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(12.dp),
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                Text(
                                    text = "Current Bid",
                                    style = MaterialTheme.typography.caption1,
                                    color = WearColors.OnSurfaceVariant
                                )
                                Text(
                                    text = listing!!.currentBidFormatted,
                                    style = MaterialTheme.typography.display1,
                                    color = WearColors.Success
                                )
                            }
                        }
                    }

                    // Time remaining card
                    item {
                        Card(
                            onClick = {},
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(vertical = 4.dp),
                            enabled = false,
                            backgroundPainter = CardDefaults.cardBackgroundPainter(
                                startBackgroundColor = if (listing!!.isEndingSoon) {
                                    WearColors.Error.copy(alpha = 0.2f)
                                } else {
                                    WearColors.Surface
                                },
                                endBackgroundColor = WearColors.SurfaceVariant
                            )
                        ) {
                            Row(
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(12.dp),
                                horizontalArrangement = Arrangement.SpaceBetween,
                                verticalAlignment = Alignment.CenterVertically
                            ) {
                                Column {
                                    Text(
                                        text = "Time Left",
                                        style = MaterialTheme.typography.caption2,
                                        color = WearColors.OnSurfaceVariant
                                    )
                                    Text(
                                        text = listing!!.timeRemaining,
                                        style = MaterialTheme.typography.title1,
                                        color = if (listing!!.isEndingSoon) {
                                            WearColors.Error
                                        } else {
                                            WearColors.Warning
                                        }
                                    )
                                }
                                Column(horizontalAlignment = Alignment.End) {
                                    Text(
                                        text = "Bids",
                                        style = MaterialTheme.typography.caption2,
                                        color = WearColors.OnSurfaceVariant
                                    )
                                    Text(
                                        text = listing!!.bidCount.toString(),
                                        style = MaterialTheme.typography.title1,
                                        color = WearColors.OnSurface
                                    )
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
                                    text = listing!!.description,
                                    style = MaterialTheme.typography.body2,
                                    color = WearColors.OnSurface,
                                    maxLines = 5,
                                    overflow = TextOverflow.Ellipsis
                                )
                            }
                        }
                    }

                    // Bid details
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
                                        text = "Starting Bid",
                                        style = MaterialTheme.typography.caption2,
                                        color = WearColors.OnSurfaceVariant
                                    )
                                    Text(
                                        text = listing!!.startingBidFormatted,
                                        style = MaterialTheme.typography.body2,
                                        color = WearColors.OnSurface
                                    )
                                }
                                Spacer(modifier = Modifier.height(4.dp))
                                Row(
                                    modifier = Modifier.fillMaxWidth(),
                                    horizontalArrangement = Arrangement.SpaceBetween
                                ) {
                                    Text(
                                        text = "Bid Increment",
                                        style = MaterialTheme.typography.caption2,
                                        color = WearColors.OnSurfaceVariant
                                    )
                                    Text(
                                        text = "$${listing!!.bidIncrement / 100}",
                                        style = MaterialTheme.typography.body2,
                                        color = WearColors.OnSurface
                                    )
                                }
                                if (listing!!.buyNowPrice != null) {
                                    Spacer(modifier = Modifier.height(4.dp))
                                    Row(
                                        modifier = Modifier.fillMaxWidth(),
                                        horizontalArrangement = Arrangement.SpaceBetween
                                    ) {
                                        Text(
                                            text = "Buy Now",
                                            style = MaterialTheme.typography.caption2,
                                            color = WearColors.OnSurfaceVariant
                                        )
                                        Text(
                                            text = listing!!.buyNowPriceFormatted ?: "",
                                            style = MaterialTheme.typography.body2,
                                            color = WearColors.Success
                                        )
                                    }
                                }
                            }
                        }
                    }

                    // Place bid button - large touch target
                    item {
                        Chip(
                            onClick = onPlaceBid,
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(vertical = 8.dp),
                            colors = ChipDefaults.primaryChipColors(
                                backgroundColor = WearColors.Primary
                            ),
                            label = {
                                Text(
                                    text = "Place Bid",
                                    style = MaterialTheme.typography.button,
                                    textAlign = TextAlign.Center,
                                    modifier = Modifier.fillMaxWidth()
                                )
                            },
                            icon = {
                                Icon(
                                    imageVector = Icons.Filled.Gavel,
                                    contentDescription = "Place Bid"
                                )
                            }
                        )
                    }
                }
            }
        }
    }
}
