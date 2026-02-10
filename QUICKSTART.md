# Quick Start Guide - Wish Marketplace Authentication

Get up and running with Firebase Authentication in 10 minutes!

## Prerequisites

- Flutter SDK (>=3.0.0) installed
- Firebase account
- Code editor (VS Code, Android Studio, etc.)

## Step 1: Clone and Setup (2 minutes)

```bash
# Navigate to project
cd wish_marketplace

# Install dependencies
flutter pub get
```

## Step 2: Firebase Console Setup (5 minutes)

1. **Create Firebase Project**
   - Go to https://console.firebase.google.com/
   - Click "Add project"
   - Name: `wish-marketplace`
   - Click through to create

2. **Add Flutter App**
   - Click Android icon (for Android)
   - Package name: `com.wishmarketplace.app`
   - Download `google-services.json`
   - Place in `android/app/`

3. **Enable Authentication**
   - Go to Authentication section
   - Click "Get started"
   - Enable "Email/Password" provider
   - Save

4. **Enable Firestore**
   - Go to Firestore Database
   - Click "Create database"
   - Start in test mode
   - Enable

## Step 3: Run the App (3 minutes)

```bash
# Check for connected devices
flutter devices

# Run on connected device/emulator
flutter run
```

## Testing Authentication

### Test Registration

1. Launch app (will show splash screen, then login)
2. Click "Sign Up" at bottom
3. Fill in form:
   - Username: `testuser`
   - Email: `test@example.com`
   - Password: `Test123!@#`
   - Confirm password: `Test123!@#`
   - Check "Accept Terms"
4. Click "Sign Up"
5. See email verification dialog
6. Check email and click verification link

### Test Login

1. Go to Login screen
2. Enter credentials:
   - Email: `test@example.com`
   - Password: `Test123!@#`
3. Click "Sign In"
4. Navigate to Home screen

### Test Password Reset

1. On Login screen, click "Forgot Password?"
2. Enter email: `test@example.com`
3. Click "Send Email"
4. Check email for reset link
5. Reset password via link

## Verify in Firebase Console

1. Go to Authentication > Users
   - Should see your test user
2. Go to Firestore Database > Data
   - Should see `users` collection with user document

## Common Issues

**App won't build?**
```bash
flutter clean
flutter pub get
flutter run
```

**Firebase not initialized?**
- Check `google-services.json` is in `android/app/`
- Ensure package name matches in `android/app/build.gradle`

**Email not received?**
- Check spam folder
- Verify email provider is enabled in Firebase Console
- Wait a few minutes for email delivery

## Next Steps

- [ ] Customize email templates in Firebase Console
- [ ] Add social authentication (Google, Apple)
- [ ] Implement profile management
- [ ] Add user roles and permissions
- [ ] Set up production Firestore rules

## File Locations

**Login Screen**: `lib/features/auth/presentation/pages/login_page.dart`
**Register Screen**: `lib/features/auth/presentation/pages/register_page.dart`
**Auth Service**: `lib/core/services/auth_service.dart`
**Validators**: `lib/shared/validators/form_validators.dart`

## Documentation

- Full setup: See `FIREBASE_SETUP.md`
- Implementation details: See `AUTH_IMPLEMENTATION_SUMMARY.md`

## Support

Having issues? Check:
1. Flutter doctor: `flutter doctor`
2. Firebase Console logs
3. Debug console for error messages

Happy coding!
