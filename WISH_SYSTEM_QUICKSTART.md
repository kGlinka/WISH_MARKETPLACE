# Wish Management System - Quick Start Guide

## Getting Started in 5 Minutes

### Step 1: Set User ID

After user authentication, set the current user ID:

```dart
// In your login success handler
ref.read(currentUserIdProvider.notifier).state = firebaseUser.uid;
```

### Step 2: Navigate to Wishes

From anywhere in the app:

```dart
context.push(AppConstants.wishesRoute);
```

Or from the home page, tap on "My Wishes" card.

### Step 3: Create Your First Wish

1. Tap the "New Wish" floating action button
2. Fill in the form:
   - Title (required): "Learn Flutter"
   - Description (required): "Master Flutter development"
   - Category: Education
   - Priority: High
   - Status: Active
3. Tap "Create Wish"

### Step 4: Manage Your Wishes

**View Details:**
- Tap any wish card to see full details

**Edit Wish:**
- Open wish details
- Tap the menu icon (three dots)
- Select "Edit"

**Update Progress:**
- Open wish details
- Use the progress slider
- Progress automatically saves

**Mark as Completed:**
- Open wish details
- Tap "Mark Complete" button at bottom

**Delete Wish:**
- Open wish details
- Tap menu icon
- Select "Delete"
- Confirm deletion

### Step 5: Filter & Organize

**Filter by Status:**
- Tap filter icon in wish list
- Select status chip (All, Active, In Progress, Completed, etc.)

**Filter by Category:**
- Tap filter icon
- Select category chip

**Search:**
- Tap search icon
- Enter search query
- Results show matching wishes

**View Statistics:**
- Tap statistics icon
- See overview of all your wishes

## Common Operations

### Create Wish with All Details

```dart
final wish = WishModel(
  id: '',
  userId: currentUserId,
  title: 'Travel to Japan',
  description: 'Experience Japanese culture, visit Tokyo, Kyoto, and Osaka',
  category: WishCategory.travel,
  priority: WishPriority.high,
  status: WishStatus.active,
  tags: ['travel', 'adventure', 'culture'],
  prerequisites: [
    'Get passport',
    'Save money',
    'Learn basic Japanese',
  ],
  targetDate: '2026-12-31',
  notes: 'Budget: $5000',
  metadata: WishMetadata(
    inspiration: 'Always wanted to see cherry blossoms',
    motivation: 'Experience different culture and expand worldview',
  ),
  createdAt: DateTime.now(),
);

await ref.read(wishFormProvider.notifier).createWish(wish);
```

### Quick Progress Update

```dart
await ref.read(wishActionsProvider.notifier)
  .updateProgress(wishId, 75);
```

### Toggle Favorite

```dart
await ref.read(wishActionsProvider.notifier)
  .toggleFavorite(wishId, true);
```

### Get Statistics

```dart
final stats = await ref.read(wishStatisticsProvider.future);
print('Total wishes: ${stats.totalWishes}');
print('Completed: ${stats.completedWishes}');
```

## Tips & Tricks

1. **Use Tags**: Add tags to wishes for easy searching
2. **Set Target Dates**: Helps track time-sensitive goals
3. **Break Down Big Wishes**: Use prerequisites for complex wishes
4. **Update Progress Regularly**: Keep track of your journey
5. **Favorite Important Wishes**: Quick access to priority wishes
6. **Use Categories**: Organize by life area
7. **Add Notes**: Document thoughts and learnings
8. **Celebrate Completions**: Don't forget to mark wishes complete!

## Widget Integration

### Display Wishes in Your UI

```dart
class MyCustomWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishesAsync = ref.watch(userWishesStreamProvider);

    return wishesAsync.when(
      data: (wishes) => ListView.builder(
        itemCount: wishes.length,
        itemBuilder: (context, index) {
          return WishCard(
            wish: wishes[index],
            onTap: () => context.push(
              '${AppConstants.wishDetailsRoute}/${wishes[index].id}',
            ),
          );
        },
      ),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => Text('Error: $error'),
    );
  }
}
```

### Filter Wishes by Category

```dart
final travelWishes = ref.watch(
  wishesByCategoryProvider(WishCategory.travel)
);
```

### Filter by Status

```dart
final activeWishes = ref.watch(
  wishesByStatusProvider(WishStatus.active)
);
```

## Firebase Setup

### Add Firestore Rules

In `firestore.rules`, add:

```javascript
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

### Deploy Rules

```bash
firebase deploy --only firestore:rules
```

### Create Indexes

The app will prompt you to create indexes when needed, or manually deploy:

```bash
firebase deploy --only firestore:indexes
```

## Troubleshooting

### Issue: Wishes not showing

**Solution:**
1. Check if user ID is set: `ref.read(currentUserIdProvider)`
2. Verify Firebase authentication
3. Check Firestore security rules
4. Look at Firebase console for data

### Issue: Can't create wishes

**Solution:**
1. Verify user is authenticated
2. Check Firestore security rules allow create
3. Check form validation passes
4. Look for errors in console

### Issue: Code generation errors

**Solution:**
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

## Next Steps

1. **Customize Categories**: Add or modify wish categories
2. **Add Milestones**: Implement milestone tracking
3. **Create Templates**: Build wish templates for common goals
4. **Add Reminders**: Integrate notifications
5. **Share Wishes**: Implement sharing functionality

## Key Files Reference

```
Core Model:
  lib/core/models/wish_model.dart

Service:
  lib/features/wishes/data/services/wish_service.dart

Repository:
  lib/features/wishes/data/repositories/wish_repository.dart

Providers:
  lib/features/wishes/presentation/providers/wish_providers.dart

Pages:
  lib/features/wishes/presentation/pages/wish_list_page.dart
  lib/features/wishes/presentation/pages/wish_detail_page.dart
  lib/features/wishes/presentation/pages/wish_form_page.dart

Widgets:
  lib/features/wishes/presentation/widgets/wish_card.dart
  lib/features/wishes/presentation/widgets/wish_filter_chips.dart
  lib/features/wishes/presentation/widgets/wish_statistics_card.dart
```

## Example Workflow

```dart
// 1. User logs in
final user = await signIn(email, password);
ref.read(currentUserIdProvider.notifier).state = user.uid;

// 2. Navigate to wishes
context.push(AppConstants.wishesRoute);

// 3. Create wish
context.push(AppConstants.createWishRoute);
// Fill form and submit

// 4. View wish details
context.push('${AppConstants.wishDetailsRoute}/$wishId');

// 5. Update progress
await ref.read(wishActionsProvider.notifier)
  .updateProgress(wishId, 50);

// 6. Mark complete
await ref.read(wishActionsProvider.notifier)
  .markCompleted(wishId);
```

---

**You're all set!** Start managing your wishes and achieving your dreams.
