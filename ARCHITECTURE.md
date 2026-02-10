# Wish Marketplace - Architecture Documentation

## Overview

This document describes the architecture and organization of the Wish Marketplace Flutter application. The app follows clean architecture principles with a feature-first folder structure, using Riverpod for state management and Firebase for backend services.

## Architecture Pattern

The application follows a **Clean Architecture** pattern with clear separation of concerns:

- **Presentation Layer**: UI components, pages, and state management (Riverpod providers)
- **Domain Layer**: Business logic, use cases, and entities
- **Data Layer**: Repositories, data sources, and models

## Project Structure

```
lib/
├── core/                           # Core functionality shared across features
│   ├── config/                     # App configuration
│   │   └── app_config.dart        # Environment and app-wide settings
│   ├── constants/                  # Constant values
│   │   └── app_constants.dart     # Routes, collection names, storage keys
│   ├── errors/                     # Error handling
│   │   ├── exceptions.dart        # Exception classes
│   │   └── failures.dart          # Failure classes for functional error handling
│   ├── models/                     # Core data models (Freezed)
│   │   ├── user_model.dart
│   │   ├── listing_model.dart
│   │   ├── bid_model.dart
│   │   ├── transaction_model.dart
│   │   ├── message_model.dart
│   │   ├── notification_model.dart
│   │   └── review_model.dart
│   ├── providers/                  # Core Riverpod providers
│   │   └── firebase_providers.dart
│   ├── routing/                    # Navigation configuration
│   │   └── app_router.dart        # GoRouter configuration with guards
│   ├── services/                   # Core services
│   │   ├── firebase_service.dart  # Firebase initialization & FCM
│   │   ├── auth_service.dart      # Authentication wrapper
│   │   └── firestore_service.dart # Generic Firestore operations
│   ├── theme/                      # Theme configuration
│   │   ├── app_theme.dart         # Material theme definitions
│   │   ├── app_colors.dart        # Color palette
│   │   └── app_text_styles.dart   # Typography styles
│   └── utils/                      # Utility functions
│       ├── logger.dart            # Logging utility
│       ├── date_time_utils.dart   # Date/time formatting
│       └── currency_utils.dart    # Currency operations
│
├── features/                       # Feature modules (feature-first organization)
│   ├── auth/                       # Authentication feature
│   │   ├── data/
│   │   │   └── repositories/
│   │   │       └── auth_repository.dart
│   │   └── presentation/
│   │       ├── pages/
│   │       │   ├── login_page.dart
│   │       │   └── register_page.dart
│   │       └── providers/
│   │           └── auth_providers.dart
│   ├── home/                       # Home/Dashboard feature
│   │   └── presentation/
│   │       └── pages/
│   │           └── home_page.dart
│   └── splash/                     # Splash screen
│       └── presentation/
│           └── pages/
│               └── splash_page.dart
│
├── shared/                         # Shared components across features
│   ├── extensions/                 # Dart extensions
│   │   ├── context_extensions.dart
│   │   └── string_extensions.dart
│   ├── validators/                 # Form validators
│   │   └── form_validators.dart
│   └── widgets/                    # Reusable widgets
│       ├── loading_indicator.dart
│       ├── error_widget.dart
│       └── empty_state.dart
│
└── main.dart                       # Application entry point
```

## Key Technologies

### State Management
- **Riverpod** (v2.4.0): Modern, compile-safe state management
- Providers are organized by feature and core functionality
- Uses `StateNotifierProvider` for complex state management
- `StreamProvider` for real-time Firebase data

### Routing
- **GoRouter** (v12.0.0): Declarative, type-safe routing
- Named routes with path parameters
- Route guards for authentication (ready to be implemented)
- Deep linking support

### Data Models
- **Freezed** (v2.4.5): Immutable data classes with:
  - Copy-with methods
  - Equality comparison
  - JSON serialization/deserialization
  - Union types support

### Backend Services
- **Firebase**:
  - Firebase Auth: User authentication
  - Cloud Firestore: Database
  - Cloud Functions: Backend logic
  - Firebase Storage: File uploads
  - Firebase Messaging: Push notifications
  - Firebase Analytics: App analytics

### Payment Processing
- **Stripe** (v10.0.0): Payment processing and escrow

### Additional Features
- **Location Services**: Geolocator, Geocoding
- **Local Storage**: SharedPreferences, Hive
- **Image Handling**: Image Picker, Cached Network Image
- **Voice Input**: Speech to Text
- **Connectivity**: Connection status monitoring

## Core Concepts

### 1. Error Handling

The app uses a functional error handling approach with the `dartz` package:

```dart
// Exceptions at data layer
try {
  // operation
} catch (e) {
  throw AuthenticationException(message: 'Error');
}

// Converted to Failures at repository layer
Future<Either<Failure, User>> signIn() async {
  try {
    final user = await service.signIn();
    return Right(user);
  } on AuthenticationException catch (e) {
    return Left(AuthenticationFailure(message: e.message));
  }
}

// Handled in UI layer
result.fold(
  (failure) => showError(failure.message),
  (user) => navigateToHome(),
);
```

### 2. Firebase Integration

Firebase is initialized in `main.dart` before the app runs:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  final firebaseService = FirebaseService();
  await firebaseService.initialize();
  await firebaseService.initializeFCM();

  runApp(const ProviderScope(child: App()));
}
```

### 3. State Management Pattern

Each feature has its own providers:

```dart
// Service provider (singleton)
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final service = ref.watch(authServiceProvider);
  return AuthRepository(service);
});

