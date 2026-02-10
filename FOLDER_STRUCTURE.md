# Wish Marketplace - Complete Folder Structure

## Visual Project Tree

```
wish_marketplace/
│
├── 📁 lib/                                 # Main application code
│   │
│   ├── 📁 core/                            # Core functionality (shared across all features)
│   │   │
│   │   ├── 📁 config/                      # Application configuration
│   │   │   └── 📄 app_config.dart          # Environment settings, feature flags
│   │   │
│   │   ├── 📁 constants/                   # Application constants
│   │   │   └── 📄 app_constants.dart       # Routes, collection names, validation rules
│   │   │
│   │   ├── 📁 errors/                      # Error handling
│   │   │   ├── 📄 exceptions.dart          # Exception classes (data layer)
│   │   │   └── 📄 failures.dart            # Failure classes (domain layer)
│   │   │
│   │   ├── 📁 models/                      # Core data models (Freezed)
│   │   │   ├── 📄 bid_model.dart           # Bidding data model
│   │   │   ├── 📄 bid_model.freezed.dart   # Generated Freezed code
│   │   │   ├── 📄 bid_model.g.dart         # Generated JSON serialization
│   │   │   │
│   │   │   ├── 📄 listing_model.dart       # Listing data model
│   │   │   ├── 📄 listing_model.freezed.dart
│   │   │   ├── 📄 listing_model.g.dart
│   │   │   │
│   │   │   ├── 📄 message_model.dart       # Messaging data model
│   │   │   ├── 📄 message_model.freezed.dart
│   │   │   ├── 📄 message_model.g.dart
│   │   │   │
│   │   │   ├── 📄 notification_model.dart  # Notification data model
│   │   │   ├── 📄 notification_model.freezed.dart
│   │   │   ├── 📄 notification_model.g.dart
│   │   │   │
│   │   │   ├── 📄 review_model.dart        # Review data model
│   │   │   ├── 📄 review_model.freezed.dart
│   │   │   ├── 📄 review_model.g.dart
│   │   │   │
│   │   │   ├── 📄 transaction_model.dart   # Transaction/Payment data model
│   │   │   ├── 📄 transaction_model.freezed.dart
│   │   │   ├── 📄 transaction_model.g.dart
│   │   │   │
│   │   │   ├── 📄 user_model.dart          # User data model
│   │   │   ├── 📄 user_model.freezed.dart
│   │   │   └── 📄 user_model.g.dart
│   │   │
│   │   ├── 📁 providers/                   # Core Riverpod providers
│   │   │   └── 📄 firebase_providers.dart  # Firebase service providers
│   │   │
│   │   ├── 📁 routing/                     # Navigation configuration
│   │   │   └── 📄 app_router.dart          # GoRouter setup with routes
│   │   │
│   │   ├── 📁 services/                    # Core services
│   │   │   ├── 📄 auth_service.dart        # Authentication service
│   │   │   ├── 📄 firebase_service.dart    # Firebase initialization
│   │   │   └── 📄 firestore_service.dart   # Firestore CRUD operations
│   │   │
│   │   ├── 📁 theme/                       # Theme configuration
│   │   │   ├── 📄 app_colors.dart          # Color palette
│   │   │   ├── 📄 app_text_styles.dart     # Typography styles
│   │   │   └── 📄 app_theme.dart           # Theme definitions
│   │   │
│   │   └── 📁 utils/                       # Utility functions
│   │       ├── 📄 currency_utils.dart      # Currency formatting
│   │       ├── 📄 date_time_utils.dart     # Date/time utilities
│   │       └── 📄 logger.dart              # Logging utility
│   │
│   ├── 📁 features/                        # Feature modules (feature-first)
│   │   │
│   │   ├── 📁 auth/                        # Authentication feature
│   │   │   ├── 📁 data/
│   │   │   │   └── 📁 repositories/
│   │   │   │       └── 📄 auth_repository.dart
│   │   │   │
│   │   │   └── 📁 presentation/
│   │   │       ├── 📁 pages/
│   │   │       │   ├── 📄 login_page.dart
│   │   │       │   └── 📄 register_page.dart
│   │   │       │
│   │   │       └── 📁 providers/
│   │   │           └── 📄 auth_providers.dart
│   │   │
│   │   ├── 📁 home/                        # Home screen feature
│   │   │   └── 📁 presentation/
│   │   │       └── 📁 pages/
│   │   │           └── 📄 home_page.dart
│   │   │
│   │   └── 📁 splash/                      # Splash screen
│   │       └── 📁 presentation/
│   │           └── 📁 pages/
│   │               └── 📄 splash_page.dart
│   │
│   ├── 📁 shared/                          # Shared components
│   │   │
│   │   ├── 📁 extensions/                  # Dart extensions
│   │   │   ├── 📄 context_extensions.dart  # BuildContext extensions
│   │   │   └── 📄 string_extensions.dart   # String extensions
│   │   │
│   │   ├── 📁 validators/                  # Form validators
│   │   │   └── 📄 form_validators.dart     # All form validation logic
│   │   │
│   │   └── 📁 widgets/                     # Reusable widgets
│   │       ├── 📄 empty_state.dart         # Empty state widget
│   │       ├── 📄 error_widget.dart        # Error display widget
│   │       └── 📄 loading_indicator.dart   # Loading indicator widget
│   │
│   └── 📄 main.dart                        # Application entry point
│
├── 📁 test/                                # Test files
│   └── 📄 widget_test.dart                 # Basic widget test
│
├── 📁 assets/                              # Static assets
│   ├── 📁 fonts/                           # Custom fonts
│   ├── 📁 icons/                           # App icons
│   └── 📁 images/                          # Images
│
├── 📁 android/                             # Android-specific code
├── 📁 ios/                                 # iOS-specific code
├── 📁 web/                                 # Web-specific code
├── 📁 linux/                               # Linux-specific code
├── 📁 macos/                               # macOS-specific code
├── 📁 windows/                             # Windows-specific code
│
├── 📄 pubspec.yaml                         # Dependencies and assets
├── 📄 analysis_options.yaml                # Linter configuration
├── 📄 .gitignore                           # Git ignore rules
│
├── 📄 ARCHITECTURE.md                      # Architecture documentation
├── 📄 SETUP_GUIDE.md                       # Setup instructions
├── 📄 PROJECT_SUMMARY.md                   # Project summary
├── 📄 QUICK_START.md                       # Quick start guide
└── 📄 FOLDER_STRUCTURE.md                  # This file
```

