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
import com.wishmarketplace.wearos.models.WearBid
import com.wishmarketplace.wearos.theme.WearColors

/**
 * My Bids Screen - User's active bidding status
 *
 * Features:
 * - Real-time bid status updates
 * - Color-coded bid states
 * - Quick access to listings
 * - Winning/outbid indicators
 */
@Composable
fun MyBidsScreen(
    firebaseService: FirebaseService,
    onBidClick: (String) -> Unit
) {
    val userId = firebaseService.getCurrentUserId() ?: ""
    val bids by firebaseService.getUserBids(userId).collectAsState(initial = emptyList())
    val listState = rememberScalingLazyListState()

    Scaffold(
        timeText = {
            TimeText()
        },
        positionIndicator = {
            PositionIndicator(scalingLazyListState = listState)
        }
    ) {
        if (bids.isEmpty()) {
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
                    imageVector = Icons.Filled.Gavel,
                    contentDescription = "No bids",
                    tint = WearColors.OnSurfaceVariant,
                    modifier = Modifier.size(48.dp)
                )
                Spacer(modifier = Modifier.height(8.dp))
                Text(
                    text = "No active bids",
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
                        text = "My Bids",
                        style = MaterialTheme.typography.title2,
                        color = WearColors.Primary,
                        textAlign = TextAlign.Center,
                        modifier = Modifier.padding(bottom = 12.dp)
                    )
                }

                // Bid items
                items(bids) { bid ->
                    BidCard(
                        bid = bid,
                        onClick = { onBidClick(bid.listingId) }
                    )
                }
            }
        }
    }
}

/**
 * Bid Card - Displays bid status and amount
 *
 * Visual indicators:
 * - Winning: Gold background
 * - Outbid: Red background
 * - Active: Blue background
 */
@Composable
fun BidCard(
    bid: WearBid,
    onClick: () -> Unit
) {
    Card(
        onClick = onClick,
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 4.dp),
        backgroundPainter = CardDefaults.cardBackgroundPainter(
            startBackgroundColor = bid.statusColor.copy(alpha = 0.2f),
            endBackgroundColor = WearColors.SurfaceVariant
        )
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(12.dp)
        ) {
            // Status badge
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = bid.status.uppercase(),
                    style = MaterialTheme.typography.caption1,
                    color = bid.statusColor,
                    modifier = Modifier
                        .background(
                            color = bid.statusColor.copy(alpha = 0.2f),
                            shape = androidx.compose.foundation.shape.RoundedCornerShape(4.dp)
                        )
                        .padding(horizontal = 6.dp, vertical = 2.dp)
                )

                // Status icon
                when (bid.status) {
                    "winning" -> Icon(
                        imageVector = Icons.Filled.TrendingUp,
                        contentDescription = "Winning",
                        tint = bid.statusColor,
                        modifier = Modifier.size(20.dp)
                    )
                    "won" -> Icon(
                        imageVector = Icons.Filled.CheckCircle,
                        contentDescription = "Won",
                        tint = bid.statusColor,
                        modifier = Modifier.size(20.dp)
                    )
                    "outbid" -> Icon(
                        imageVector = Icons.Filled.Warning,
                        contentDescription = "Outbid",
                        tint = bid.statusColor,
                        modifier = Modifier.size(20.dp)
                    )
                }
            }

            Spacer(modifier = Modifier.height(8.dp))

            // Bid amount
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Column {
                    Text(
                        text = "Your Bid",
                        style = MaterialTheme.typography.caption2,
                        color = WearColors.OnSurfaceVariant
                    )
                    Text(
                        text = bid.amountFormatted,
                        style = MaterialTheme.typography.title2,
                        color = WearColors.OnSurface
                    )
                }

                // Auto-bid indicator
                if (bid.isAutoBid) {
                    Icon(
                        imageVector = Icons.Filled.AutoMode,
                        contentDescription = "Auto Bid",
                        tint = WearColors.Info,
                        modifier = Modifier.size(24.dp)
                    )
                }
            }

            // Message if available
            if (bid.message != null) {
                Spacer(modifier = Modifier.height(4.dp))
                Text(
                    text = bid.message!!,
                    style = MaterialTheme.typography.caption3,
                    color = WearColors.OnSurfaceVariant,
                    maxLines = 2,
                    overflow = TextOverflow.Ellipsis
                )
            }
        }
    }
}
