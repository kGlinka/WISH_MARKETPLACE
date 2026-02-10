# Wear OS Architecture Diagram

## System Architecture Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                         WEAR OS DEVICE                          │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │                     MainActivity.kt                        │ │
│  │  ┌─────────────────────────────────────────────────────┐  │ │
│  │  │        SwipeDismissableNavHost (Navigation)         │  │ │
│  │  │                                                       │  │ │
│  │  │  ┌────────────┐  ┌────────────┐  ┌────────────┐    │  │ │
│  │  │  │   Login    │  │    Home    │  │  Wishes    │    │  │ │
│  │  │  │   Screen   │→│   Screen   │→│   Screen   │    │  │ │
│  │  │  └────────────┘  └────────────┘  └────────────┘    │  │ │
│  │  │                        ↓                             │  │ │
│  │  │  ┌────────────┐  ┌────────────┐  ┌────────────┐    │  │ │
│  │  │  │Marketplace │  │  My Bids   │  │Notifications│   │  │ │
│  │  │  │   Screen   │  │   Screen   │  │   Screen   │    │  │ │
│  │  │  └────────────┘  └────────────┘  └────────────┘    │  │ │
│  │  │                        ↓                             │  │ │
│  │  │  ┌────────────┐  ┌────────────┐  ┌────────────┐    │  │ │
│  │  │  │  Listing   │  │ Place Bid  │  │  Settings  │    │  │ │
│  │  │  │   Detail   │→│   Screen   │  │   Screen   │    │  │ │
│  │  │  └────────────┘  └────────────┘  └────────────┘    │  │ │
│  │  └───────────────────────────────────────────────────┘  │ │
│  └───────────────────────────────────────────────────────────┘ │
│                                                                 │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │                    WearTheme.kt                            │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐   │ │
│  │  │   Colors     │  │  Typography  │  │   Spacing    │   │ │
│  │  │  (AMOLED)    │  │  (Min 14sp)  │  │  (Min 48dp)  │   │ │
│  │  └──────────────┘  └──────────────┘  └──────────────┘   │ │
│  └───────────────────────────────────────────────────────────┘ │
│                                                                 │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │                  FirebaseService.kt                        │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐   │ │
│  │  │    Auth      │  │  Firestore   │  │  Messaging   │   │ │
│  │  │  (Sign In)   │  │  (Queries)   │  │(Push Notif)  │   │ │
│  │  └──────────────┘  └──────────────┘  └──────────────┘   │ │
│  │         ↓                  ↓                  ↓           │ │
│  │  ┌──────────────────────────────────────────────────┐   │ │
│  │  │  Real-time Flow Collections (Kotlin Coroutines)  │   │ │
│  │  └──────────────────────────────────────────────────┘   │ │
│  └───────────────────────────────────────────────────────────┘ │
│                                                                 │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │                    WearModels.kt                           │ │
│  │  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐ │ │
│  │  │WearWish  │  │WearListing│ │ WearBid  │  │WearNotif │ │ │
│  │  │(10 fields)│ │(12 fields)│ │(8 fields)│  │(10 fields)│ │ │
│  │  └──────────┘  └──────────┘  └──────────┘  └──────────┘ │ │
│  └───────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
                              ↑ ↓ Internet
