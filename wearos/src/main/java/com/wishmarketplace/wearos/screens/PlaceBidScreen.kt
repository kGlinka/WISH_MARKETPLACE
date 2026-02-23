package com.wishmarketplace.wearos.screens

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
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
 * Place Bid Screen - Quick bidding interface
 *
 * Optimized for speed:
 * - Pre-calculated bid amounts
 * - Quick tap to bid
 * - Clear confirmation
 * - Minimal inputs required
 */
@Composable
fun PlaceBidScreen(
    firebaseService: FirebaseService,
    listingId: String,
    onBidPlaced: () -> Unit
) {
    var listing by remember { mutableStateOf<WearListing?>(null) }
    var isLoading by remember { mutableStateOf(true) }
    var isPlacingBid by remember { mutableStateOf(false) }
    var errorMessage by remember { mutableStateOf<String?>(null) }
    var successMessage by remember { mutableStateOf<String?>(null) }

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

    fun placeBid(amount: Int) {
        scope.launch {
            isPlacingBid = true
            errorMessage = null

            firebaseService.placeBid(listingId, amount)
                .onSuccess {
                    successMessage = "Bid placed successfully!"
                    kotlinx.coroutines.delay(1500)
                    onBidPlaced()
                }
                .onFailure {
                    errorMessage = it.message
                    isPlacingBid = false
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

            successMessage != null -> {
                Column(
                    modifier = Modifier
                        .fillMaxSize()
                        .background(WearColors.Background)
                        .padding(16.dp),
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.Center
                ) {
                    Icon(
                        imageVector = Icons.Filled.CheckCircle,
                        contentDescription = "Success",
                        tint = WearColors.Success,
                        modifier = Modifier.size(64.dp)
                    )
                    Spacer(modifier = Modifier.height(8.dp))
                    Text(
                        text = successMessage!!,
                        style = MaterialTheme.typography.body1,
                        color = WearColors.Success,
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
                            text = "Place Bid",
                            style = MaterialTheme.typography.title1,
                            color = WearColors.Primary,
                            textAlign = TextAlign.Center,
                            modifier = Modifier.padding(bottom = 8.dp)
                        )
                    }

                    // Current bid info
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
                                    .padding(12.dp),
                                horizontalAlignment = Alignment.CenterHorizontally
                            ) {
                                Text(
                                    text = "Current Bid",
                                    style = MaterialTheme.typography.caption2,
                                    color = WearColors.OnSurfaceVariant
                                )
                                Text(
                                    text = listing!!.currentBidFormatted,
                                    style = MaterialTheme.typography.title1,
                                    color = WearColors.OnSurface
                                )
                            }
                        }
                    }

                    // Error message
                    if (errorMessage != null) {
                        item {
                            Card(
                                onClick = {},
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(vertical = 4.dp),
                                enabled = false,
                                backgroundPainter = CardDefaults.cardBackgroundPainter(
                                    startBackgroundColor = WearColors.Error.copy(alpha = 0.2f)
                                )
                            ) {
                                Text(
                                    text = errorMessage!!,
                                    style = MaterialTheme.typography.body2,
                                    color = WearColors.Error,
                                    textAlign = TextAlign.Center,
                                    modifier = Modifier.padding(12.dp)
                                )
                            }
                        }
                    }

                    // Minimum bid option
                    item {
                        val minimumBid = listing!!.currentBid + listing!!.bidIncrement
                        BidOptionChip(
                            label = "Minimum Bid",
                            amount = minimumBid,
                            isEnabled = !isPlacingBid,
                            onClick = { placeBid(minimumBid) }
                        )
                    }

                    // Quick bid options (+$5, +$10, +$25)
                    item {
                        val quickBid5 = listing!!.currentBid + 500 // $5
                        BidOptionChip(
                            label = "+$5",
                            amount = quickBid5,
                            isEnabled = !isPlacingBid && quickBid5 > listing!!.currentBid,
                            onClick = { placeBid(quickBid5) }
                        )
                    }

                    item {
                        val quickBid10 = listing!!.currentBid + 1000 // $10
                        BidOptionChip(
                            label = "+$10",
                            amount = quickBid10,
                            isEnabled = !isPlacingBid && quickBid10 > listing!!.currentBid,
                            onClick = { placeBid(quickBid10) }
                        )
                    }

                    item {
                        val quickBid25 = listing!!.currentBid + 2500 // $25
                        BidOptionChip(
                            label = "+$25",
                            amount = quickBid25,
                            isEnabled = !isPlacingBid && quickBid25 > listing!!.currentBid,
                            onClick = { placeBid(quickBid25) }
                        )
                    }

                    // Buy Now option (if available)
                    if (listing!!.buyNowPrice != null) {
                        item {
                            Chip(
                                onClick = { placeBid(listing!!.buyNowPrice!!) },
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(vertical = 4.dp),
                                enabled = !isPlacingBid,
                                colors = ChipDefaults.primaryChipColors(
                                    backgroundColor = WearColors.Success
                                ),
                                label = {
                                    Column(
                                        horizontalAlignment = Alignment.CenterHorizontally,
                                        modifier = Modifier.fillMaxWidth()
                                    ) {
                                        Text(
                                            text = "Buy Now",
                                            style = MaterialTheme.typography.caption1
                                        )
                                        Text(
                                            text = listing!!.buyNowPriceFormatted ?: "",
                                            style = MaterialTheme.typography.title3
                                        )
                                    }
                                },
                                icon = {
                                    Icon(
                                        imageVector = Icons.Filled.ShoppingCart,
                                        contentDescription = "Buy Now"
                                    )
                                }
                            )
                        }
                    }

                    // Loading indicator
                    if (isPlacingBid) {
                        item {
                            CircularProgressIndicator(
                                modifier = Modifier.padding(16.dp),
                                indicatorColor = WearColors.Primary
                            )
                        }
                    }
                }
            }
        }
    }
}

/**
 * Bid Option Chip - Reusable bid amount selector
 */
@Composable
fun BidOptionChip(
    label: String,
    amount: Int,
    isEnabled: Boolean,
    onClick: () -> Unit
) {
    val amountFormatted = "$${amount / 100}.${(amount % 100).toString().padStart(2, '0')}"

    Chip(
        onClick = onClick,
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 4.dp),
        enabled = isEnabled,
        colors = ChipDefaults.secondaryChipColors(),
        label = {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = label,
                    style = MaterialTheme.typography.body2
                )
                Text(
                    text = amountFormatted,
                    style = MaterialTheme.typography.title3,
                    color = WearColors.Success
                )
            }
        },
        icon = {
            Icon(
                imageVector = Icons.Filled.Gavel,
                contentDescription = label
            )
        }
    )
}
