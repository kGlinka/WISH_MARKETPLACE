# Firebase Authentication Setup Guide

This guide will walk you through setting up Firebase Authentication for the Wish Marketplace application.

## Prerequisites

- Flutter SDK installed (>=3.0.0)
- Firebase CLI installed
- A Google account

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **"Add project"** or **"Create a project"**
3. Enter project name: `wish-marketplace` (or your preferred name)
4. Disable Google Analytics (optional for development)
5. Click **"Create project"**

## Step 2: Register Your Flutter App

### For Android

1. In Firebase Console, click the Android icon to add an Android app
2. Enter Android package name: `com.wishmarketplace.app` (must match the one in `android/app/build.gradle`)
3. Enter app nickname: `Wish Marketplace Android` (optional)
4. Download `google-services.json`
5. Place it in: `android/app/google-services.json`

### For iOS

1. In Firebase Console, click the iOS icon to add an iOS app
2. Enter iOS bundle ID: `com.wishmarketplace.app` (must match the one in `ios/Runner/Info.plist`)
3. Enter app nickname: `Wish Marketplace iOS` (optional)
4. Download `GoogleService-Info.plist`
5. Place it in: `ios/Runner/GoogleService-Info.plist`

### For Web (Optional)

1. Click the Web icon to add a web app
2. Register the app and copy the Firebase config
3. Add the config to `web/index.html` as instructed

## Step 3: Enable Email/Password Authentication

1. In Firebase Console, go to **Authentication** section
2. Click **"Get started"**
3. Go to **"Sign-in method"** tab
4. Enable **"Email/Password"** provider
   - Click on "Email/Password"
   - Toggle **"Enable"** switch
   - **Do NOT** enable "Email link (passwordless sign-in)" for now
   - Click **"Save"**

## Step 4: Configure Firestore Database

1. In Firebase Console, go to **Firestore Database**
2. Click **"Create database"**
3. Choose **"Start in test mode"** for development
   - For production, use production mode with proper security rules
4. Select your preferred Cloud Firestore location
5. Click **"Enable"**

### Set Up Firestore Security Rules (Development)

Replace the default rules with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{userId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null && request.auth.uid == userId;
      allow update: if request.auth != null && request.auth.uid == userId;
      allow delete: if request.auth != null && request.auth.uid == userId;
    }

    // Listings collection
    match /listings/{listingId} {
      allow read: if true; // Anyone can read listings
      allow create: if request.auth != null;
      allow update: if request.auth != null &&
                       resource.data.sellerId == request.auth.uid;
      allow delete: if request.auth != null &&
                       resource.data.sellerId == request.auth.uid;
    }

    // Bids collection
    match /bids/{bidId} {
      allow read: if request.auth != null;
      allow create: if request.auth != null;
      allow update: if request.auth != null &&
                       resource.data.userId == request.auth.uid;
    }

    // Other collections - adjust as needed
    match /{document=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
  }
}
```

**Important**: These are development rules. For production, implement proper security rules!

## Step 5: Install Dependencies

Run the following command in your project root:

```bash
flutter pub get
```

This will install all required Firebase packages:
- `firebase_core`
- `firebase_auth`
- `cloud_firestore`
- `firebase_messaging`
- `firebase_storage`
- `firebase_analytics`

## Step 6: Configure Firebase for iOS (Additional Steps)

1. Open your iOS project in Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```

2. Ensure `GoogleService-Info.plist` is added to the project
3. Update minimum iOS version in `ios/Podfile` (should be iOS 13.0+):
   ```ruby
   platform :ios, '13.0'
   ```

4. Run pod install:
   ```bash
   cd ios
   pod install
   cd ..
   ```

## Step 7: Test the Setup

### Run the app

```bash
flutter run
```

### Test Authentication Flow

1. **Sign Up**
   - Navigate to the Register page
   - Enter username: `testuser`
   - Enter email: `test@example.com`
   - Enter password: `Test123!@#` (must meet requirements)
   - Confirm password
   - Accept terms and conditions
   - Click "Sign Up"
   - You should see an email verification dialog

