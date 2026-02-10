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
import com.wishmarketplace.wearos.models.WearListing
import com.wishmarketplace.wearos.theme.WearColors

/**
 * Marketplace Screen - Browse active listings
 *
 * Design principles:
 * - Compact listing cards optimized for small screens
 * - Essential information only (title, price, time)
 * - Visual indicators for ending soon
 * - Efficient scrolling with scaling effects
 */
@Composable
fun MarketplaceScreen(
    firebaseService: FirebaseService,
    onListingClick: (String) -> Unit
) {
    val listings by firebaseService.getActiveListings().collectAsState(initial = emptyList())
    val listState = rememberScalingLazyListState()

    Scaffold(
        timeText = {
            TimeText()
        },
        positionIndicator = {
            PositionIndicator(scalingLazyListState = listState)
        }
    ) {
        if (listings.isEmpty()) {
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
                    imageVector = Icons.Filled.Store,
                    contentDescription = "No listings",
                    tint = WearColors.OnSurfaceVariant,
                    modifier = Modifier.size(48.dp)
                )
                Spacer(modifier = Modifier.height(8.dp))
                Text(
                    text = "No active listings",
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
                        text = "Marketplace",
                        style = MaterialTheme.typography.title2,
                        color = WearColors.Secondary,
                        textAlign = TextAlign.Center,
                        modifier = Modifier.padding(bottom = 12.dp)
                    )
                }

                // Listing items
                items(listings) { listing ->
                    ListingCard(
                        listing = listing,
                        onClick = { onListingClick(listing.id) }
                    )
                }
            }
        }
    }
}

/**
 * Listing Card - Compact marketplace listing view
 *
 * Shows:
 * - Title
 * - Current bid
 * - Time remaining
 * - Bid count
 * - Ending soon indicator
 */
@Composable
fun ListingCard(
    listing: WearListing,
    onClick: () -> Unit
) {
    Card(
        onClick = onClick,
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 4.dp),
        backgroundPainter = CardDefaults.cardBackgroundPainter(
            startBackgroundColor = if (listing.isEndingSoon) {
                WearColors.Error.copy(alpha = 0.2f)
            } else {
                WearColors.Surface
            },
            endBackgroundColor = WearColors.SurfaceVariant
        )
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(12.dp)
        ) {
            // Title
            Text(
                text = listing.title,
                style = MaterialTheme.typography.title3,
                color = WearColors.OnSurface,
                maxLines = 2,
                overflow = TextOverflow.Ellipsis
            )

            Spacer(modifier = Modifier.height(8.dp))

            // Current bid and time remaining
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Column {
                    Text(
                        text = "Current Bid",
                        style = MaterialTheme.typography.caption3,
                        color = WearColors.OnSurfaceVariant
                    )
                    Text(
                        text = listing.currentBidFormatted,
                        style = MaterialTheme.typography.title3,
                        color = WearColors.Success
                    )
                }

                Column(horizontalAlignment = Alignment.End) {
                    Text(
                        text = "Time Left",
                        style = MaterialTheme.typography.caption3,
                        color = WearColors.OnSurfaceVariant
                    )
                    Text(
                        text = listing.timeRemaining,
                        style = MaterialTheme.typography.title3,
                        color = if (listing.isEndingSoon) WearColors.Error else WearColors.Warning
                    )
                }
            }

            // Bid count
            if (listing.bidCount > 0) {
                Spacer(modifier = Modifier.height(4.dp))
                Text(
                    text = "${listing.bidCount} bid${if (listing.bidCount != 1) "s" else ""}",
                    style = MaterialTheme.typography.caption2,
                    color = WearColors.OnSurfaceVariant
                )
            }

            // Ending soon indicator
            if (listing.isEndingSoon) {
                Spacer(modifier = Modifier.height(4.dp))
                Row(
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Icon(
                        imageVector = Icons.Filled.Warning,
                        contentDescription = "Ending soon",
                        tint = WearColors.Error,
                        modifier = Modifier.size(12.dp)
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text(
                        text = "Ending Soon!",
                        style = MaterialTheme.typography.caption3,
                        color = WearColors.Error
                    )
                }
            }
        }
    }
}
