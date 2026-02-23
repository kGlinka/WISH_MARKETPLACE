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
import androidx.wear.compose.material.dialog.Alert
import com.wishmarketplace.wearos.data.FirebaseService
import com.wishmarketplace.wearos.theme.WearColors

/**
 * Settings Screen - App settings and preferences
 *
 * Features:
 * - User info display
 * - Notification preferences (placeholder)
 * - Sign out
 * - App version info
 */
@Composable
fun SettingsScreen(
    firebaseService: FirebaseService,
    onSignOut: () -> Unit
) {
    val user = firebaseService.getCurrentUser()
    val listState = rememberScalingLazyListState()
    var showSignOutDialog by remember { mutableStateOf(false) }

    // Sign out confirmation dialog
    if (showSignOutDialog) {
        Alert(
            title = {
                Text(
                    text = "Sign Out?",
                    textAlign = TextAlign.Center,
                    color = WearColors.OnSurface
                )
            },
            negativeButton = {
                Button(
                    onClick = { showSignOutDialog = false },
                    colors = ButtonDefaults.secondaryButtonColors()
                ) {
                    Icon(
                        imageVector = Icons.Filled.Close,
                        contentDescription = "Cancel"
                    )
                }
            },
            positiveButton = {
                Button(
                    onClick = {
                        firebaseService.signOut()
                        showSignOutDialog = false
                        onSignOut()
                    },
                    colors = ButtonDefaults.primaryButtonColors()
                ) {
                    Icon(
                        imageVector = Icons.Filled.Check,
                        contentDescription = "Confirm"
                    )
                }
            },
            contentPadding = PaddingValues(start = 10.dp, end = 10.dp, top = 24.dp, bottom = 32.dp),
        )
    }

    Scaffold(
        timeText = {
            TimeText()
        },
        positionIndicator = {
            PositionIndicator(scalingLazyListState = listState)
        }
    ) {
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
                    text = "Settings",
                    style = MaterialTheme.typography.title2,
                    color = WearColors.Primary,
                    textAlign = TextAlign.Center,
                    modifier = Modifier.padding(bottom = 12.dp)
                )
            }

            // User info card
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
                            imageVector = Icons.Filled.AccountCircle,
                            contentDescription = "Account",
                            tint = WearColors.Primary,
                            modifier = Modifier.size(48.dp)
                        )
                        Spacer(modifier = Modifier.height(8.dp))
                        Text(
                            text = user?.email ?: "Not logged in",
                            style = MaterialTheme.typography.body2,
                            color = WearColors.OnSurface,
                            textAlign = TextAlign.Center,
                            maxLines = 2,
                            overflow = TextOverflow.Ellipsis
                        )
                    }
                }
            }

            // Notifications preference
            item {
                Chip(
                    onClick = { /* TODO: Implement notification preferences */ },
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = 4.dp),
                    colors = ChipDefaults.secondaryChipColors(),
                    label = {
                        Text(
                            text = "Notifications",
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis
                        )
                    },
                    icon = {
                        Icon(
                            imageVector = Icons.Filled.Notifications,
                            contentDescription = "Notifications"
                        )
                    }
                )
            }

            // Auto-bid settings
            item {
                Chip(
                    onClick = { /* TODO: Implement auto-bid settings */ },
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = 4.dp),
                    colors = ChipDefaults.secondaryChipColors(),
                    label = {
                        Text(
                            text = "Auto-Bid Settings",
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis
                        )
                    },
                    icon = {
                        Icon(
                            imageVector = Icons.Filled.AutoMode,
                            contentDescription = "Auto-Bid"
                        )
                    }
                )
            }

            // Display preferences
            item {
                Chip(
                    onClick = { /* TODO: Implement display preferences */ },
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = 4.dp),
                    colors = ChipDefaults.secondaryChipColors(),
                    label = {
                        Text(
                            text = "Display",
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis
                        )
                    },
                    icon = {
                        Icon(
                            imageVector = Icons.Filled.Brightness6,
                            contentDescription = "Display"
                        )
                    }
                )
            }

            // Privacy & Security
            item {
                Chip(
                    onClick = { /* TODO: Implement privacy settings */ },
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = 4.dp),
                    colors = ChipDefaults.secondaryChipColors(),
                    label = {
                        Text(
                            text = "Privacy & Security",
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis
                        )
                    },
                    icon = {
                        Icon(
                            imageVector = Icons.Filled.Security,
                            contentDescription = "Privacy"
                        )
                    }
                )
            }

            // About
            item {
                Chip(
                    onClick = { /* TODO: Show about dialog */ },
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = 4.dp),
                    colors = ChipDefaults.secondaryChipColors(),
                    label = {
                        Text(
                            text = "About",
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis
                        )
                    },
                    icon = {
                        Icon(
                            imageVector = Icons.Filled.Info,
                            contentDescription = "About"
                        )
                    }
                )
            }

            // Spacer
            item {
                Spacer(modifier = Modifier.height(8.dp))
            }

            // Sign out button
            item {
                Chip(
                    onClick = { showSignOutDialog = true },
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = 4.dp),
                    colors = ChipDefaults.primaryChipColors(
                        backgroundColor = WearColors.Error
                    ),
                    label = {
                        Text(
                            text = "Sign Out",
                            maxLines = 1,
                            overflow = TextOverflow.Ellipsis,
                            modifier = Modifier.fillMaxWidth(),
                            textAlign = TextAlign.Center
                        )
                    },
                    icon = {
                        Icon(
                            imageVector = Icons.Filled.Logout,
                            contentDescription = "Sign Out"
                        )
                    }
                )
            }

            // Version info
            item {
                Text(
                    text = "Version 1.0.0",
                    style = MaterialTheme.typography.caption3,
                    color = WearColors.OnSurfaceVariant,
                    textAlign = TextAlign.Center,
                    modifier = Modifier.padding(top = 16.dp)
                )
            }
        }
    }
}