// State notifier for UI state
final loginStateProvider = StateNotifierProvider<LoginStateNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginStateNotifier(repository);
});
```

### 4. Navigation

Type-safe navigation using GoRouter:

```dart
// Navigate to route
context.go('/home');

// Navigate with parameters
context.go('/listing/${listingId}');

// Named navigation
context.goNamed('listing-details', pathParameters: {'id': listingId});

// Push route
context.push('/create-listing');
```

## Data Models

### Core Models (using Freezed)

All data models are immutable and include:
- JSON serialization
- Copy-with methods
- Equality comparison
- Union types where applicable

Example:
```dart
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
    required String username,
    // ... other fields
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
```

### Key Models

1. **UserModel**: User accounts and profiles
2. **ListingModel**: Marketplace listings with specs
3. **BidModel**: Bids on listings
4. **TransactionModel**: Payment transactions
5. **EscrowModel**: Escrow payments
6. **MessageModel**: Chat messages
7. **NotificationModel**: Push notifications
8. **ReviewModel**: User and product reviews

## Theme System

Consistent theming using Material Design 3:

- **Colors**: Centralized in `app_colors.dart`
  - Primary: Indigo (#6366F1)
  - Secondary: Emerald (#10B981)
  - Error, Warning, Success, Info colors
  - Light and dark theme variants

- **Typography**: Material Design 3 text styles in `app_text_styles.dart`
  - Display, Headline, Title, Body, Label styles
  - Custom marketplace styles (price, bid, timer)

- **Theme**: Complete theme in `app_theme.dart`
  - Light and dark themes
  - Component themes (buttons, inputs, cards, etc.)

## Services

### FirebaseService
- Initializes Firebase
- Sets up FCM (Firebase Cloud Messaging)
- Configures message handlers

### AuthService
- Wraps Firebase Authentication
- Provides sign-in, sign-up, sign-out methods
- Manages user sessions
- Creates user documents in Firestore

### FirestoreService
- Generic CRUD operations for Firestore
- Type-safe document operations
- Streaming and one-time reads
- Batch operations support

## Utilities

### Logger
- Development logging with pretty printing
- Production-safe (minimal logging in production)
- Specialized methods for API, navigation, Firebase, state changes

### DateTimeUtils
- Date/time formatting
- Relative time strings ("2 hours ago")
- Countdown timers
- Business day calculations

### CurrencyUtils
- Currency formatting (with/without symbols)
- Amount conversions (cents to dollars)
- Compact notation ($1.5K, $2M)
- Fee calculations

### Validators
- Email, password, username validation
- Form field validators
- Marketplace-specific validators (price, bid amount)
- Regular expression patterns

### Extensions
- String extensions (validation, formatting)
- BuildContext extensions (navigation, snackbars, dialogs)
- Nullable type extensions

## Code Generation

The project uses code generation for Freezed models:

```bash
# Generate code
flutter pub run build_runner build --delete-conflicting-outputs

# Watch for changes
flutter pub run build_runner watch --delete-conflicting-outputs
```

## Configuration

### Environment Variables

Set environment variables for different configurations:

```bash
# Development
flutter run --dart-define=ENVIRONMENT=development

# Production
flutter run --dart-define=ENVIRONMENT=production \
  --dart-define=STRIPE_PUBLISHABLE_KEY=pk_live_xxx
```

### Firebase Setup

1. Add `google-services.json` to `android/app/`
2. Add `GoogleService-Info.plist` to `ios/Runner/`
3. Configure Firebase in console
4. Set up Firestore security rules (see `firestore.rules`)

## Next Steps

To continue development:

1. **Run code generation**: `flutter pub run build_runner build`
2. **Implement authentication UI**: Complete login/register pages
3. **Create listing features**: Browse, create, bid on listings
4. **Implement messaging**: Real-time chat between users
5. **Add payment integration**: Stripe checkout and escrow
6. **Build notification system**: FCM with local notifications
7. **Add analytics**: Track user behavior and conversions

## Testing Strategy

The architecture supports testing at multiple levels:

- **Unit Tests**: Test utilities, validators, and business logic
- **Widget Tests**: Test individual UI components
- **Integration Tests**: Test feature flows end-to-end
- **Repository Tests**: Mock services and test data operations

Dependencies for testing are already included:
- `flutter_test`
- `mocktail` (for mocking)
- `integration_test`

## Best Practices

1. **Separation of Concerns**: Keep presentation, business logic, and data separate
2. **Immutability**: Use Freezed for all data models
3. **Error Handling**: Use Either for operations that can fail
4. **Logging**: Use AppLogger for all logging (never print())
5. **Type Safety**: Leverage Dart's type system and null safety
6. **Provider Scoping**: Scope providers appropriately (app-level vs feature-level)
7. **Resource Cleanup**: Dispose resources in StateNotifiers
8. **Code Generation**: Run build_runner after model changes

## Contributing

When adding new features:

1. Create feature folder under `features/`
2. Follow the data/domain/presentation structure
3. Create models in `core/models/` if shared
4. Add constants to `app_constants.dart`
5. Create feature-specific providers
6. Add routes to `app_router.dart`
7. Run code generation for models
8. Document major architectural decisions

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Riverpod Documentation](https://riverpod.dev)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Freezed Documentation](https://pub.dev/packages/freezed)
- [Firebase Flutter Documentation](https://firebase.flutter.dev)
- [Stripe Flutter Documentation](https://pub.dev/packages/flutter_stripe)
