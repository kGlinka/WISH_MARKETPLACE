# Wear OS Implementation Guide

## Overview

This guide provides detailed instructions for integrating and deploying the Wear OS module for the Wish Marketplace application.

## Table of Contents

1. [Project Setup](#project-setup)
2. [Firebase Configuration](#firebase-configuration)
3. [Building the App](#building-the-app)
4. [Testing](#testing)
5. [Deployment](#deployment)
6. [Integration with Main App](#integration-with-main-app)

## Project Setup

### Prerequisites

- Android Studio Hedgehog or later
- Kotlin 1.9+
- Wear OS device or emulator
- Firebase project with Authentication and Firestore

### Step 1: Add Wear OS Module to Project

The Wear OS module is already created in the `wearos/` directory. To integrate it with your existing Android project:

1. **Update `settings.gradle.kts` in project root:**

```kotlin
include(":wearos")
```

2. **Sync project with Gradle files**

### Step 2: Install Dependencies

The Wear OS module uses the following key dependencies (already configured in `wearos/build.gradle.kts`):

```kotlin
dependencies {
    // Wear OS Compose
    implementation("androidx.wear.compose:compose-material:1.3.0")
    implementation("androidx.wear.compose:compose-foundation:1.3.0")
    implementation("androidx.wear.compose:compose-navigation:1.3.0")

    // Firebase
    implementation(platform("com.google.firebase:firebase-bom:32.7.1"))
    implementation("com.google.firebase:firebase-auth-ktx")
    implementation("com.google.firebase:firebase-firestore-ktx")
    implementation("com.google.firebase:firebase-messaging-ktx")

    // Other dependencies...
}
```

## Firebase Configuration

### Step 1: Create Wear OS App in Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your "Wish Marketplace" project
3. Click "Add app" → Select Android icon
4. Enter package name: `com.wishmarketplace.wearos`
5. Download `google-services.json`

### Step 2: Add google-services.json

1. Place `google-services.json` in `wearos/` directory:
   ```
   wearos/
   └── google-services.json
   ```

2. Verify the package name matches:
   ```json
   {
     "project_info": {
       "project_id": "wish-marketplace"
     },
     "client": [
       {
         "client_info": {
           "mobilesdk_app_id": "...",
           "android_client_info": {
             "package_name": "com.wishmarketplace.wearos"
           }
         }
       }
     ]
   }
   ```

### Step 3: Configure Firestore Security Rules

Add Wear OS app to your Firestore security rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Helper function
    function isAuthenticated() {
      return request.auth != null;
    }

    function isOwner(userId) {
      return request.auth.uid == userId;
    }

    // Wishes collection
    match /wishes/{wishId} {
      allow read: if isAuthenticated() &&
                    (resource.data.isPublic == true ||
                     isOwner(resource.data.userId));
      allow write: if isAuthenticated() && isOwner(request.resource.data.userId);
    }

    // Listings collection
    match /listings/{listingId} {
      allow read: if isAuthenticated();
      allow create: if isAuthenticated() && isOwner(request.resource.data.sellerId);
      allow update: if isAuthenticated();
    }

    // Bids collection
    match /bids/{bidId} {
      allow read: if isAuthenticated();
      allow create: if isAuthenticated() && isOwner(request.resource.data.bidderId);
    }

    // Notifications collection
    match /notifications/{notificationId} {
      allow read: if isAuthenticated() && isOwner(resource.data.userId);
      allow update: if isAuthenticated() && isOwner(resource.data.userId);
    }
  }
}
```

### Step 4: Create Firestore Indexes

The Wear OS app requires the following composite indexes:

```json
{
  "indexes": [
    {
      "collectionGroup": "wishes",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "userId", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "wishes",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "isPublic", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "listings",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "bids",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "bidderId", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "notifications",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "userId", "order": "ASCENDING" },
        { "fieldPath": "isRead", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    }
  ]
}
```

Deploy indexes:
```bash
firebase deploy --only firestore:indexes
```

## Building the App

### Debug Build

```bash
cd /path/to/wish_marketplace
./gradlew :wearos:assembleDebug
```

Output: `wearos/build/outputs/apk/debug/wearos-debug.apk`

### Release Build

1. **Create signing key:**
   ```bash
   keytool -genkey -v -keystore wearos-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias wearos
   ```

2. **Update `wearos/build.gradle.kts`:**
   ```kotlin
   android {
       signingConfigs {
           create("release") {
               storeFile = file("../wearos-release-key.jks")
               storePassword = System.getenv("KEYSTORE_PASSWORD")
               keyAlias = "wearos"
               keyPassword = System.getenv("KEY_PASSWORD")
           }
       }
       buildTypes {
           release {
               signingConfig = signingConfigs.getByName("release")
               isMinifyEnabled = true
               proguardFiles(
                   getDefaultProguardFile("proguard-android-optimize.txt"),
                   "proguard-rules.pro"
               )
           }
       }
   }
   ```

3. **Build release APK:**
   ```bash
   export KEYSTORE_PASSWORD=your_password
   export KEY_PASSWORD=your_password
   ./gradlew :wearos:assembleRelease
   ```

## Testing

### Emulator Testing

1. **Create Wear OS Emulator:**
   - Open Android Studio → Tools → Device Manager
   - Create Device → Wear OS → Select device type
   - Download system image (API 30+)
   - Launch emulator

2. **Install and Run:**
   ```bash
   ./gradlew :wearos:installDebug
   adb shell am start -n com.wishmarketplace.wearos/.MainActivity
   ```

### Physical Device Testing

1. **Enable Developer Mode on Watch:**
   - Settings → System → About
   - Tap "Build number" 7 times
   - Go back → Developer options
   - Enable "ADB debugging"
   - Enable "Debug over Wi-Fi" (if wireless)

2. **Connect via USB:**
   ```bash
   adb devices
   # Should show your Wear OS device
   ```

3. **Or Connect via Wi-Fi:**
   ```bash
   adb connect <watch-ip-address>:5555
   ```

4. **Install and Run:**
   ```bash
   ./gradlew :wearos:installDebug
   ```

### Testing Checklist

- [ ] Login flow works correctly
- [ ] Home screen displays all navigation options
- [ ] Wishes load and display properly
- [ ] Marketplace listings appear with correct data
- [ ] Bids can be placed successfully
- [ ] My Bids screen shows real-time updates
- [ ] Notifications appear and can be marked as read
- [ ] Settings screen displays user info
- [ ] Sign out returns to login screen
- [ ] All screens work on round display
- [ ] All screens work on square display
- [ ] Touch targets are large enough (48dp minimum)
- [ ] Text is readable at arm's length
- [ ] Swipe-to-dismiss navigation works
- [ ] Scroll performance is smooth
- [ ] Firebase connectivity is stable
- [ ] Error states display correctly
- [ ] Empty states show appropriate messages

## Deployment

### Play Store Deployment

1. **Prepare Release Build:**
   ```bash
   ./gradlew :wearos:bundleRelease
   ```
   Output: `wearos/build/outputs/bundle/release/wearos-release.aab`

2. **Create Play Console Listing:**
   - Go to [Google Play Console](https://play.google.com/console)
   - Create new Wear OS app (can be standalone or paired with phone app)
   - Upload screenshots (required for Wear OS apps)
   - Write app description
   - Set category and content rating

3. **Upload AAB:**
   - Production → Create new release
   - Upload `wearos-release.aab`
   - Add release notes
   - Submit for review

### Screenshots Required

For Wear OS apps, you need:
- 2-8 screenshots per device type
- 384 x 384 pixels (for round watches)
- 400 x 400 pixels (for square watches)

Generate screenshots using Android Studio or emulator.

### App Size Optimization

Current app size: ~10-15 MB

To reduce size:
1. Enable ProGuard/R8 (already configured)
2. Remove unused resources
3. Use vector drawables instead of PNGs
4. Enable resource shrinking:
   ```kotlin
   buildTypes {
       release {
           isShrinkResources = true
           isMinifyEnabled = true
       }
   }
   ```

## Integration with Main App

### Data Synchronization

The Wear OS app shares the same Firebase backend as the main Flutter app. Data is synchronized automatically through Firestore.

### Authentication

**Current Implementation**: Separate login on watch (demo mode)

**Recommended Production Approach**:

1. **Option A: Companion Phone Authentication**
   - User authenticates on phone
   - Auth token sent to watch via Data Layer API
   - Watch uses token for Firebase authentication

2. **Option B: OAuth Flow**
   - Implement OAuth on watch
   - Use Google Sign-In or other providers
   - Store tokens securely

3. **Option C: QR Code Authentication**
   - Phone generates QR code with auth token
   - Watch scans QR code
   - Token validated and stored

### Data Layer Communication (Phone ↔ Watch)

To enable communication between phone and watch:

1. **Add to Phone App (Flutter):**
   ```yaml
   dependencies:
     wear: ^1.1.0
   ```

2. **Send data from Phone to Watch:**
   ```dart
   import 'package:wear/wear.dart';

   // Send auth token
   WearDataLayer().sendMessage(
     path: '/auth/token',
     data: {'token': authToken},
   );
   ```

3. **Receive on Watch (Kotlin):**
   ```kotlin
   // In WearOS app
   class MessageListenerService : WearableListenerService() {
       override fun onMessageReceived(messageEvent: MessageEvent) {
           if (messageEvent.path == "/auth/token") {
               val token = messageEvent.data.toString()
               // Authenticate with Firebase
           }
       }
   }
   ```

### Shared Data Models

The Wear OS models are simplified versions of the main app models:

**Main App (Flutter)**:
```dart
class WishModel {
  final String id;
  final String title;
  final String description;
  // ... 20+ fields
}
```

**Wear OS (Kotlin)**:
```kotlin
data class WearWish(
  val id: String,
  val title: String,
  val description: String,
  // ... 10 essential fields only
)
```

This reduces data transfer and improves performance on the watch.

## Performance Monitoring

### Firebase Performance Monitoring

Add to `wearos/build.gradle.kts`:

```kotlin
dependencies {
    implementation("com.google.firebase:firebase-perf-ktx")
}
```

Enable in code:
```kotlin
val perf = FirebasePerformance.getInstance()
val trace = perf.newTrace("wishlist_load")
trace.start()
// ... load data
trace.stop()
```

### Analytics

Track user interactions:

```kotlin
// Add to build.gradle.kts
implementation("com.google.firebase:firebase-analytics-ktx")

// In code
val analytics = FirebaseAnalytics.getInstance(context)
analytics.logEvent("bid_placed") {
    param("listing_id", listingId)
    param("bid_amount", amount)
}
```

## Troubleshooting

### Issue: App crashes on startup

**Solution**:
1. Check Firebase initialization in MainActivity
2. Verify google-services.json is in correct location
3. Check Logcat for stack trace:
   ```bash
   adb logcat | grep WishMarketplace
   ```

### Issue: Firebase authentication fails

**Solution**:
1. Verify package name matches Firebase console
2. Check SHA-1 fingerprint is added to Firebase
3. Ensure internet permission in AndroidManifest.xml
4. Test with demo credentials first

### Issue: Slow performance on device

**Solution**:
1. Reduce query limits in FirebaseService
2. Disable unnecessary real-time listeners
3. Use release build for testing (debug builds are slower)
4. Profile with Android Studio Profiler

### Issue: UI elements too small

**Solution**:
1. Check dp values (minimum 48dp for touch targets)
2. Test on actual device (emulator may look different)
3. Review WearSpacing constants in WearTheme.kt

### Issue: Battery drains quickly

**Solution**:
1. Verify background color is true black (#000000)
2. Reduce Firebase listener frequency
3. Disable unnecessary location/sensor access
4. Use WorkManager for background tasks instead of constant listeners

## Maintenance

### Regular Updates

1. **Dependencies**: Update quarterly
   ```bash
   ./gradlew :wearos:dependencyUpdates
   ```

2. **Security**: Monitor Firebase security rules
3. **Performance**: Review Firebase Performance metrics
4. **Crashes**: Monitor Play Console crash reports

### Version Updates

When updating:

1. Update `versionCode` and `versionName` in build.gradle.kts
2. Create release notes
3. Test thoroughly on multiple devices
4. Submit to Play Store
5. Monitor for issues after release

## Resources

### Documentation
- [Wear OS Developer Guide](https://developer.android.com/training/wearables)
- [Compose for Wear OS](https://developer.android.com/training/wearables/compose)
- [Firebase Documentation](https://firebase.google.com/docs)

### Code Samples
- [Official Wear OS Samples](https://github.com/android/wear-os-samples)
- [Compose Wear OS Samples](https://github.com/android/wear-os-samples/tree/main/ComposeStarter)

### Support
- [Stack Overflow - Wear OS](https://stackoverflow.com/questions/tagged/wear-os)
- [Firebase Support](https://firebase.google.com/support)

---

**Document Version**: 1.0
**Last Updated**: January 2026
