# Wish Marketplace - Wear OS Module

## Overview

This module contains the native Android Wear OS application for the Wish Marketplace platform, built with Jetpack Compose for Wear OS. The app provides a fully optimized smartwatch experience for browsing wishes, marketplace listings, placing bids, and tracking notifications on the go.

## Features

### Core Functionality

1. **My Wishes**
   - View active personal wishes
   - Track progress with visual indicators
   - Update progress with quick actions
   - Priority and status indicators
   - Optimized for glanceable viewing

2. **Marketplace**
   - Browse active listings
   - View listing details
   - Real-time bid updates
   - Time remaining indicators
   - Ending soon warnings

3. **Bidding System**
   - Quick bid placement interface
   - Pre-calculated bid amounts
   - Minimum bid + quick increments (+$5, +$10, +$25)
   - Buy Now option (when available)
   - Real-time bid status tracking

4. **My Bids**
   - Active bid monitoring
   - Color-coded status (winning, outbid, active)
   - Auto-bid indicators
   - Quick access to listings

5. **Notifications**
   - Unread notification feed
   - Priority-based sorting
   - Type-specific icons
   - Tap to navigate to related content
   - Mark as read functionality

6. **Settings**
   - User account info
   - Sign out functionality
   - Preferences (placeholders for future)
   - App version display

## Architecture

### Design Principles

The Wear OS app follows Google's Wear OS design guidelines and best practices:

1. **Glanceable Information**
   - All screens designed for quick viewing (< 5 seconds)
   - Essential information prioritized
   - Clear visual hierarchy

2. **Touch Target Optimization**
   - Minimum 48dp touch targets throughout
   - Large, tappable buttons and chips
   - Swipe-to-dismiss navigation

3. **Screen Size Adaptation**
   - Supports round and square displays
   - Edge-to-edge design with proper insets
   - ScalingLazyColumn for smooth scrolling

4. **Battery Efficiency**
   - True black (AMOLED) backgrounds
   - Minimal animations
   - Efficient data loading (limited queries)
   - Dark theme optimized

5. **Performance**
   - Limited query results (10-20 items max)
   - Real-time updates via Firebase Flows
   - Coroutine-based async operations
   - Efficient state management

### Technology Stack

- **Kotlin** - Primary language
- **Jetpack Compose for Wear OS** - UI framework
- **Wear Compose Material** - Material Design components
- **Firebase**
  - Authentication
  - Firestore (database)
  - Cloud Messaging
- **Coroutines & Flow** - Async operations
- **Coil** - Image loading

### Project Structure

```
wearos/
├── src/main/
│   ├── java/com/wishmarketplace/wearos/
│   │   ├── MainActivity.kt                 # Main entry point
│   │   ├── theme/
│   │   │   └── WearTheme.kt               # Theme & design system
│   │   ├── models/
│   │   │   └── WearModels.kt              # Data models
│   │   ├── data/
│   │   │   └── FirebaseService.kt         # Firebase integration
│   │   ├── screens/
│   │   │   ├── HomeScreen.kt              # Main hub
│   │   │   ├── LoginScreen.kt             # Authentication
│   │   │   ├── WishListScreen.kt          # Wish list
│   │   │   ├── WishDetailScreen.kt        # Wish details
│   │   │   ├── MarketplaceScreen.kt       # Browse listings
│   │   │   ├── ListingDetailScreen.kt     # Listing details
│   │   │   ├── PlaceBidScreen.kt          # Bid placement
│   │   │   ├── MyBidsScreen.kt            # Bid tracking
│   │   │   ├── NotificationsScreen.kt     # Notifications
│   │   │   └── SettingsScreen.kt          # Settings
│   │   ├── watchface/
│   │   │   └── WishWatchFaceService.kt    # Custom watch face
│   │   ├── tiles/
│   │   │   └── WishTileService.kt         # Quick actions tile
│   │   └── complications/
│   │       └── WishComplicationService.kt  # Watch face data
│   ├── res/
│   │   ├── values/
│   │   │   └── strings.xml                # String resources
│   │   └── drawable/                      # Icons & graphics
│   └── AndroidManifest.xml                # App configuration
├── build.gradle.kts                       # Dependencies
└── README.md                              # This file
```

