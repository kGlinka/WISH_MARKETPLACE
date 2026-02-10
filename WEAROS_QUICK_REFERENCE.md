# Wear OS Quick Reference Card

## Essential Commands

### Build & Install
```bash
# Debug build
./gradlew :wearos:assembleDebug

# Install on device/emulator
./gradlew :wearos:installDebug

# Release build
./gradlew :wearos:assembleRelease

# Create App Bundle
./gradlew :wearos:bundleRelease
```

### ADB Commands
```bash
# List devices
adb devices

# Connect via Wi-Fi
adb connect <watch-ip>:5555

# Install APK
adb install wearos/build/outputs/apk/debug/wearos-debug.apk

# Launch app
adb shell am start -n com.wishmarketplace.wearos/.MainActivity

# View logs
adb logcat | grep WishMarketplace

# Clear app data
adb shell pm clear com.wishmarketplace.wearos
```

## File Structure

```
wearos/
├── src/main/
│   ├── java/com/wishmarketplace/wearos/
│   │   ├── MainActivity.kt              # Entry point
│   │   ├── theme/WearTheme.kt           # Design system
│   │   ├── models/WearModels.kt         # Data models
│   │   ├── data/FirebaseService.kt      # Backend
│   │   └── screens/                     # UI screens
│   │       ├── HomeScreen.kt
│   │       ├── WishListScreen.kt
│   │       ├── MarketplaceScreen.kt
│   │       ├── PlaceBidScreen.kt
│   │       └── ...
│   ├── res/values/strings.xml
│   └── AndroidManifest.xml
└── build.gradle.kts
```

## Key Components

### Theme Constants

```kotlin
// Colors
WearColors.Primary              // #6366F1 Indigo
WearColors.Secondary            // #10B981 Green
WearColors.Background           // #000000 Black (AMOLED)
WearColors.Error                // #EF4444 Red
WearColors.Success              // #10B981 Green
WearColors.Warning              // #F59E0B Amber
WearColors.WinningGold          // #FBBF24 Gold

// Spacing
WearSpacing.Small               // 8dp
WearSpacing.Medium              // 12dp
WearSpacing.Large               // 16dp
WearSpacing.MinTouchTarget      // 48dp

// Typography
WearTypography.DisplayLarge     // 24sp
WearTypography.TitleLarge       // 18sp
WearTypography.BodyLarge        // 16sp
WearTypography.BodyMedium       // 14sp (minimum)
```

### Standard Screen Structure

```kotlin
@Composable
fun MyScreen() {
    val listState = rememberScalingLazyListState()

    Scaffold(
        timeText = { TimeText() },
        positionIndicator = {
            PositionIndicator(scalingLazyListState = listState)
        }
    ) {
        ScalingLazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .background(WearColors.Background),
            state = listState,
            contentPadding = PaddingValues(
                top = 32.dp,
                bottom = 32.dp,
                start = 8.dp,
                end = 8.dp
            )
        ) {
            // Items here
        }
    }
}
```

### Firebase Queries

```kotlin
// Get user wishes
firebaseService.getUserWishes(userId)
    .collectAsState(initial = emptyList())

// Get active listings
firebaseService.getActiveListings()
    .collectAsState(initial = emptyList())

// Get user bids
firebaseService.getUserBids(userId)
    .collectAsState(initial = emptyList())

// Get notifications
firebaseService.getUserNotifications(userId)
    .collectAsState(initial = emptyList())

// Place bid (suspend function)
scope.launch {
    firebaseService.placeBid(listingId, amount)
        .onSuccess { /* Handle success */ }
        .onFailure { /* Handle error */ }
}
```

## Common UI Patterns

### Chip Button (Primary Action)
```kotlin
Chip(
    onClick = { /* Action */ },
    modifier = Modifier
        .fillMaxWidth()
        .padding(vertical = 4.dp),
    colors = ChipDefaults.primaryChipColors(
        backgroundColor = WearColors.Primary
    ),
    label = { Text("Action") },
    icon = {
        Icon(
            imageVector = Icons.Default.Add,
            contentDescription = "Add"
        )
    }
)
```

### Card (Information Display)
```kotlin
Card(
    onClick = { /* Action */ },
    modifier = Modifier
        .fillMaxWidth()
        .padding(vertical = 4.dp)
) {
    Column(
        modifier = Modifier
            .fillMaxWidth()
            .padding(12.dp)
    ) {
        Text("Title", style = MaterialTheme.typography.title3)
        Text("Body", style = MaterialTheme.typography.body2)
    }
}
```

### Empty State
```kotlin
Column(
    modifier = Modifier
        .fillMaxSize()
        .padding(16.dp),
    horizontalAlignment = Alignment.CenterHorizontally,
    verticalArrangement = Arrangement.Center
) {
    Icon(
        imageVector = Icons.Default.Info,
        contentDescription = null,
        modifier = Modifier.size(48.dp)
    )
    Spacer(modifier = Modifier.height(8.dp))
    Text("No data available")
}
```

### Loading State
```kotlin
Box(
    modifier = Modifier.fillMaxSize(),
    contentAlignment = Alignment.Center
) {
    CircularProgressIndicator(
        indicatorColor = WearColors.Primary
    )
}
```

## Navigation

### Route Structure
```
login → home → [wishes|marketplace|bids|notifications|settings]
              ↓
        wish_detail/{id}
        listing_detail/{id} → place_bid/{id}
```

### Navigation Example
```kotlin
// In composable
val navController = rememberSwipeDismissableNavController()

// Navigate
navController.navigate("screen_name")

// Navigate with argument
navController.navigate("detail/$itemId")

// Pop back
navController.popBackStack()

// Replace current screen
navController.navigate("new_screen") {
    popUpTo("old_screen") { inclusive = true }
}
```

