# Provider Bidding System - Quick Start Guide

## Getting Started

This guide will help you quickly set up and use the Provider Bidding System.

## Prerequisites

1. Flutter SDK installed
2. Firebase project configured
3. Firestore database created
4. Authentication enabled

## Installation Steps

### 1. Deploy Firestore Indexes

```bash
firebase deploy --only firestore:indexes
```

This will create the necessary composite indexes for efficient bid queries.

### 2. Update Firestore Rules

The existing rules in `firestore.rules` already support the bidding system. Ensure they are deployed:

```bash
firebase deploy --only firestore:rules
```

### 3. Run Code Generation

Generate the necessary Freezed and JSON serialization code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Usage Guide

### For Providers (Service Providers)

#### 1. Browse Available Wishes

Navigate to the Available Wishes page:
```dart
context.push('/available-wishes');
```

Features:
- Search wishes by keywords
- Filter by category (Personal Growth, Travel, Career, etc.)
- Filter by priority (Low, Medium, High, Urgent)
- View current highest bid on each wish
- See real-time updates when new wishes are posted

#### 2. Submit a Bid

Tap on any wish card to open the bid submission page:
```dart
context.push('/wishes/{wishId}/bid');
```

Steps:
1. Review the wish details
2. Check the current highest bid (if any)
3. Enter your bid amount in dollars
4. Optionally add a message explaining your bid
5. Tap "Submit Bid"

Validations:
- Cannot bid on your own wishes
- Bid amount must be positive
- One active bid per wish per provider

#### 3. Manage Your Bids

Navigate to My Bids page:
```dart
context.push('/my-bids');
```

Features:
- View all your bids
- Filter by status (All, Active, Winning, Won, Lost, Cancelled)
- Real-time status updates
- Withdraw active bids
- Navigate to wish details

### For Customers (Wish Owners)

#### 1. View Bids on Your Wish

When viewing your wish details, you'll see a bids section showing:
- Total number of bids
- All bids ranked by amount
- Provider messages
- Bid timestamps

#### 2. Accept a Bid

Steps:
1. Navigate to your wish details
2. Review all bids in the bids section
3. Click "Accept Highest Bid"
4. Confirm acceptance in the dialog
5. The wish status changes to "In Progress"
6. Other bids are marked as "Lost"

## Code Examples

### Check if Provider Has Bid on Wish

```dart
final hasBid = ref.watch(hasProviderBidProvider(wishId));

hasBid.when(
  data: (exists) => exists
    ? Text('You already bid on this')
    : SubmitBidButton(),
  loading: () => CircularProgressIndicator(),
  error: (_, __) => ErrorWidget(),
);
```

### Stream Provider's Bids

```dart
final bidsAsync = ref.watch(providerBidsStreamProvider);

bidsAsync.when(
  data: (bids) => ListView.builder(
    itemCount: bids.length,
    itemBuilder: (context, index) {
      return BidCard(bid: bids[index]);
    },
  ),
  loading: () => CircularProgressIndicator(),
  error: (error, _) => ErrorWidget(error),
);
```

### Submit a Bid

```dart
final bidFormNotifier = ref.read(bidFormProvider.notifier);

await bidFormNotifier.submitBid(
  wishId: wishId,
  bid: BidModel(
    id: '',
    listingId: wishId,
    bidderId: currentUserId,
    amount: (amount * 100).round(), // Convert to cents
    status: BidStatus.active,
    message: message,
    createdAt: DateTime.now(),
  ),
);

final state = ref.read(bidFormProvider);
if (state.error != null) {
  // Show error
} else if (state.successMessage != null) {
  // Show success
}
```

### Withdraw a Bid

```dart
await bidFormNotifier.cancelBid(
  wishId: wishId,
  bidId: bidId,
  reason: 'Changed my mind',
);
```

### Accept a Bid (Wish Owner)

```dart
await bidFormNotifier.acceptBid(
  wishId: wishId,
  bidId: bidId,
);
```

## Real-Time Updates

All bid-related data uses Firestore streams for real-time updates:

### Watch Bids on a Wish
```dart
final bidsStream = ref.watch(wishBidsStreamProvider(wishId));
```

### Watch Highest Bid
```dart
final highestBidStream = ref.watch(highestBidStreamProvider(wishId));
```

### Watch Provider's Bids
```dart
final myBidsStream = ref.watch(providerBidsStreamProvider);
```

These streams automatically update the UI when:
- New bids are placed
- Bids are withdrawn
- Bid statuses change
- Bids are accepted

## UI Components

### WishBidCard

Display a wish with bidding information:

```dart
WishBidCard(
  wish: wish,
  onTap: () => context.push('/wishes/${wish.id}/bid'),
)
```

### BidCard

Display an individual bid:

