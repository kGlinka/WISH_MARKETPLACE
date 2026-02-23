# Wear OS ProGuard Rules

# Keep Compose classes
-keep class androidx.compose.** { *; }
-keepclassmembers class androidx.compose.** { *; }

# Keep Wear OS Compose classes
-keep class androidx.wear.compose.** { *; }
-keepclassmembers class androidx.wear.compose.** { *; }

# Keep Firebase classes
-keep class com.google.firebase.** { *; }
-keepclassmembers class com.google.firebase.** { *; }

# Keep Firestore model classes
-keep class com.wishmarketplace.wearos.models.** { *; }
-keepclassmembers class com.wishmarketplace.wearos.models.** { *; }

# Keep data classes for serialization
-keepclassmembers class * {
    @com.google.firebase.firestore.PropertyName <fields>;
}

# Keep Kotlin coroutines
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}

# Keep Coil image loading
-keep class coil.** { *; }
