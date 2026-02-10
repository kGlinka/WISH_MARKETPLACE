# Wish Management System - Complete Implementation Guide

## Overview

A comprehensive wish management system has been implemented in the Wish Marketplace application. This system allows users to capture, organize, track, and manage their wishes, dreams, and aspirations with full CRUD (Create, Read, Update, Delete) functionality.

## Features

### Core Capabilities

1. **Create Wishes**: Users can add new wishes with detailed information
2. **Browse Wishes**: View collection of wishes with filtering and search
3. **Manage Wishes**: Edit, delete, categorize, and mark wishes as completed
4. **Track Progress**: Monitor progress on wishes with milestones
5. **Organize**: Filter by category, status, priority, and favorites
6. **Statistics**: View comprehensive statistics about your wishes

## Architecture

### Data Layer

#### Wish Model (`lib/core/models/wish_model.dart`)

Immutable data model using Freezed with the following features:

**Main Fields:**
- `id`: Unique identifier
- `userId`: Owner of the wish
- `title`: Wish title
- `description`: Detailed description
- `category`: Category (Personal Growth, Travel, Career, etc.)
- `priority`: Priority level (Low, Medium, High, Urgent)
- `status`: Current status (Active, In Progress, Completed, Deferred, Cancelled)
- `tags`: List of tags for organization
- `prerequisites`: List of required steps
- `targetDate`: Optional target completion date
- `progress`: Progress percentage (0-100)
- `milestones`: List of milestones
- `isFavorite`: Favorite flag
- `isPublic`: Public visibility flag

**Categories:**
- Personal Growth
- Travel
- Career
- Relationships
- Health
- Creativity
- Financial
- Education
- Adventure
- Material
- Spiritual
- Other

**Status Types:**
- Active: Wish is active but not yet started
- In Progress: Currently working on the wish
- Completed: Wish has been achieved
- Deferred: Postponed for later
- Cancelled: No longer pursuing

**Priority Levels:**
- Low
- Medium
- High
- Urgent

#### Wish Service (`lib/features/wishes/data/services/wish_service.dart`)

Handles all Firestore operations:

**Methods:**
- `createWish(WishModel wish)`: Create a new wish
- `updateWish(String wishId, WishModel wish)`: Update existing wish
- `deleteWish(String wishId)`: Delete a wish
- `getWish(String wishId)`: Get single wish by ID
- `getUserWishesStream(String userId)`: Stream of all user wishes
- `getWishesByCategoryStream(String userId, WishCategory category)`: Filter by category
- `getWishesByStatusStream(String userId, WishStatus status)`: Filter by status
- `getWishesByPriorityStream(String userId, WishPriority priority)`: Filter by priority
- `getFavoriteWishesStream(String userId)`: Get favorite wishes
- `searchWishes(String userId, String query)`: Search wishes by title/description/tags
- `updateWishProgress(String wishId, int progress)`: Update progress
- `toggleFavorite(String wishId, bool isFavorite)`: Toggle favorite status
- `markWishCompleted(String wishId)`: Mark as completed
- `getWishStatistics(String userId)`: Get statistics

#### Wish Repository (`lib/features/wishes/data/repositories/wish_repository.dart`)

Converts service calls to Either<Failure, Success> pattern:

- Handles exceptions and converts to failures
- Provides functional error handling
- Returns streams for real-time updates

### Presentation Layer

#### State Management (`lib/features/wishes/presentation/providers/wish_providers.dart`)

**Providers:**
- `wishServiceProvider`: Wish service instance
- `wishRepositoryProvider`: Wish repository instance
- `currentUserIdProvider`: Current user ID
- `userWishesStreamProvider`: Stream of all user wishes
- `wishesByCategoryProvider`: Wishes filtered by category
- `wishesByStatusProvider`: Wishes filtered by status
- `wishesByPriorityProvider`: Wishes filtered by priority
- `favoriteWishesProvider`: Favorite wishes stream
- `wishStatisticsProvider`: Wish statistics
- `selectedWishFilterProvider`: Currently selected filter
- `selectedCategoryFilterProvider`: Currently selected category
- `filteredWishesProvider`: Combined filtered wishes
- `wishFormProvider`: Form state management
- `wishActionsProvider`: Quick actions (favorite, progress, complete)

#### Pages

**1. Wish List Page (`lib/features/wishes/presentation/pages/wish_list_page.dart`)**

Features:
- Displays all wishes in a scrollable list
- Show/hide statistics panel
- Show/hide filter chips
- Search functionality
- Pull-to-refresh
- Empty state handling
- Error handling with retry
- Floating action button to create new wish