┌─────────────────────────────────────────────────────────────────┐
│                      FIREBASE BACKEND                           │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │                   Firebase Authentication                  │ │
│  │  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐   │ │
│  │  │Email/Password│  │    OAuth     │  │  Anonymous   │   │ │
│  │  └──────────────┘  └──────────────┘  └──────────────┘   │ │
│  └───────────────────────────────────────────────────────────┘ │
│                                                                 │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │                   Cloud Firestore                          │ │
│  │  ┌────────────────────────────────────────────────────┐  │ │
│  │  │  Collection: wishes                                 │  │ │
│  │  │  - userId, title, description, category, priority   │  │ │
│  │  │  - status, progress, targetDate, createdAt          │  │ │
│  │  │  Index: userId ASC, status ASC, createdAt DESC      │  │ │
│  │  └────────────────────────────────────────────────────┘  │ │
│  │  ┌────────────────────────────────────────────────────┐  │ │
│  │  │  Collection: listings                               │  │ │
│  │  │  - title, currentBid, bidIncrement, bidCount        │  │ │
│  │  │  - status, endsAt, createdAt                        │  │ │
│  │  │  Index: status ASC, createdAt DESC                  │  │ │
│  │  └────────────────────────────────────────────────────┘  │ │
│  │  ┌────────────────────────────────────────────────────┐  │ │
│  │  │  Collection: bids                                   │  │ │
│  │  │  - listingId, bidderId, amount, status              │  │ │
│  │  │  - isAutoBid, createdAt                             │  │ │
│  │  │  Index: bidderId ASC, status ASC, createdAt DESC    │  │ │
│  │  └────────────────────────────────────────────────────┘  │ │
│  │  ┌────────────────────────────────────────────────────┐  │ │
│  │  │  Collection: notifications                          │  │ │
│  │  │  - userId, type, title, body, isRead, priority      │  │ │
│  │  │  Index: userId ASC, isRead ASC, createdAt DESC      │  │ │
│  │  └────────────────────────────────────────────────────┘  │ │
│  └───────────────────────────────────────────────────────────┘ │
│                                                                 │
│  ┌───────────────────────────────────────────────────────────┐ │
│  │                   Cloud Messaging (FCM)                    │ │
│  │  Push notifications for bid updates, messages, etc.        │ │
│  └───────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
                              ↑ ↓ Data Sync
┌─────────────────────────────────────────────────────────────────┐
│                   FLUTTER MOBILE APP (Phone)                    │
│  Shares same Firebase backend - data synced in real-time        │
└─────────────────────────────────────────────────────────────────┘
```

## Component Architecture

```
┌───────────────────────────────────────────────────────────────┐
│                    PRESENTATION LAYER                          │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │                      Screens                             │  │
│  │  - @Composable functions                                 │  │
│  │  - State management with remember/mutableStateOf         │  │
│  │  - Collect Flows with collectAsState()                   │  │
│  │  - Navigation with NavController                         │  │
│  └─────────────────────────────────────────────────────────┘  │
│                            ↓                                   │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │                   UI Components                          │  │
│  │  - WishCard, ListingCard, BidCard                        │  │
│  │  - ProgressBar, Badge, NotificationIcon                  │  │
│  │  - Reusable Chips, Cards, Buttons                        │  │
│  └─────────────────────────────────────────────────────────┘  │
│                            ↓                                   │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │                    Theme System                          │  │
│  │  - WearColors (AMOLED optimized)                         │  │
│  │  - WearTypography (14sp minimum)                         │  │
│  │  - WearSpacing (48dp min touch)                          │  │
│  └─────────────────────────────────────────────────────────┘  │
└───────────────────────────────────────────────────────────────┘
                            ↓ Uses
┌───────────────────────────────────────────────────────────────┐
│                      DATA LAYER                                │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │                  FirebaseService                         │  │
│  │  - Singleton instance                                    │  │
│  │  - Coroutine-based suspend functions                     │  │
│  │  - Flow emissions for real-time updates                 │  │
│  │  - Result<T> for error handling                          │  │
│  └─────────────────────────────────────────────────────────┘  │
│                            ↓                                   │
│  ┌─────────────────────────────────────────────────────────┐  │
│  │                    Data Models                           │  │
│  │  - Kotlin data classes                                   │  │
│  │  - Simplified fields (10-15 vs 20+ in main app)         │  │
│  │  - Computed properties for formatting                    │  │
│  │  - Firebase annotations (@DocumentId)                    │  │
│  └─────────────────────────────────────────────────────────┘  │
└───────────────────────────────────────────────────────────────┘
```

## Data Flow Diagram

```
USER INTERACTION
      ↓
┌──────────────────┐
│  Screen Event    │  (e.g., button click)
└──────────────────┘
      ↓
┌──────────────────┐
│  Coroutine       │  launch { ... }
│  Scope           │
└──────────────────┘
      ↓
┌──────────────────┐
│ FirebaseService  │  suspend fun placeBid(...)
│    Method        │
└──────────────────┘
      ↓