```dart
BidCard(
  bid: bid,
  showWishDetails: true,
  showActions: true,
)
```

### BidListWidget

Display a list of bids:

```dart
BidListWidget(
  bids: bids,
  wishId: wishId,
  showActions: false,
)
```

### WishBidsSection

Display bids section in wish details:

```dart
WishBidsSection(
  wishId: wishId,
  wishOwnerId: wish.userId,
)
```

## Filtering and Searching

### Filter Bids by Status

```dart
ref.read(selectedBidFilterProvider.notifier).state = BidFilter.active;

final filteredBids = ref.watch(filteredProviderBidsStreamProvider);
```

Available filters:
- `BidFilter.all` - All bids
- `BidFilter.active` - Active bids
- `BidFilter.winning` - Currently winning bids
- `BidFilter.won` - Won bids
- `BidFilter.lost` - Lost bids
- `BidFilter.cancelled` - Cancelled bids

### Search Wishes

In AvailableWishesPage, use the search bar:
```dart
TextField(
  onChanged: (query) => setState(() => _searchQuery = query),
  decoration: InputDecoration(
    hintText: 'Search wishes...',
    prefixIcon: Icon(Icons.search),
  ),
)
```

## Bid Statuses Explained

| Status | Description |
|--------|-------------|
| `active` | Bid is live and competing |
| `outbid` | Another provider bid higher |
| `winning` | Currently the highest bid |
| `won` | Your bid was accepted |
| `lost` | Another bid was accepted |
| `cancelled` | You withdrew the bid |
| `expired` | Wish deadline passed |

## Error Handling

All operations return proper error states:

```dart
final state = ref.read(bidFormProvider);

if (state.isLoading) {
  // Show loading indicator
} else if (state.error != null) {
  // Show error message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(state.error!)),
  );
} else if (state.successMessage != null) {
  // Show success message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(state.successMessage!)),
  );
}
```

## Navigation Routes

### Available Wishes
```dart
context.push('/available-wishes');
```

### Bid Submission
```dart
context.push('/wishes/{wishId}/bid');
```

### My Bids
```dart
context.push('/my-bids');
// or
context.push('/provider-bids');
```

### Wish Details
```dart
context.push('/wish/{wishId}');
```

## Testing Your Implementation

### 1. Create a Test Wish

```dart
// As a customer
final wish = WishModel(
  id: '',
  userId: customerId,
  title: 'Test Wish',
  description: 'Test description',
  category: WishCategory.travel,
  priority: WishPriority.medium,
  status: WishStatus.active,
  isPublic: true, // Important!
  createdAt: DateTime.now(),
);

await wishRepository.createWish(wish);
```

### 2. Browse as Provider

Navigate to `/available-wishes` and verify the wish appears.

### 3. Submit a Bid

Open the wish and submit a test bid:
```dart
BidModel(
  id: '',
  listingId: wishId,
  bidderId: providerId,
  amount: 5000, // $50.00 in cents
  status: BidStatus.active,
  message: 'Test bid',
  createdAt: DateTime.now(),
)
```

### 4. Verify Real-Time Updates

Open the wish in another device/browser and submit another bid. Verify the first device shows the update immediately.

### 5. Accept a Bid

As the wish owner, accept the highest bid and verify:
- Bid status changes to `won`
- Other bids change to `lost`
- Wish status changes to `inProgress`

## Troubleshooting

### Bids Not Showing

Check:
1. Wish has `isPublic: true`
2. Wish status is `active`
3. Firestore rules allow read access
4. User is authenticated

### Cannot Submit Bid

Check:
1. Not bidding on own wish
2. No existing active bid
3. Valid bid amount
4. User is authenticated

### Real-Time Updates Not Working

Check:
1. Firestore indexes deployed
2. Internet connection active
3. Firestore rules allow read access
4. Stream providers are being watched

### Transaction Failed

Check:
1. Wish still exists
2. Network connection stable
3. Firestore rules allow write access
4. No concurrent transaction conflicts

## Best Practices

1. **Always validate input** before submitting bids
2. **Use real-time streams** for live updates
3. **Handle errors gracefully** with user-friendly messages
4. **Dispose streams** when not needed (auto-dispose providers)
5. **Use transactions** for critical operations
6. **Index queries** for performance
7. **Show loading states** during async operations
8. **Provide feedback** for all user actions

## Next Steps

1. Explore the full documentation in `PROVIDER_BIDDING_SYSTEM.md`
2. Customize UI components to match your design
3. Add notifications for bid status changes
4. Implement bid analytics and reporting
5. Add payment integration for accepted bids

## Support

For issues or questions:
1. Check `PROVIDER_BIDDING_SYSTEM.md` for detailed documentation
2. Review the inline code comments
3. Check Firebase Console for data verification
4. Review Firestore rules and indexes

Happy bidding!