## File Count by Category

### Core Files (29 files)
- Configuration: 2 files
- Error Handling: 2 files
- Data Models: 21 files (7 models × 3 files each)
- Providers: 1 file
- Routing: 1 file
- Services: 3 files
- Theme: 3 files
- Utils: 3 files

### Feature Files (6 files)
- Auth: 4 files
- Home: 1 file
- Splash: 1 file

### Shared Files (6 files)
- Extensions: 2 files
- Validators: 1 file
- Widgets: 3 files

### Total: 41 Dart files (excluding generated)
### Generated: 14 .freezed.dart + 14 .g.dart = 28 files

## File Naming Conventions

### Models
- Pattern: `{entity}_model.dart`
- Example: `user_model.dart`
- Generated: `user_model.freezed.dart`, `user_model.g.dart`

### Pages
- Pattern: `{feature}_page.dart`
- Example: `login_page.dart`

### Widgets
- Pattern: `{widget_name}_widget.dart` or `{widget_name}.dart`
- Example: `loading_indicator.dart`

### Services
- Pattern: `{service_name}_service.dart`
- Example: `auth_service.dart`

### Repositories
- Pattern: `{entity}_repository.dart`
- Example: `auth_repository.dart`

### Providers
- Pattern: `{feature}_providers.dart`
- Example: `auth_providers.dart`

### Utils
- Pattern: `{category}_utils.dart`
- Example: `date_time_utils.dart`

## Import Path Examples

### Core Imports
```dart
// Configuration
import 'package:wish_marketplace/core/config/app_config.dart';

// Constants
import 'package:wish_marketplace/core/constants/app_constants.dart';

// Models
import 'package:wish_marketplace/core/models/user_model.dart';

// Services
import 'package:wish_marketplace/core/services/auth_service.dart';

// Theme
import 'package:wish_marketplace/core/theme/app_theme.dart';

// Utils
import 'package:wish_marketplace/core/utils/logger.dart';
```

### Feature Imports
```dart
// Auth repository
import 'package:wish_marketplace/features/auth/data/repositories/auth_repository.dart';

// Auth providers
import 'package:wish_marketplace/features/auth/presentation/providers/auth_providers.dart';

// Login page
import 'package:wish_marketplace/features/auth/presentation/pages/login_page.dart';
```