┌──────────────────┐
│  Firebase SDK    │  firestore.collection().add()
└──────────────────┘
      ↓
┌──────────────────┐
│    Internet      │
└──────────────────┘
      ↓
┌──────────────────┐
│  Cloud           │  Firestore Database
│  Firestore       │
└──────────────────┘
      ↓ (Real-time listener)
┌──────────────────┐
│  Flow Emission   │  Flow<List<WearBid>>
└──────────────────┘
      ↓
┌──────────────────┐
│  collectAsState()│  val bids by flow.collectAsState()
└──────────────────┘
      ↓
┌──────────────────┐
│  Recomposition   │  UI updates automatically
└──────────────────┘
      ↓
    USER SEES UPDATE
```

## Navigation Flow

```
                    ┌──────────────┐
                    │ App Launch   │
                    └──────┬───────┘
                           ↓
                    ┌──────────────┐
                    │ Check Auth   │
                    └──────┬───────┘
                           ↓
              ┌────────────┴────────────┐
              ↓                         ↓
      ┌──────────────┐          ┌──────────────┐
      │ Not Logged In│          │  Logged In   │
      └──────┬───────┘          └──────┬───────┘
             ↓                          ↓
      ┌──────────────┐          ┌──────────────┐
      │ LoginScreen  │          │  HomeScreen  │
      └──────┬───────┘          └──────┬───────┘
             │                          │
             │  Sign In Success         │
             └───────────┬──────────────┘
                         ↓
                  ┌──────────────┐
                  │  HomeScreen  │
                  └──────┬───────┘
                         │
         ┌───────────────┼───────────────┐
         ↓               ↓               ↓
   ┌──────────┐   ┌──────────┐   ┌──────────┐
   │ Wishes   │   │Marketplace│  │My Bids   │
   └────┬─────┘   └────┬─────┘   └────┬─────┘
        │              │              │
        ↓              ↓              │
   ┌──────────┐   ┌──────────┐       │
   │  Wish    │   │ Listing  │       │
   │  Detail  │   │  Detail  │       │
   └──────────┘   └────┬─────┘       │
                       ↓              │
                  ┌──────────┐        │
                  │Place Bid │        │
                  └────┬─────┘        │
                       ↓              ↓
                  ┌──────────────────────┐
                  │ Listing Detail       │
                  │ (from My Bids)       │
                  └──────────────────────┘

      Swipe from left edge: Go back to previous screen
```

## Screen Lifecycle

```
Screen Creation
      ↓
┌──────────────────┐
│  @Composable     │  Function called
│  Screen()        │
└──────────────────┘
      ↓
┌──────────────────┐
│  remember {}     │  Create local state
└──────────────────┘
      ↓
┌──────────────────┐
│ LaunchedEffect   │  Trigger data load
└──────────────────┘
      ↓
┌──────────────────┐
│ Collect Flow     │  Subscribe to real-time updates
└──────────────────┘
      ↓
┌──────────────────┐
│ Render UI        │  Display data
└──────────────────┘
      ↓
┌──────────────────┐
│ User Interaction │  Updates trigger recomposition
└──────────────────┘
      ↓
┌──────────────────┐
│ Screen Disposed  │  Flow collectors cleaned up
└──────────────────┘
```

## State Management Pattern

```
Screen Level:
  ├─ var loading by remember { mutableStateOf(true) }
  ├─ var error by remember { mutableStateOf<String?>(null) }
  ├─ val data by flow.collectAsState(initial = emptyList())
  └─ val scope = rememberCoroutineScope()

User Action:
  └─ Button.onClick { scope.launch { firebaseService.action() } }

Firebase:
  └─ suspend fun action(): Result<T>
      ├─ Success: Result.success(data)
      └─ Failure: Result.failure(exception)

UI Update:
  └─ .onSuccess { data = it }
      .onFailure { error = it.message }
```

## Firebase Query Optimization

```
Standard Query (Mobile App):
  └─ collection("wishes")
      .whereEqualTo("userId", uid)
      .orderBy("createdAt", DESCENDING)
      .get()  // Gets ALL documents

