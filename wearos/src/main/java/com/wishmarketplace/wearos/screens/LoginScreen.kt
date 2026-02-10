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
import com.wishmarketplace.wearos.theme.WearColors
import kotlinx.coroutines.launch

/**
 * Login Screen - Simplified authentication for Wear OS
 *
 * Design notes:
 * - This is a simplified version for demonstration
 * - In production, use companion app authentication
 * - Wear OS login should leverage phone authentication
 * - Consider using OAuth or magic links
 */
@Composable
fun LoginScreen(
    firebaseService: FirebaseService,
    onLoginSuccess: () -> Unit
) {
    var isLoading by remember { mutableStateOf(false) }
    var errorMessage by remember { mutableStateOf<String?>(null) }

    val listState = rememberScalingLazyListState()
    val scope = rememberCoroutineScope()

    // Demo credentials - in production, use phone companion auth
    fun loginDemo() {
        scope.launch {
            isLoading = true
            errorMessage = null

            // For demo purposes - in production, authenticate via companion phone app
            firebaseService.signIn("demo@wishmarket.com", "demo123456")
                .onSuccess {
                    onLoginSuccess()
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
        if (isLoading) {
            Box(
                modifier = Modifier
                    .fillMaxSize()
                    .background(WearColors.Background),
                contentAlignment = Alignment.Center
            ) {
                CircularProgressIndicator(indicatorColor = WearColors.Primary)
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
                    start = 10.dp,
                    end = 10.dp
                ),
                verticalArrangement = Arrangement.Center
            ) {
                // App logo/title
                item {
                    Icon(
                        imageVector = Icons.Filled.Favorite,
                        contentDescription = "Wish Marketplace",
                        tint = WearColors.Primary,
                        modifier = Modifier
                            .size(64.dp)
                            .padding(bottom = 8.dp)
                    )
                }

                item {
                    Text(
                        text = "Wish\nMarketplace",
                        style = MaterialTheme.typography.title1,
                        color = WearColors.Primary,
                        textAlign = TextAlign.Center,
                        modifier = Modifier.padding(bottom = 16.dp)
                    )
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
                                style = MaterialTheme.typography.caption2,
                                color = WearColors.Error,
                                textAlign = TextAlign.Center,
                                modifier = Modifier.padding(12.dp)
                            )
                        }
                    }
                }

                // Info card
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
                            Icon(
                                imageVector = Icons.Filled.PhoneAndroid,
                                contentDescription = "Phone",
                                tint = WearColors.Info,
                                modifier = Modifier.size(32.dp)
                            )
                            Spacer(modifier = Modifier.height(8.dp))
                            Text(
                                text = "Login via phone app for best experience",
                                style = MaterialTheme.typography.caption2,
                                color = WearColors.OnSurface,
                                textAlign = TextAlign.Center
                            )
                        }
                    }
                }

                // Demo login button
                item {
                    Chip(
                        onClick = { loginDemo() },
                        modifier = Modifier
                            .fillMaxWidth()
                            .padding(vertical = 8.dp),
                        colors = ChipDefaults.primaryChipColors(
                            backgroundColor = WearColors.Primary
                        ),
                        label = {
                            Text(
                                text = "Demo Login",
                                style = MaterialTheme.typography.button,
                                textAlign = TextAlign.Center,
                                modifier = Modifier.fillMaxWidth()
                            )
                        },
                        icon = {
                            Icon(
                                imageVector = Icons.Filled.Login,
                                contentDescription = "Login"
                            )
                        }
                    )
                }

                // Help text
                item {
                    Text(
                        text = "For demo purposes only.\nUse phone app for real authentication.",
                        style = MaterialTheme.typography.caption3,
                        color = WearColors.OnSurfaceVariant,
                        textAlign = TextAlign.Center,
                        modifier = Modifier.padding(top = 8.dp)
                    )
                }
            }
        }
    }
}