### Shared Imports
```dart
// Extensions
import 'package:wish_marketplace/shared/extensions/string_extensions.dart';

// Validators
import 'package:wish_marketplace/shared/validators/form_validators.dart';

// Widgets
import 'package:wish_marketplace/shared/widgets/loading_indicator.dart';
```

## File Size Overview

### Large Files (500+ lines)
- `app_constants.dart` - 158 lines (all constants)
- `auth_service.dart` - 246 lines (authentication logic)
- `firestore_service.dart` - 250 lines (CRUD operations)
- `app_theme.dart` - 265 lines (theme configuration)

### Medium Files (200-500 lines)
- Most model files
- Service files
- Utility files

### Small Files (< 200 lines)
- Page placeholders
- Extension files
- Widget files

## Code Organization Principles

### 1. Feature-First Structure
Each feature is self-contained with its own data, domain, and presentation layers.

### 2. Separation by Layer
- **data/**: Repositories, data sources
- **domain/**: Business logic, use cases (to be added)
- **presentation/**: UI, state management

### 3. Shared Resources
Common components, extensions, and utilities are in `shared/` and `core/`.

### 4. Core Services
Services that are used across features live in `core/services/`.

### 5. Centralized Models
Data models that are used by multiple features are in `core/models/`.

## Adding New Files

### New Feature
```
lib/features/my_feature/
├── data/
│   ├── models/              (if feature-specific)
│   └── repositories/
├── domain/
│   └── usecases/
└── presentation/
    ├── pages/
    ├── providers/
    └── widgets/
```

### New Model (Core)
```
lib/core/models/
├── my_model.dart
├── my_model.freezed.dart    (generated)
└── my_model.g.dart          (generated)
```

### New Service
```
lib/core/services/
└── my_service.dart
```

### New Widget (Shared)
```
lib/shared/widgets/
└── my_widget.dart
```

## Generated Files Locations

All generated files are co-located with their source files:

```
lib/core/models/user_model.dart
├── user_model.freezed.dart   ← Generated by Freezed
└── user_model.g.dart         ← Generated by json_serializable
```

## Git Ignored Patterns

The following are NOT committed:
- `*.freezed.dart` - Regenerate with build_runner
- `*.g.dart` - Regenerate with build_runner
- `build/` - Build artifacts
- `.dart_tool/` - Dart tools cache
- `.idea/` - IDE settings
- `*.iml` - IntelliJ files

## VS Code Workspace Recommendations

Add to `.vscode/settings.json`:

```json
{
  "files.exclude": {
    "**/*.freezed.dart": true,
    "**/*.g.dart": true,
    "**/.dart_tool": true,
    "**/build": true
  },
  "search.exclude": {
    "**/*.freezed.dart": true,
    "**/*.g.dart": true
  }
}
```

This hides generated files from search and file explorer.

## Documentation Files

- **ARCHITECTURE.md**: Detailed architecture explanation
- **SETUP_GUIDE.md**: Complete setup instructions
- **PROJECT_SUMMARY.md**: Project overview and status
- **QUICK_START.md**: Get started in 5 minutes
- **FOLDER_STRUCTURE.md**: This file

## Diagram: Data Flow

```
┌─────────────────────────────────────────────────────────┐
│                        UI Layer                          │
│  (features/*/presentation/pages & widgets)              │
│                                                          │
│  ┌──────────────────────────────────────────────────┐  │
│  │         ConsumerWidget / StatelessWidget          │  │
│  └──────────────────────────────────────────────────┘  │
│                          ↓                               │
│  ┌──────────────────────────────────────────────────┐  │
│  │         Riverpod Providers (StateNotifier)        │  │
│  │     (features/*/presentation/providers)           │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│                    Business Logic                        │
│  (features/*/data/repositories)                         │
│                                                          │
│  ┌──────────────────────────────────────────────────┐  │
│  │         Repository (Either<Failure, Data>)        │  │
│  │     Converts Exceptions to Failures              │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│                    Data Layer                            │
│  (core/services)                                        │
│                                                          │
│  ┌──────────────────────────────────────────────────┐  │
│  │         Services (throws Exceptions)              │  │
│  │     Firebase, Firestore, etc.                     │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│                  External Services                       │
│  Firebase, Stripe, etc.                                 │
└─────────────────────────────────────────────────────────┘
```

---

**Legend:**
- 📁 Folder
- 📄 File
- ← Generated file indicator

This structure supports:
- ✓ Clean Architecture
- ✓ Feature-First Organization
- ✓ Separation of Concerns
- ✓ Scalability
- ✓ Testability
- ✓ Maintainability
