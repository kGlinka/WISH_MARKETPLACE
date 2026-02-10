package com.wishmarketplace.wearos.models

import com.google.firebase.Timestamp
import com.google.firebase.firestore.DocumentId

/**
 * Simplified Wish model for Wear OS
 * Contains only essential data for glanceable views
 */
data class WearWish(
    @DocumentId val id: String = "",
    val userId: String = "",
    val title: String = "",
    val description: String = "",
    val category: String = "",
    val priority: String = "medium",
    val status: String = "active",
    val progress: Int = 0,
    val targetDate: String? = null,
    val imageUrls: List<String> = emptyList(),
    val isPublic: Boolean = false,
    val createdAt: Timestamp = Timestamp.now()
) {
    val categoryDisplay: String
        get() = category.replace("(?<=[a-z])(?=[A-Z])".toRegex(), " ")
            .replaceFirstChar { it.uppercase() }

    val priorityColor: androidx.compose.ui.graphics.Color
        get() = when (priority) {
            "urgent" -> androidx.compose.ui.graphics.Color(0xFFEF4444)
            "high" -> androidx.compose.ui.graphics.Color(0xFFF59E0B)
            "medium" -> androidx.compose.ui.graphics.Color(0xFF3B82F6)
            else -> androidx.compose.ui.graphics.Color(0xFF6B7280)
        }

    val statusColor: androidx.compose.ui.graphics.Color
        get() = when (status) {
            "active" -> androidx.compose.ui.graphics.Color(0xFF10B981)
            "inProgress" -> androidx.compose.ui.graphics.Color(0xFF3B82F6)
            "completed" -> androidx.compose.ui.graphics.Color(0xFF6366F1)
            "deferred" -> androidx.compose.ui.graphics.Color(0xFF6B7280)
            else -> androidx.compose.ui.graphics.Color(0xFF6B7280)
        }
}

/**
 * Simplified Bid model for Wear OS
 * Optimized for quick bid status checks
 */
data class WearBid(
    @DocumentId val id: String = "",
    val listingId: String = "",
    val bidderId: String = "",
    val amount: Int = 0, // in cents
    val status: String = "active",
    val message: String? = null,
    val isAutoBid: Boolean = false,
    val createdAt: Timestamp = Timestamp.now()
) {
    val amountFormatted: String
        get() = "$${amount / 100}.${(amount % 100).toString().padStart(2, '0')}"

    val statusColor: androidx.compose.ui.graphics.Color
        get() = when (status) {
            "winning" -> androidx.compose.ui.graphics.Color(0xFFFBBF24)
            "won" -> androidx.compose.ui.graphics.Color(0xFF10B981)
            "outbid" -> androidx.compose.ui.graphics.Color(0xFFEF4444)
            "active" -> androidx.compose.ui.graphics.Color(0xFF3B82F6)
            else -> androidx.compose.ui.graphics.Color(0xFF6B7280)
        }
}

/**
 * Simplified Listing model for Wear OS
 * Contains essential marketplace listing data
 */
data class WearListing(
    @DocumentId val id: String = "",
    val sellerId: String = "",
    val title: String = "",
    val description: String = "",
    val category: String = "",
    val currentBid: Int = 0, // in cents
    val startingBid: Int = 0, // in cents
    val bidIncrement: Int = 100, // in cents
    val buyNowPrice: Int? = null,
    val bidCount: Int = 0,
    val status: String = "active",
    val imageUrls: List<String> = emptyList(),
    val endsAt: Timestamp? = null,
    val createdAt: Timestamp = Timestamp.now()
) {
    val currentBidFormatted: String
        get() = "$${currentBid / 100}.${(currentBid % 100).toString().padStart(2, '0')}"

    val startingBidFormatted: String
        get() = "$${startingBid / 100}.${(startingBid % 100).toString().padStart(2, '0')}"

    val buyNowPriceFormatted: String?
        get() = buyNowPrice?.let {
            "$${it / 100}.${(it % 100).toString().padStart(2, '0')}"
        }

    val timeRemaining: String
        get() {
            if (endsAt == null) return "No end date"
            val now = System.currentTimeMillis()
            val end = endsAt.toDate().time
            val diff = end - now

            return when {
                diff <= 0 -> "Ended"
                diff < 3600000 -> "${diff / 60000}m"
                diff < 86400000 -> "${diff / 3600000}h"
                else -> "${diff / 86400000}d"
            }
        }

    val isEndingSoon: Boolean
        get() {
            if (endsAt == null) return false
            val diff = endsAt.toDate().time - System.currentTimeMillis()
            return diff in 1..3600000 // Less than 1 hour
        }
}

/**
 * Notification model for Wear OS
 * Optimized for quick glances
 */
data class WearNotification(
    @DocumentId val id: String = "",
    val userId: String = "",
    val type: String = "",
    val title: String = "",
    val body: String = "",
    val imageUrl: String? = null,
    val priority: String = "medium",
    val isRead: Boolean = false,
    val listingId: String? = null,
    val bidId: String? = null,
    val createdAt: Timestamp = Timestamp.now()
) {
    val typeIcon: String
        get() = when (type) {
            "bidPlaced" -> "gavel"
            "bidOutbid" -> "warning"
            "bidWon" -> "celebration"
            "bidExpired" -> "schedule"
            "message" -> "message"
            "payment" -> "payment"
            else -> "notifications"
        }

    val priorityColor: androidx.compose.ui.graphics.Color
        get() = when (priority) {
            "urgent" -> androidx.compose.ui.graphics.Color(0xFFEF4444)
            "high" -> androidx.compose.ui.graphics.Color(0xFFF59E0B)
            "medium" -> androidx.compose.ui.graphics.Color(0xFF3B82F6)
            else -> androidx.compose.ui.graphics.Color(0xFF6B7280)
        }
}

/**
 * Quick action model for Wear OS tiles
 */
data class QuickAction(
    val id: String,
    val title: String,
    val subtitle: String,
    val icon: String,
    val action: () -> Unit
)

/**
 * User session data for Wear OS
 */
data class WearUserSession(
    val userId: String = "",
    val username: String = "",
    val email: String = "",
    val avatarUrl: String? = null,
    val isLoggedIn: Boolean = false
)