2. **Verify Email**
   - Check the email inbox for `test@example.com`
   - Click the verification link
   - Return to the app

3. **Sign In**
   - Navigate to the Login page
   - Enter email: `test@example.com`
   - Enter password: `Test123!@#`
   - Click "Sign In"
   - You should be redirected to the Home page

4. **Password Reset**
   - On Login page, click "Forgot Password?"
   - Enter your email
   - Click "Send Email"
   - Check email for password reset link

5. **Sign Out**
   - In the app, navigate to Profile or Settings
   - Click "Sign Out"
   - You should be redirected to Login page

## Step 8: Verify in Firebase Console

1. Go to **Authentication** > **Users** tab
2. You should see your test user listed
3. Check if email is verified
4. Go to **Firestore Database** > **Data** tab
5. You should see a `users` collection with your user document

## Common Issues and Solutions

### Issue: "No Firebase App '[DEFAULT]' has been created"

**Solution**: Ensure Firebase is initialized before running the app. Check `main.dart`:
```dart
await Firebase.initializeApp();
```

### Issue: "MissingPluginException"

**Solution**:
1. Stop the app
2. Run `flutter clean`
3. Run `flutter pub get`
4. Rebuild and run the app

### Issue: iOS build fails

**Solution**:
1. Delete `ios/Podfile.lock`
2. Delete `ios/Pods` directory
3. Run `cd ios && pod install && cd ..`
4. Clean and rebuild

### Issue: Email not being sent

**Solution**:
1. Check Firebase Console > Authentication > Templates
2. Verify email template is enabled
3. Check spam folder
4. Ensure sender domain is verified (for production)

### Issue: "weak-password" error

**Solution**: Password must meet requirements:
- At least 8 characters
- One uppercase letter
- One lowercase letter
- One number
- One special character

### Issue: Authentication state not persisting

**Solution**: Firebase Auth automatically persists sessions. Check:
1. Device has internet connection
2. Firebase is properly initialized
3. No errors in console

## Security Best Practices

### 1. Email Verification
- Always require email verification before allowing full access
- Implemented in `AuthService.signUpWithEmail()`

### 2. Password Requirements
- Enforced via `FormValidators.validatePassword()`
- Minimum 8 characters with complexity requirements

### 3. Rate Limiting
- Firebase automatically rate limits authentication attempts
- Monitor in Firebase Console > Authentication > Usage

### 4. Error Handling
- User-friendly error messages
- Technical details logged for debugging
- No sensitive information exposed to users

### 5. Session Management
- Firebase handles token refresh automatically
- Sessions persist across app restarts
- Secure token storage on device

## Environment Variables (Production)

For production, use environment variables for sensitive configuration:

1. Create `.env` file (add to `.gitignore`):
```env
STRIPE_PUBLISHABLE_KEY=your_actual_key_here
API_BASE_URL=https://your-api.com
ENVIRONMENT=production
```

2. Use flutter_dotenv or similar package to load variables

3. Never commit sensitive keys to version control!

## Next Steps

1. **Email Templates**: Customize email templates in Firebase Console > Authentication > Templates
2. **Social Auth**: Add Google, Facebook, Apple sign-in
3. **Phone Auth**: Add phone number authentication
4. **Multi-factor Auth**: Enable 2FA for additional security
5. **Custom Claims**: Add user roles and permissions
6. **Security Rules**: Tighten Firestore security rules for production
7. **Error Monitoring**: Set up Firebase Crashlytics
8. **Analytics**: Configure Firebase Analytics events

## Support

For issues or questions:
- Check Firebase documentation: https://firebase.google.com/docs
- Flutter Fire documentation: https://firebase.flutter.dev/
- Firebase support: https://firebase.google.com/support

## Testing Credentials (Development Only)

For development testing, you can use:
- Email: `dev@example.com`
- Password: `DevTest123!@#`

**Never use test credentials in production!**
