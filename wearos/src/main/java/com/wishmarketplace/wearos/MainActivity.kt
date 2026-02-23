package com.wishmarketplace.wearos

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.wear.compose.navigation.SwipeDismissableNavHost
import androidx.wear.compose.navigation.composable
import androidx.wear.compose.navigation.rememberSwipeDismissableNavController
import com.wishmarketplace.wearos.data.FirebaseService
import com.wishmarketplace.wearos.screens.*
import com.wishmarketplace.wearos.theme.WishWearTheme

/**
 * Main Activity for Wish Marketplace Wear OS app
 *
 * Implements swipe-to-dismiss navigation pattern as per Wear OS guidelines
 * Provides seamless navigation between all major screens
 */
class MainActivity : ComponentActivity() {

    private lateinit var firebaseService: FirebaseService

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Initialize Firebase service
        firebaseService = FirebaseService()

        setContent {
            WishWearTheme {
                WearApp(firebaseService)
            }
        }
    }
}

/**
 * Main Wear OS app composable
 *
 * Navigation structure:
 * - Home: Main hub with quick actions
 * - My Wishes: User's wish list
 * - Marketplace: Browse listings
 * - My Bids: Active bidding status
 * - Notifications: Unread notifications
 * - Settings: App settings
 */
@Composable
fun WearApp(firebaseService: FirebaseService) {
    val navController = rememberSwipeDismissableNavController()

    SwipeDismissableNavHost(
        navController = navController,
        startDestination = if (firebaseService.isLoggedIn()) "home" else "login",
        modifier = Modifier.fillMaxSize()
    ) {
        // Authentication
        composable("login") {
            LoginScreen(
                firebaseService = firebaseService,
                onLoginSuccess = {
                    navController.navigate("home") {
                        popUpTo("login") { inclusive = true }
                    }
                }
            )
        }

        // Home screen - main hub
        composable("home") {
            HomeScreen(
                firebaseService = firebaseService,
                onNavigateToWishes = { navController.navigate("wishes") },
                onNavigateToMarketplace = { navController.navigate("marketplace") },
                onNavigateToMyBids = { navController.navigate("my_bids") },
                onNavigateToNotifications = { navController.navigate("notifications") },
                onNavigateToSettings = { navController.navigate("settings") }
            )
        }

        // My Wishes screen
        composable("wishes") {
            WishListScreen(
                firebaseService = firebaseService,
                onWishClick = { wishId ->
                    navController.navigate("wish_detail/$wishId")
                }
            )
        }

        // Wish detail screen
        composable("wish_detail/{wishId}") { backStackEntry ->
            val wishId = backStackEntry.arguments?.getString("wishId") ?: ""
            WishDetailScreen(
                firebaseService = firebaseService,
                wishId = wishId
            )
        }

        // Marketplace listing screen
        composable("marketplace") {
            MarketplaceScreen(
                firebaseService = firebaseService,
                onListingClick = { listingId ->
                    navController.navigate("listing_detail/$listingId")
                }
            )
        }

        // Listing detail screen
        composable("listing_detail/{listingId}") { backStackEntry ->
            val listingId = backStackEntry.arguments?.getString("listingId") ?: ""
            ListingDetailScreen(
                firebaseService = firebaseService,
                listingId = listingId,
                onPlaceBid = { navController.navigate("place_bid/$listingId") }
            )
        }

        // Place bid screen
        composable("place_bid/{listingId}") { backStackEntry ->
            val listingId = backStackEntry.arguments?.getString("listingId") ?: ""
            PlaceBidScreen(
                firebaseService = firebaseService,
                listingId = listingId,
                onBidPlaced = {
                    navController.popBackStack()
                }
            )
        }

        // My Bids screen
        composable("my_bids") {
            MyBidsScreen(
                firebaseService = firebaseService,
                onBidClick = { listingId ->
                    navController.navigate("listing_detail/$listingId")
                }
            )
        }

        // Notifications screen
        composable("notifications") {
            NotificationsScreen(
                firebaseService = firebaseService,
                onNotificationClick = { notification ->
                    // Navigate based on notification type
                    notification.listingId?.let { listingId ->
                        navController.navigate("listing_detail/$listingId")
                    } ?: notification.bidId?.let { bidId ->
                        navController.navigate("my_bids")
                    }
                }
            )
        }

        // Settings screen
        composable("settings") {
            SettingsScreen(
                firebaseService = firebaseService,
                onSignOut = {
                    navController.navigate("login") {
                        popUpTo(0) { inclusive = true }
                    }
                }
            )
        }
    }
}