## Design System

### Color Palette

Optimized for AMOLED displays with battery efficiency in mind:

- **Primary**: Indigo (#6366F1) - Brand color
- **Secondary**: Green (#10B981) - Success/Active bids
- **Background**: True Black (#000000) - Maximum battery efficiency
- **Surface**: Dark Gray (#1A1A1A) - Card backgrounds
- **Error**: Red (#EF4444) - Outbid/Errors
- **Warning**: Amber (#F59E0B) - Time warnings
- **Success**: Green (#10B981) - Winning bids
- **Winning Gold**: Gold (#FBBF24) - Winning status

### Typography

All font sizes optimized for readability at arm's length:

- **Display Large**: 24sp
- **Display Medium**: 20sp
- **Title Large**: 18sp
- **Body Large**: 16sp
- **Body Medium**: 14sp (minimum for body text)
- **Caption**: 12sp (minimum for labels)

### Spacing

Consistent spacing scale:

- **Extra Small**: 4dp
- **Small**: 8dp
- **Medium**: 12dp
- **Large**: 16dp
- **Extra Large**: 24dp
- **Min Touch Target**: 48dp

## Screens & Navigation

### Navigation Flow

```
Login Screen
    ↓
Home Screen (Main Hub)
    ├→ My Wishes → Wish Detail
    ├→ Marketplace → Listing Detail → Place Bid
    ├→ My Bids → Listing Detail
    ├→ Notifications → Related Content
    └→ Settings → Sign Out → Login
```

### Screen Details

#### 1. Login Screen
- Demo authentication (use phone app in production)
- Information about companion app authentication
- Simple, minimal inputs
- **Production Note**: Implement OAuth or phone companion auth

#### 2. Home Screen
- Central navigation hub
- Quick action chips for all features
- Live badge counts for notifications and active bids
- Always-visible TimeText component

#### 3. Wish List Screen
- ScalingLazyColumn for smooth scrolling
- Compact wish cards with:
  - Title and category
  - Priority indicator (colored dot)
  - Progress bar
  - Status color coding
- Empty state for no wishes

#### 4. Wish Detail Screen
- Full wish information
- Status and priority display
- Description with truncation
- Interactive progress updates:
  - +10% increment
  - +25% increment
  - Mark as complete
- Category and target date

#### 5. Marketplace Screen
- Active listings feed
- Compact listing cards with:
  - Title
  - Current bid amount
  - Time remaining
  - Bid count
  - Ending soon indicator
- Empty state for no listings

#### 6. Listing Detail Screen
- Comprehensive listing view
- Large, prominent current bid display
- Time remaining with urgency color coding
- Description and bid details
- Starting bid and increment info
- Buy Now price (if available)
- Large "Place Bid" button (min 48dp)

#### 7. Place Bid Screen
- Quick bidding interface
- Current bid display
- Pre-calculated bid options:
  - Minimum bid (current + increment)
  - +$5 quick bid
  - +$10 quick bid
  - +$25 quick bid
  - Buy Now (if available)
- Success confirmation with icon
- Error handling with clear messages

#### 8. My Bids Screen
- Real-time bid status tracking
- Color-coded bid cards:
  - Winning: Gold background
  - Outbid: Red background
  - Active: Blue background
- Status badges and icons
- Auto-bid indicators
- Tap to view listing

#### 9. Notifications Screen
- Unread notifications only (limited to 10)
- Type-specific icons:
  - Gavel: Bid placed
  - Warning: Outbid
  - Trophy: Bid won
  - Schedule: Expired
  - Message: Chat message
  - Payment: Payment updates
- Priority indicators
- Swipe to mark as read
- Tap to navigate to related content

#### 10. Settings Screen
- User account display
- Preferences (placeholders)
- Sign out with confirmation dialog
- App version info

## Components

### Reusable Components

1. **WishCard**
   - Displays wish with progress bar
   - Priority and status indicators
   - Used in WishListScreen

2. **ListingCard**
   - Compact listing display
   - Time and bid information
   - Ending soon warnings
   - Used in MarketplaceScreen

3. **BidCard**
   - Bid status display
   - Color-coded backgrounds
   - Status icons
   - Used in MyBidsScreen

4. **BidOptionChip**
   - Bid amount selector
   - Formatted currency display
   - Used in PlaceBidScreen

5. **NotificationCard**
   - Type-specific icons
   - Priority indicators
   - Used in NotificationsScreen

6. **ProgressBar**
   - Visual progress indicator
   - Color-coded by progress level
   - Used in WishCard and WishDetailScreen

7. **Badge**
   - Notification count display
   - Customizable background color
   - Used in HomeScreen

## Firebase Integration

### Collections Used

1. **wishes**
   - User's personal wishes
   - Query: `userId == currentUser && status == 'active'`
   - Limit: 10 items
   - Real-time updates via Flow

2. **listings**
   - Marketplace listings
   - Query: `status == 'active'`
   - Limit: 20 items
   - Real-time updates via Flow

3. **bids**
   - User bids
   - Query: `bidderId == currentUser && status IN ['active', 'winning', 'outbid']`
   - Limit: 10 items
   - Real-time updates via Flow

4. **notifications**
   - User notifications
   - Query: `userId == currentUser && isRead == false`
   - Limit: 10 items
   - Real-time updates via Flow

### Data Optimization

- All queries limited to essential data only
- Real-time listeners use Flow for efficient updates
- Automatic cleanup on screen disposal
- Error handling with Result types
- Suspend functions for async operations

## Performance Optimizations

### Battery Efficiency

1. **True Black Backgrounds**
   - #000000 background on AMOLED displays
   - Turns off pixels completely
   - Significant battery savings

2. **Limited Data Loading**
   - Max 10-20 items per query
   - Prevents excessive network usage
   - Reduces memory footprint

3. **Efficient Animations**
   - Minimal use of animations
   - Native ScalingLazyColumn effects only
   - No custom heavy animations

### UI Performance

1. **Lazy Loading**
   - ScalingLazyColumn for all lists
   - Items created only when visible
   - Smooth 60fps scrolling

2. **State Management**
   - Compose remember for local state
   - Minimal recompositions
   - Efficient Flow collection

3. **Image Loading**
   - Coil for efficient caching
   - Placeholder support
   - Error handling

## Accessibility

### Compliance

1. **Touch Targets**
   - Minimum 48dp for all interactive elements
   - Large buttons and chips
   - Adequate spacing between elements

2. **Text Readability**
   - Minimum 14sp for body text
   - High contrast ratios (4.5:1)
   - Clear font weights

3. **Color Coding**
   - Not sole indicator of information
   - Accompanied by icons and text
   - Status badges and labels

4. **Screen Reader Support**
   - Content descriptions on all icons
   - Semantic structure
   - Proper labeling

## Testing on Emulator/Device

### Setup

1. **Enable Developer Mode on Wear OS Device**
   ```
   Settings → System → About → Tap "Build number" 7 times
   ```

2. **Enable ADB Debugging**
   ```
   Settings → Developer options → ADB debugging → Enable
   ```

3. **Connect via ADB**
   ```bash
   adb connect <watch-ip-address>:5555
   ```

4. **Run App**
   ```bash
   ./gradlew :wearos:installDebug
   ```

### Emulator Setup

1. Open Android Studio AVD Manager
2. Create New Virtual Device
3. Select Wear OS device (e.g., Wear OS Square, Wear OS Round)
4. Download Wear OS system image
5. Launch emulator
6. Run app from Android Studio

### Testing Checklist

- [ ] Test on round display
- [ ] Test on square display
- [ ] Verify touch target sizes
- [ ] Check text readability at arm's length
- [ ] Test swipe-to-dismiss navigation
- [ ] Verify scroll performance
- [ ] Check all empty states
- [ ] Test error handling
- [ ] Verify Firebase connectivity
- [ ] Test sign out flow
- [ ] Check notification handling

## Production Considerations

### Authentication

**Current Implementation**: Demo login for development

**Production Requirements**:
1. Implement companion phone app authentication
2. Use OAuth 2.0 or similar secure flow
3. Consider magic links sent to phone
4. Store auth tokens securely
5. Implement token refresh logic

### Security

1. **API Keys**
   - Move to BuildConfig
   - Use environment variables
   - Never commit to repository

2. **Data Validation**
   - Validate all user inputs
   - Sanitize before Firebase writes
   - Implement rate limiting

3. **Firebase Rules**
   - Implement proper security rules
   - Validate user permissions
   - Test thoroughly

### Features to Implement

1. **Watch Face**
   - Display active bids count
   - Show upcoming wish deadlines
   - Customizable complications

2. **Tiles**
   - Quick actions for frequent tasks
   - View latest notifications
   - One-tap bid updates

3. **Complications**
   - Active bids count
   - Winning bids indicator
   - Time until listing ends

4. **Offline Support**
   - Cache critical data
   - Queue actions when offline
   - Sync when reconnected

5. **Voice Input**
   - Voice bid amounts
   - Voice wish creation
   - Voice search

## Dependencies

```kotlin
// Wear OS Compose
implementation("androidx.wear.compose:compose-material:1.3.0")
implementation("androidx.wear.compose:compose-foundation:1.3.0")
implementation("androidx.wear.compose:compose-navigation:1.3.0")

// Compose UI
implementation("androidx.compose.ui:ui:1.6.1")
implementation("androidx.activity:activity-compose:1.8.2")

// Firebase
implementation(platform("com.google.firebase:firebase-bom:32.7.1"))
implementation("com.google.firebase:firebase-auth-ktx")
implementation("com.google.firebase:firebase-firestore-ktx")

// Wear specific
implementation("com.google.android.gms:play-services-wearable:18.1.0")

// Image loading
implementation("io.coil-kt:coil-compose:2.5.0")

// Coroutines
implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.3")
```

## Build Configuration

### Minimum Requirements

- **minSdk**: 30 (Wear OS 3.0)
- **targetSdk**: 34
- **compileSdk**: 34
- **Kotlin**: 1.9+
- **Compose Compiler**: 1.5.8

### Build Variants

- **Debug**: Development with logging
- **Release**: Optimized with ProGuard

## Resources

### Official Documentation

- [Wear OS Design Guidelines](https://developer.android.com/design/ui/wear)
- [Compose for Wear OS](https://developer.android.com/training/wearables/compose)
- [Wear OS Samples](https://github.com/android/wear-os-samples)

### Material Design for Wear OS

- [Components](https://developer.android.com/training/wearables/components)
- [Navigation](https://developer.android.com/training/wearables/navigation)
- [Best Practices](https://developer.android.com/training/wearables/best-practices)

## Troubleshooting

### Common Issues

1. **Firebase Connection Fails**
   - Verify google-services.json is in wearos/
   - Check package name matches Firebase console
   - Ensure internet permission in manifest

2. **App Crashes on Launch**
   - Check Firebase initialization
   - Verify all dependencies are included
   - Review Logcat for errors

3. **Slow Performance**
   - Reduce query limits
   - Check for unnecessary recompositions
   - Profile with Android Studio

4. **Touch Targets Too Small**
   - Verify 48dp minimum size
   - Check padding around elements
   - Test on actual device

## License

Part of the Wish Marketplace project.

## Support

For issues or questions related to Wear OS implementation, please refer to the main project documentation or create an issue in the repository.

---

**Version**: 1.0.0
**Last Updated**: January 2026
**Minimum Wear OS Version**: 3.0 (API 30)