**2. Wish Detail Page (`lib/features/wishes/presentation/pages/wish_detail_page.dart`)**

Features:
- Full wish details display
- Status and priority badges
- Progress tracking with slider
- Milestones list
- Prerequisites list
- Tags display
- Metadata (inspiration, motivation)
- Favorite toggle
- Edit/Delete actions
- Mark complete button
- Completion celebration

**3. Wish Form Page (`lib/features/wishes/presentation/pages/wish_form_page.dart`)**

Features:
- Create new wish or edit existing
- All wish fields editable
- Category/Priority/Status dropdowns
- Target date picker
- Progress slider
- Tag management
- Prerequisites management
- Form validation
- Loading states
- Success/Error feedback

#### Widgets

**1. Wish Card (`lib/features/wishes/presentation/widgets/wish_card.dart`)**

Displays wish summary with:
- Status and priority chips
- Title and description
- Category icon
- Target date
- Progress bar
- Tags preview
- Favorite button
- Tap to view details

**2. Wish Filter Chips (`lib/features/wishes/presentation/widgets/wish_filter_chips.dart`)**

Allows filtering by:
- Status (All, Active, In Progress, Completed, Deferred, Favorites)
- Category (All categories or specific)
- Horizontal scrollable chip lists

**3. Wish Statistics Card (`lib/features/wishes/presentation/widgets/wish_statistics_card.dart`)**

Shows statistics:
- Total wishes
- Active wishes
- In progress wishes
- Completed wishes
- Deferred wishes
- Visual icons for each stat

## Routes

### Wish Routes Added to App Router

```dart
/wishes                    // Wish list page
/wish/:id                  // Wish detail page
/create-wish               // Create new wish
/edit-wish/:id            // Edit existing wish
```

### Navigation Examples

```dart
// Go to wish list
context.push(AppConstants.wishesRoute);

// View wish details
context.push('${AppConstants.wishDetailsRoute}/$wishId');

// Create new wish
context.push(AppConstants.createWishRoute);

// Edit wish
context.push('${AppConstants.editWishRoute}/$wishId');
```

## Firebase Configuration

### Firestore Collection

Collection: `wishes`

**Security Rules (to be added to firestore.rules):**

```javascript
// Wishes collection rules
match /wishes/{wishId} {
  allow read: if request.auth != null &&
              (resource.data.userId == request.auth.uid ||
               resource.data.isPublic == true);

  allow create: if request.auth != null &&
                request.resource.data.userId == request.auth.uid;

  allow update, delete: if request.auth != null &&
                         resource.data.userId == request.auth.uid;
}
```

### Firestore Indexes (to be added to firestore.indexes.json)

```json
{
  "indexes": [
    {
      "collectionGroup": "wishes",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "userId", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "wishes",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "userId", "order": "ASCENDING" },
        { "fieldPath": "category", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
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
        { "fieldPath": "userId", "order": "ASCENDING" },
        { "fieldPath": "priority", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "wishes",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "userId", "order": "ASCENDING" },
        { "fieldPath": "isFavorite", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    }
  ]
}
```

## Usage Guide

### Setting Up User ID

Before using the wish system, set the current user ID:

```dart
// In your authentication flow, after user logs in
ref.read(currentUserIdProvider.notifier).state = userId;
```

### Creating a Wish

```dart
// Navigate to create wish page
context.push(AppConstants.createWishRoute);

// Or programmatically create
final wish = WishModel(
  id: '',
  userId: currentUserId,
  title: 'Learn Flutter',
  description: 'Master Flutter development',
  category: WishCategory.education,
  priority: WishPriority.high,
  status: WishStatus.active,
  createdAt: DateTime.now(),
);

await ref.read(wishFormProvider.notifier).createWish(wish);
```

### Updating a Wish

```dart
// Navigate to edit page
context.push('${AppConstants.editWishRoute}/$wishId');

// Or update specific fields
await ref.read(wishActionsProvider.notifier)
  .updateProgress(wishId, 50);

await ref.read(wishActionsProvider.notifier)
  .toggleFavorite(wishId, true);
```

### Marking as Completed

```dart
await ref.read(wishActionsProvider.notifier)
  .markCompleted(wishId);
```

### Filtering Wishes

```dart
// Set filter
ref.read(selectedWishFilterProvider.notifier).state =
  WishFilter.inProgress;

// Set category filter
ref.read(selectedCategoryFilterProvider.notifier).state =
  WishCategory.health;

// The filteredWishesProvider automatically updates
```

