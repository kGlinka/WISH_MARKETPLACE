package com.wishmarketplace.wearos.theme

import androidx.compose.runtime.Composable
import androidx.compose.ui.graphics.Color
import androidx.wear.compose.material.MaterialTheme

/**
 * Wear OS color palette for Wish Marketplace
 * Optimized for AMOLED displays with true blacks for battery efficiency
 */
object WearColors {
    // Primary brand colors
    val Primary = Color(0xFF6366F1) // Indigo
    val PrimaryVariant = Color(0xFF4F46E5)
    val OnPrimary = Color(0xFFFFFFFF)

    // Secondary colors
    val Secondary = Color(0xFF10B981) // Green for success/winning bids
    val SecondaryVariant = Color(0xFF059669)
    val OnSecondary = Color(0xFFFFFFFF)

    // Background colors - true black for AMOLED
    val Background = Color(0xFF000000)
    val Surface = Color(0xFF1A1A1A)
    val SurfaceVariant = Color(0xFF2D2D2D)

    // Content colors
    val OnBackground = Color(0xFFE5E5E5)
    val OnSurface = Color(0xFFE5E5E5)
    val OnSurfaceVariant = Color(0xFFB3B3B3)

    // Status colors
    val Error = Color(0xFFEF4444)
    val Warning = Color(0xFFF59E0B)
    val Success = Color(0xFF10B981)
    val Info = Color(0xFF3B82F6)

    // Bidding specific colors
    val ActiveBid = Color(0xFF10B981)
    val OutbidRed = Color(0xFFEF4444)
    val WinningGold = Color(0xFFFBBF24)
}

/**
 * Typography scale optimized for Wear OS
 * All sizes account for small screen readability at arm's length
 */
object WearTypography {
    // Minimum font size should be 14sp for readability on small screens
    const val DisplayLarge = 24f
    const val DisplayMedium = 20f
    const val DisplaySmall = 18f

    const val TitleLarge = 18f
    const val TitleMedium = 16f
    const val TitleSmall = 14f

    const val BodyLarge = 16f
    const val BodyMedium = 14f
    const val BodySmall = 12f

    const val LabelLarge = 14f
    const val LabelMedium = 12f
    const val LabelSmall = 10f
}

/**
 * Spacing scale for Wear OS
 * Optimized for circular and square watch faces
 */
object WearSpacing {
    const val ExtraSmall = 4f
    const val Small = 8f
    const val Medium = 12f
    const val Large = 16f
    const val ExtraLarge = 24f
    const val ExtraExtraLarge = 32f

    // Minimum touch target size as per Wear OS guidelines
    const val MinTouchTarget = 48f
}

/**
 * Wear OS Material Theme wrapper
 * Applies consistent theming across all screens
 */
@Composable
fun WishWearTheme(
    content: @Composable () -> Unit
) {
    MaterialTheme(
        colors = androidx.wear.compose.material.Colors(
            primary = WearColors.Primary,
            primaryVariant = WearColors.PrimaryVariant,
            secondary = WearColors.Secondary,
            secondaryVariant = WearColors.SecondaryVariant,
            background = WearColors.Background,
            surface = WearColors.Surface,
            error = WearColors.Error,
            onPrimary = WearColors.OnPrimary,
            onSecondary = WearColors.OnSecondary,
            onBackground = WearColors.OnBackground,
            onSurface = WearColors.OnSurface,
            onSurfaceVariant = WearColors.OnSurfaceVariant,
            onError = Color.White
        ),
        content = content
    )
}