Wear OS Optimized Query:
  └─ collection("wishes")
      .whereEqualTo("userId", uid)
      .whereEqualTo("status", "active")  // Additional filter
      .orderBy("createdAt", DESCENDING)
      .limit(10)  // Only get 10 items
      .addSnapshotListener()  // Real-time updates

Benefits:
  ├─ Reduced data transfer
  ├─ Faster initial load
  ├─ Lower battery usage
  └─ Better UX on small screen
```

## Component Hierarchy Example (WishCard)

```
Card (Wear Compose Material)
  └─ onClick: Navigate to detail
  └─ backgroundPainter: Custom gradient
  └─ Column
      ├─ Row (Title & Priority)
      │   ├─ Text (Title, weight 1f)
      │   └─ Box (Priority dot, 8dp circle)
      ├─ Spacer (4dp)
      ├─ Text (Category, caption)
      ├─ Spacer (8dp)
      └─ ProgressBar (Custom component)
          ├─ Row (Label & Percentage)
          └─ Box (Progress track)
              └─ Box (Progress fill, color-coded)
```

## Build Process

```
Source Code (.kt files)
      ↓
Kotlin Compiler
      ↓
Bytecode (.class files)
      ↓
R8/ProGuard (Release only)
      ↓ Minify & Optimize
Optimized Bytecode
      ↓
DEX Compiler
      ↓
DEX files (.dex)
      ↓
Packager
      ↓ Combine with resources
APK/AAB
      ↓
Signing (Release key)
      ↓
Signed APK/AAB
      ↓ Deploy
Google Play Store / Direct Install
```

## Performance Optimization Stack

```
UI Layer:
  ├─ ScalingLazyColumn (Lazy composition)
  ├─ remember {} (Avoid recomposition)
  ├─ LaunchedEffect (Controlled side effects)
  └─ collectAsState (Efficient Flow collection)

Data Layer:
  ├─ Flow (Cold streams, auto cleanup)
  ├─ Coroutines (Structured concurrency)
  ├─ Result<T> (Type-safe error handling)
  └─ .limit(10) (Query optimization)

Theme Layer:
  ├─ True Black (#000000 - AMOLED pixels off)
  ├─ Minimal animations (Battery saving)
  └─ Efficient color objects (Reused instances)

Network Layer:
  ├─ Firebase SDK caching
  ├─ Real-time listeners (Only active when needed)
  └─ Simplified data models (Less data transfer)
```

## Security Architecture

```
Client Side (Wear OS):
  ├─ No sensitive data stored locally
  ├─ Auth tokens managed by Firebase SDK
  ├─ HTTPS only (enforced by Firebase)
  └─ Input validation before sending

Network:
  ├─ TLS 1.3 encryption
  ├─ Certificate pinning (recommended)
  └─ Firebase security rules validation

Server Side (Firebase):
  ├─ Authentication required for all operations
  ├─ User can only access their own data
  ├─ Firestore security rules enforce permissions
  └─ Rate limiting (Firebase built-in)
```

## Testing Architecture

```
Unit Tests:
  ├─ WearModels (Data class properties)
  ├─ Currency formatting
  ├─ Time remaining calculations
  └─ Status color mappings

Integration Tests:
  ├─ FirebaseService operations
  ├─ Mock Firebase with test data
  └─ Verify query results

UI Tests:
  ├─ Compose testing framework
  ├─ Verify UI renders correctly
  ├─ Test user interactions
  └─ Verify navigation flows

Device Tests:
  ├─ Round display compatibility
  ├─ Square display compatibility
  ├─ Touch target sizes
  └─ Performance profiling
```

## Deployment Pipeline

```
Development:
  ├─ Write code
  ├─ Local testing on emulator
  └─ Debug builds

Staging:
  ├─ Build release APK
  ├─ Test on physical devices
  ├─ Firebase staging environment
  └─ Internal testing

Production:
  ├─ Generate signed AAB
  ├─ Upload to Play Console
  ├─ Internal testing track
  ├─ Beta testing track
  ├─ Production release
  └─ Monitor crash reports
```

---

**Architecture Version**: 1.0
**Last Updated**: January 2026
**Complexity**: Production-ready architecture optimized for Wear OS constraints