### Searching Wishes

```dart
final repository = ref.read(wishRepositoryProvider);
final result = await repository.searchWishes(userId, 'flutter');

result.fold(
  (failure) => print('Error: ${failure.message}'),
  (wishes) => print('Found ${wishes.length} wishes'),
);
```

### Viewing Statistics

```dart
final statisticsAsync = ref.watch(wishStatisticsProvider);

statisticsAsync.when(
  data: (stats) {
    print('Total: ${stats.totalWishes}');
    print('Completed: ${stats.completedWishes}');
  },
  loading: () => print('Loading...'),
  error: (error, stack) => print('Error: $error'),
);
```

## File Structure

```
lib/
├── core/
│   ├── models/
│   │   ├── wish_model.dart              # Main wish data model
│   │   ├── wish_model.freezed.dart      # Generated Freezed code
│   │   └── wish_model.g.dart            # Generated JSON serialization
│   └── constants/
│       └── app_constants.dart           # Updated with wish routes
│
├── features/
│   └── wishes/
│       ├── data/
│       │   ├── services/
│       │   │   └── wish_service.dart    # Firestore operations
│       │   └── repositories/
│       │       └── wish_repository.dart # Repository pattern
│       └── presentation/
│           ├── providers/
│           │   └── wish_providers.dart  # State management
│           ├── pages/
│           │   ├── wish_list_page.dart  # Browse wishes
│           │   ├── wish_detail_page.dart # View/edit wish
│           │   └── wish_form_page.dart   # Create/edit form
│           └── widgets/
│               ├── wish_card.dart        # Wish card widget
│               ├── wish_filter_chips.dart # Filter widgets
│               └── wish_statistics_card.dart # Statistics display
└── core/
    └── routing/
        └── app_router.dart               # Updated with wish routes
```

## Testing

### Manual Testing Checklist

- [ ] Create a new wish
- [ ] View wish list
- [ ] Filter by status
- [ ] Filter by category
- [ ] Search wishes
- [ ] View wish details
- [ ] Edit wish
- [ ] Update progress
- [ ] Toggle favorite
- [ ] Mark as completed
- [ ] Delete wish
- [ ] View statistics

### Test Data

Use the following test wishes to populate your database:

```dart
final testWishes = [
  WishModel(
    id: '',
    userId: 'test-user',
    title: 'Learn Flutter',
    description: 'Master Flutter development and build amazing apps',
    category: WishCategory.education,
    priority: WishPriority.high,
    status: WishStatus.inProgress,
    progress: 50,
    tags: ['programming', 'mobile'],
    createdAt: DateTime.now(),
  ),
  WishModel(
    id: '',
    userId: 'test-user',
    title: 'Visit Japan',
    description: 'Experience Japanese culture and visit Tokyo',
    category: WishCategory.travel,
    priority: WishPriority.medium,
    status: WishStatus.active,
    tags: ['travel', 'adventure'],
    targetDate: '2026-12-31',
    createdAt: DateTime.now(),
  ),
  // Add more test wishes...
];
```

## Troubleshooting

### Common Issues

**1. "User not authenticated" error**
- Ensure `currentUserIdProvider` is set after user login

**2. Empty wish list**
- Check Firestore security rules
- Verify userId matches authenticated user
- Check Firestore console for data

**3. Code generation errors**
- Run: `flutter pub run build_runner clean`
- Then: `flutter pub run build_runner build --delete-conflicting-outputs`

**4. Provider not found errors**
- Ensure app is wrapped in ProviderScope
- Check import statements

## Future Enhancements

Potential features to add:

1. **Wish Sharing**: Share wishes with friends
2. **Collaboration**: Work on wishes together
3. **Reminders**: Notifications for wish deadlines
4. **Progress Photos**: Upload progress images
5. **Wish Templates**: Predefined wish templates
6. **Export**: Export wishes to PDF/CSV
7. **Analytics**: Advanced analytics and insights
8. **Wish Boards**: Visual boards like Pinterest
9. **AI Suggestions**: AI-powered wish suggestions
10. **Achievements**: Gamification with badges

## Support

For questions or issues:
- Check the existing documentation
- Review the code comments
- Test with sample data
- Check Firebase console logs

## License

This wish management system is part of the Wish Marketplace application.

---

**Built with:**
- Flutter
- Riverpod (State Management)
- Freezed (Immutable Models)
- Firebase Firestore (Database)
- GoRouter (Navigation)
