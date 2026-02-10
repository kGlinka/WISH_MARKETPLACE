# Wish Marketplace - Setup Guide

## Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Firebase CLI
- Android Studio / Xcode (for mobile development)
- A code editor (VS Code or Android Studio recommended)

## Initial Setup

### 1. Clone and Install Dependencies

```bash
# Navigate to project directory
cd wish_marketplace

# Get Flutter dependencies
flutter pub get
```

### 2. Generate Code

The project uses code generation for Freezed models and Riverpod providers.

```bash
# Generate all code (first time)
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (for development)
flutter pub run build_runner watch --delete-conflicting-outputs
```

This will generate:
- `*.freezed.dart` files for immutable models
- `*.g.dart` files for JSON serialization

### 3. Firebase Configuration

#### A. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project named "wish-marketplace"
3. Enable the following services:
   - Authentication (Email/Password)
   - Cloud Firestore
   - Cloud Functions
   - Firebase Storage
   - Firebase Messaging
   - Firebase Analytics

#### B. Android Setup

1. In Firebase Console, add an Android app
2. Enter package name: `com.wishmarketplace.app` (or your package name)
3. Download `google-services.json`
4. Place it in `android/app/google-services.json`

#### C. iOS Setup

1. In Firebase Console, add an iOS app
2. Enter bundle ID: `com.wishmarketplace.app` (or your bundle ID)
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/GoogleService-Info.plist`

#### D. Configure Firestore

```bash
# Initialize Firebase in project
firebase init

# Select Firestore, Functions, Storage
# Use existing project: wish-marketplace

# Deploy Firestore rules
firebase deploy --only firestore:rules

# Deploy Firestore indexes
firebase deploy --only firestore:indexes
```

#### E. Create Firestore Indexes

The app requires the following indexes (defined in `firestore.indexes.json`):

1. Listings collection:
   - Fields: `status`, `endTime`
   - Order: `endTime` DESC

2. Bids collection:
   - Fields: `listingId`, `createdAt`
   - Order: `createdAt` DESC

3. Messages collection:
   - Fields: `conversationId`, `createdAt`
   - Order: `createdAt` DESC

### 4. Stripe Configuration

#### A. Get Stripe Keys

1. Create account at [Stripe Dashboard](https://dashboard.stripe.com/)
2. Get your API keys:
   - Test Publishable Key: `pk_test_...`
   - Live Publishable Key: `pk_live_...`

#### B. Configure in App

Set Stripe key via environment variable:

```bash
# Development
flutter run --dart-define=STRIPE_PUBLISHABLE_KEY=pk_test_YOUR_KEY

# Production
flutter run --dart-define=STRIPE_PUBLISHABLE_KEY=pk_live_YOUR_KEY
```

Or update `lib/core/config/app_config.dart`:

```dart
static const String stripePublishableKey = String.fromEnvironment(
  'STRIPE_PUBLISHABLE_KEY',
  defaultValue: 'pk_test_YOUR_DEFAULT_KEY',
);
```

### 5. Platform-Specific Configuration

#### Android

1. Update `android/app/build.gradle`:
   - Set `minSdkVersion` to 21 or higher
   - Set `targetSdkVersion` to 33 or higher

2. Update `android/app/src/main/AndroidManifest.xml`:
   - Add required permissions
   - Add Firebase messaging configuration

#### iOS

1. Update `ios/Runner/Info.plist`:
   - Add camera and photo library permissions
   - Add location permissions
   - Add microphone permission (for voice search)

2. Run `pod install` in iOS folder:
   ```bash
   cd ios
   pod install
   cd ..
   ```

### 6. Run the App

```bash
# Check devices
flutter devices

# Run on connected device
flutter run

# Run with environment
flutter run --dart-define=ENVIRONMENT=development

# Run release build
flutter run --release
```

## Development Workflow

### Code Generation

Always run code generation after modifying models:

```bash
# One-time generation
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (recommended during development)
flutter pub run build_runner watch
```

### Testing

```bash
# Run all tests
flutter test

# Run specific test
flutter test test/features/auth/auth_test.dart

# Run with coverage
flutter test --coverage
```

### Linting

```bash
# Analyze code
flutter analyze

# Format code
dart format lib/

