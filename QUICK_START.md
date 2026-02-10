# Wish Marketplace - Quick Start Guide

## Get Started in 5 Minutes

### 1. Verify Installation

```bash
cd wish_marketplace
flutter doctor -v
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Generate Code

This step is **required** before running the app:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

Expected output: "Succeeded after XXs with 94 outputs"

### 4. Run the App

```bash
flutter run
```

The app will launch in debug mode and show the splash screen.

## Current App Flow

1. **Splash Screen** (2 seconds)
   - Animated fade-in
   - App logo and name
   - Loading indicator

2. **Login Screen** (placeholder)
   - Basic UI ready
   - Authentication logic implemented
   - Forms to be completed

## File Organization at a Glance

```
lib/
├── core/                           # Shared across all features
│   ├── config/                     # App configuration
│   ├── constants/                  # Constants (routes, keys, etc.)
│   ├── errors/                     # Exception & Failure classes
│   ├── models/                     # Data models (Freezed)
│   ├── providers/                  # Core Riverpod providers
│   ├── routing/                    # GoRouter configuration
│   ├── services/                   # Firebase, Auth, Firestore
│   ├── theme/                      # Colors, text styles, theme
│   └── utils/                      # Logger, formatters, helpers
│
├── features/                       # Feature modules
│   ├── auth/                       # Authentication
│   ├── home/                       # Home screen
│   └── splash/                     # Splash screen
│
├── shared/                         # Reusable components
│   ├── extensions/                 # Dart extensions
│   ├── validators/                 # Form validators
│   └── widgets/                    # Common widgets
│
└── main.dart                       # App entry point
```

## Key Files to Start With

### For UI Development
- `lib/features/auth/presentation/pages/login_page.dart` - Login UI
- `lib/features/auth/presentation/pages/register_page.dart` - Register UI
- `lib/features/home/presentation/pages/home_page.dart` - Main screen

### For State Management
- `lib/features/auth/presentation/providers/auth_providers.dart` - Auth state
- `lib/core/providers/firebase_providers.dart` - Firebase state

### For Styling
- `lib/core/theme/app_colors.dart` - Color palette
- `lib/core/theme/app_text_styles.dart` - Typography
- `lib/shared/widgets/` - Reusable widgets

### For Data
- `lib/core/models/` - All data models (already configured)
- `lib/features/auth/data/repositories/` - Data access layer

## Common Tasks

### Add a New Feature

1. Create feature folder:
```
lib/features/new_feature/
├── data/repositories/
├── domain/usecases/
└── presentation/
    ├── pages/
    ├── providers/
    └── widgets/
```

2. Add route in `lib/core/routing/app_router.dart`
3. Add constants in `lib/core/constants/app_constants.dart`
4. Create providers in `presentation/providers/`

### Add a New Model

1. Create model file in `lib/core/models/`
2. Use Freezed annotations:
```dart
@freezed
class MyModel with _$MyModel {
  const factory MyModel({
    required String id,
    required String name,
  }) = _MyModel;

  factory MyModel.fromJson(Map<String, dynamic> json) =>
      _$MyModelFromJson(json);
}
```

3. Run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Add Form Validation

Use validators from `lib/shared/validators/form_validators.dart`:

```dart
TextFormField(
  validator: FormValidators.validateEmail,
)
```

### Navigate Between Screens

```dart
// Go to route
context.go('/home');

// Named navigation
context.goNamed('listing-details', pathParameters: {'id': '123'});

// Push route
context.push('/settings');

// Go back
context.pop();
```

### Show Loading/Error States

```dart
// Loading indicator
const LoadingIndicator()

// With message
LoadingIndicator(message: 'Loading listings...')

// Error display
ErrorDisplay(
  message: 'Failed to load data',
  onRetry: () => _loadData(),
)

// Empty state
EmptyState.noListings(
  onAction: () => context.go('/create-listing'),
)
```

## Debugging Tips

### Enable Verbose Logging

The app uses AppLogger which is debug-mode aware:

```dart
AppLogger.debug('Debug message');
AppLogger.info('Info message');
AppLogger.warning('Warning message');
AppLogger.error('Error message');
```

Logs only show in development mode (ENVIRONMENT=development).

### Check Provider State

Use Riverpod DevTools to inspect provider state:

```bash
flutter run --dart-define=DEBUG_PROVIDERS=true
```

### Inspect Navigation

GoRouter has built-in logging:

```dart
// In app_router.dart
debugLogDiagnostics: true,  // Already enabled
```

## Environment Configuration

### Development

```bash
flutter run --dart-define=ENVIRONMENT=development
```

### Staging

```bash
flutter run \
  --dart-define=ENVIRONMENT=staging \
  --dart-define=API_BASE_URL=https://staging-api.wishmarketplace.com
```

### Production

```bash
flutter run --release \
  --dart-define=ENVIRONMENT=production \
  --dart-define=STRIPE_PUBLISHABLE_KEY=pk_live_xxx
```

## Code Generation Commands

```bash
# One-time generation
flutter pub run build_runner build --delete-conflicting-outputs

# Watch mode (auto-regenerates on file changes)
flutter pub run build_runner watch

# Clean generated files
flutter pub run build_runner clean
```

## Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test
flutter test test/features/auth/auth_test.dart
```

## Code Quality

```bash
# Analyze code
flutter analyze

# Format code
dart format lib/

# Fix issues automatically
dart fix --apply
```

## Useful VS Code Snippets

### Create Freezed Model
Type: `freezed` + Tab

### Create StatelessWidget
Type: `stless` + Tab

### Create ConsumerWidget
Type: `consumer` + Tab

### Create Provider
Type: `provider` + Tab

## Common Issues

### Build Runner Fails

```bash
flutter clean
flutter pub get
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### Import Errors

Make sure you've run code generation:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Hot Reload Not Working

```bash
# Hot restart instead
Press 'R' in terminal or click ⚡ in IDE
```

## Next Development Tasks

1. Complete login form UI
2. Complete registration form UI
3. Add form validation feedback
4. Test authentication flow
5. Create home screen layout
6. Add bottom navigation
7. Create listing card widget
8. Implement listings feed

## Resources

- [Full Architecture Documentation](ARCHITECTURE.md)
- [Complete Setup Guide](SETUP_GUIDE.md)
- [Project Summary](PROJECT_SUMMARY.md)
- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)

## Getting Help

### Check Documentation
1. Read error message carefully
2. Check relevant file's inline comments
3. Review ARCHITECTURE.md section
4. Search Flutter/Riverpod docs

### Debug Process
1. Check AppLogger output
2. Use Flutter DevTools
3. Add breakpoints
4. Inspect provider state

## Project Status

- Architecture: Complete ✓
- Models: Complete ✓
- Services: Complete ✓
- Routing: Complete ✓
- State Management: Complete ✓
- Theme: Complete ✓
- Utils: Complete ✓

Ready for feature development!

---

**Start building your first feature now!**

Open `lib/features/auth/presentation/pages/login_page.dart` and start designing the login UI using the shared widgets and theme system.