## Data Models

### WearWish
```kotlin
data class WearWish(
    val id: String,
    val title: String,
    val description: String,
    val category: String,
    val priority: String,        // "low", "medium", "high", "urgent"
    val status: String,          // "active", "inProgress", "completed"
    val progress: Int            // 0-100
)
```

### WearListing
```kotlin
data class WearListing(
    val id: String,
    val title: String,
    val currentBid: Int,         // in cents
    val bidIncrement: Int,       // in cents
    val bidCount: Int,
    val status: String,
    val endsAt: Timestamp?,
    val timeRemaining: String,   // Computed property
    val isEndingSoon: Boolean    // Computed property
)
```

### WearBid
```kotlin
data class WearBid(
    val id: String,
    val listingId: String,
    val amount: Int,             // in cents
    val status: String,          // "active", "winning", "won", "outbid"
    val amountFormatted: String  // Computed property
)
```

## Design Guidelines

### Touch Targets
- **Minimum**: 48dp x 48dp
- **Recommended**: 56dp+ for primary actions
- **Spacing**: Minimum 8dp between targets

### Text Sizes
- **Minimum body text**: 14sp
- **Minimum labels**: 12sp
- **Recommended titles**: 18sp+
- **Maximum**: 24sp for displays

### Colors
- **Backgrounds**: Use true black (#000000) for AMOLED
- **Contrast**: Minimum 4.5:1 for text
- **Status colors**: Consistent throughout app
  - Success: Green (#10B981)
  - Error: Red (#EF4444)
  - Warning: Amber (#F59E0B)

### Layout
- **Max content width**: Fill available space
- **Padding**: 8-16dp horizontal
- **Vertical spacing**: 4-12dp between items
- **Card radius**: Default Material Design

## Firebase Configuration

### Required Indexes
```javascript
// Wishes by user
userId ASC, status ASC, createdAt DESC

// Public wishes
isPublic ASC, status ASC, createdAt DESC

// Active listings
status ASC, createdAt DESC

// User bids
bidderId ASC, status ASC, createdAt DESC

// Unread notifications
userId ASC, isRead ASC, createdAt DESC
```

### Security Rules Template
```javascript
match /wishes/{wishId} {
  allow read: if isAuthenticated() &&
              (resource.data.isPublic || isOwner(resource.data.userId));
  allow write: if isAuthenticated() && isOwner(request.resource.data.userId);
}

match /bids/{bidId} {
  allow read: if isAuthenticated();
  allow create: if isAuthenticated() && isOwner(request.resource.data.bidderId);
}
```

## Testing Checklist

### Functionality
- [ ] Login/logout works
- [ ] All screens load data
- [ ] Navigation flows correctly
- [ ] Firebase queries return data
- [ ] Bids can be placed
- [ ] Progress can be updated

### UI/UX
- [ ] Touch targets ≥ 48dp
- [ ] Text readable at arm's length
- [ ] Works on round display
- [ ] Works on square display
- [ ] Swipe-to-dismiss enabled
- [ ] Smooth scrolling

### Performance
- [ ] No lag on scroll
- [ ] Firebase loads quickly
- [ ] No memory leaks
- [ ] Battery efficient
- [ ] App size < 15 MB

## Common Issues & Solutions

### Issue: Firebase connection failed
```kotlin
// Solution: Check google-services.json location
// Should be in: wearos/google-services.json
// Verify package name matches Firebase console
```

### Issue: UI elements too small
```kotlin
// Solution: Use WearSpacing.MinTouchTarget
modifier = Modifier.size(WearSpacing.MinTouchTarget.dp)
```

### Issue: Text not readable
```kotlin
// Solution: Use minimum font sizes
style = MaterialTheme.typography.body2 // 14sp minimum
```

### Issue: Slow scrolling
```kotlin
// Solution: Reduce query limits
.limit(10) // Instead of 50+
```

### Issue: Battery drain
```kotlin
// Solution: Use true black background
backgroundColor = WearColors.Background // #000000
```

## Performance Tips

1. **Limit Firebase queries**: Max 10-20 items
2. **Use Flow for real-time data**: Automatic cleanup
3. **Minimize recompositions**: Use `remember` wisely
4. **True black backgrounds**: Battery savings on AMOLED
5. **Lazy loading**: Use ScalingLazyColumn
6. **Cache images**: Coil handles this automatically
7. **Profile regularly**: Android Studio Profiler

## Accessibility Tips

1. **Content descriptions**: All icons need them
2. **Semantic structure**: Use proper composables
3. **Color not sole indicator**: Add icons/text
4. **Readable text**: Minimum 14sp, high contrast
5. **Touch targets**: Minimum 48dp
6. **Clear labels**: Descriptive button text

## Resources

### Documentation
- [Wear OS Guidelines](https://developer.android.com/design/ui/wear)
- [Compose for Wear](https://developer.android.com/training/wearables/compose)
- [Material Design Wear](https://m3.material.io/foundations/layout/applying-layout/window-size-classes)

### Tools
- **Android Studio**: IDE
- **Device Manager**: Emulators
- **Firebase Console**: Backend
- **Play Console**: Distribution

### Sample Code
- [GitHub Samples](https://github.com/android/wear-os-samples)
- [Compose Starter](https://github.com/android/wear-os-samples/tree/main/ComposeStarter)

---

**Quick Reference Version**: 1.0
**Last Updated**: January 2026

**For detailed information, see**: WEAROS_IMPLEMENTATION_GUIDE.md