# Fix auto-fixable issues
dart fix --apply
```

## Firebase Security Rules

### Firestore Rules

Update `firestore.rules` with proper security rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Helper functions
    function isAuthenticated() {
      return request.auth != null;
    }

    function isOwner(userId) {
      return isAuthenticated() && request.auth.uid == userId;
    }

    // Users collection
    match /users/{userId} {
      allow read: if isAuthenticated();
      allow create: if isOwner(userId);
      allow update: if isOwner(userId);
      allow delete: if false; // Prevent deletion
    }

    // Listings collection
    match /listings/{listingId} {
      allow read: if true; // Public read
      allow create: if isAuthenticated();
      allow update: if isAuthenticated() &&
                       resource.data.sellerId == request.auth.uid;
      allow delete: if isAuthenticated() &&
                       resource.data.sellerId == request.auth.uid;
    }

    // Bids collection
    match /bids/{bidId} {
      allow read: if isAuthenticated();
      allow create: if isAuthenticated();
      allow update: if isAuthenticated() &&
                       resource.data.bidderId == request.auth.uid;
      allow delete: if false;
    }

    // Messages collection
    match /messages/{messageId} {
      allow read: if isAuthenticated() &&
                     (resource.data.senderId == request.auth.uid ||
                      resource.data.recipientId == request.auth.uid);
      allow create: if isAuthenticated() &&
                       request.resource.data.senderId == request.auth.uid;
      allow update: if false;
      allow delete: if false;
    }
  }
}
```

Deploy rules:
```bash
firebase deploy --only firestore:rules
```

### Storage Rules

Update `storage.rules`:

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    // User avatars
    match /user_avatars/{userId}/{fileName} {
      allow read: if true;
      allow write: if request.auth != null &&
                      request.auth.uid == userId &&
                      request.resource.size < 5 * 1024 * 1024 && // 5MB
                      request.resource.contentType.matches('image/.*');
    }

    // Listing images
    match /listing_images/{listingId}/{fileName} {
      allow read: if true;
      allow write: if request.auth != null &&
                      request.resource.size < 5 * 1024 * 1024 && // 5MB
                      request.resource.contentType.matches('image/.*');
    }
  }
}
```

Deploy storage rules:
```bash
firebase deploy --only storage
```

## Environment Variables

Create different configurations for different environments:

### Development
```bash
flutter run \
  --dart-define=ENVIRONMENT=development \
  --dart-define=STRIPE_PUBLISHABLE_KEY=pk_test_xxx
```

### Staging
```bash
flutter run \
  --dart-define=ENVIRONMENT=staging \
  --dart-define=STRIPE_PUBLISHABLE_KEY=pk_test_xxx \
  --dart-define=API_BASE_URL=https://staging-api.wishmarketplace.com
```

### Production
```bash
flutter run --release \
  --dart-define=ENVIRONMENT=production \
  --dart-define=STRIPE_PUBLISHABLE_KEY=pk_live_xxx \
  --dart-define=API_BASE_URL=https://api.wishmarketplace.com
```

## Troubleshooting

### Common Issues

#### 1. Build Runner Issues

If you encounter issues with code generation:

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

#### 2. Firebase Initialization Failed

- Verify `google-services.json` and `GoogleService-Info.plist` are in correct locations
- Check Firebase project configuration
- Ensure all required Firebase services are enabled

#### 3. Gradle Build Failed (Android)

```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

#### 4. Pod Install Failed (iOS)

```bash
cd ios
rm -rf Pods Podfile.lock
pod install --repo-update
cd ..
```

#### 5. Type Generation Errors

Make sure to run build_runner after adding/modifying Freezed models:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Next Steps

After setup is complete:

1. **Run Code Generation**: Ensure all `.freezed.dart` and `.g.dart` files are generated
2. **Test Firebase Connection**: Run the app and check Firebase console for user authentication
3. **Implement Features**: Start building out the authentication UI and listing features
4. **Configure CI/CD**: Set up automated testing and deployment
5. **Add Analytics**: Implement Firebase Analytics events
6. **Configure Push Notifications**: Test FCM notifications

## Useful Commands

```bash
# Check Flutter setup
flutter doctor -v

# List available devices
flutter devices

# Run tests
flutter test

# Build APK (Android)
flutter build apk --release

# Build App Bundle (Android)
flutter build appbundle --release

# Build iOS
flutter build ios --release

# Generate icons
flutter pub run flutter_launcher_icons:main

# Update dependencies
flutter pub upgrade

# Clean build
flutter clean && flutter pub get
```

## Getting Help

- Check the [ARCHITECTURE.md](ARCHITECTURE.md) for architectural details
- Review Flutter documentation: https://flutter.dev/docs
- Firebase documentation: https://firebase.google.com/docs
- Riverpod documentation: https://riverpod.dev

## License

This project is proprietary and confidential.
