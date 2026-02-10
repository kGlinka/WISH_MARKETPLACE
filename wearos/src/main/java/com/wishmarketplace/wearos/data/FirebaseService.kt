package com.wishmarketplace.wearos.data

import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.auth.FirebaseUser
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.firestore.Query
import com.wishmarketplace.wearos.models.*
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import kotlinx.coroutines.tasks.await

/**
 * Firebase service for Wear OS
 * Handles all Firebase interactions with optimized data loading for smartwatch constraints
 */
class FirebaseService {
    private val auth: FirebaseAuth = FirebaseAuth.getInstance()
    private val firestore: FirebaseFirestore = FirebaseFirestore.getInstance()

    // Collection references
    private val wishesCollection = firestore.collection("wishes")
    private val listingsCollection = firestore.collection("listings")
    private val bidsCollection = firestore.collection("bids")
    private val notificationsCollection = firestore.collection("notifications")

    /**
     * Get current authenticated user
     */
    fun getCurrentUser(): FirebaseUser? = auth.currentUser

    /**
     * Get current user ID
     */
    fun getCurrentUserId(): String? = auth.currentUser?.uid

    /**
     * Check if user is logged in
     */
    fun isLoggedIn(): Boolean = auth.currentUser != null

    /**
     * Sign in with email and password
     * Returns user ID on success, null on failure
     */
    suspend fun signIn(email: String, password: String): Result<String> {
        return try {
            val result = auth.signInWithEmailAndPassword(email, password).await()
            result.user?.uid?.let { userId ->
                Result.success(userId)
            } ?: Result.failure(Exception("User ID not found"))
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    /**
     * Sign out current user
     */
    fun signOut() {
        auth.signOut()
    }

    /**
     * Get user's active wishes as Flow
     * Limited to 10 most recent for performance
     */
    fun getUserWishes(userId: String): Flow<List<WearWish>> = callbackFlow {
        val listener = wishesCollection
            .whereEqualTo("userId", userId)
            .whereEqualTo("status", "active")
            .orderBy("createdAt", Query.Direction.DESCENDING)
            .limit(10)
            .addSnapshotListener { snapshot, error ->
                if (error != null) {
                    close(error)
                    return@addSnapshotListener
                }
                val wishes = snapshot?.documents?.mapNotNull { doc ->
                    doc.toObject(WearWish::class.java)
                } ?: emptyList()
                trySend(wishes)
            }
        awaitClose { listener.remove() }
    }

    /**
     * Get single wish by ID
     */
    suspend fun getWish(wishId: String): Result<WearWish> {
        return try {
            val doc = wishesCollection.document(wishId).get().await()
            val wish = doc.toObject(WearWish::class.java)
            wish?.let { Result.success(it) }
                ?: Result.failure(Exception("Wish not found"))
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    /**
     * Update wish progress
     */
    suspend fun updateWishProgress(wishId: String, progress: Int): Result<Unit> {
        return try {
            wishesCollection.document(wishId)
                .update("progress", progress)
                .await()
            Result.success(Unit)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    /**
     * Get active marketplace listings
     * Limited to 20 for performance on watch
     */
    fun getActiveListings(): Flow<List<WearListing>> = callbackFlow {
        val listener = listingsCollection
            .whereEqualTo("status", "active")
            .orderBy("createdAt", Query.Direction.DESCENDING)
            .limit(20)
            .addSnapshotListener { snapshot, error ->
                if (error != null) {
                    close(error)
                    return@addSnapshotListener
                }
                val listings = snapshot?.documents?.mapNotNull { doc ->
                    doc.toObject(WearListing::class.java)
                } ?: emptyList()
                trySend(listings)
            }
        awaitClose { listener.remove() }
    }

    /**
     * Get single listing by ID
     */
    suspend fun getListing(listingId: String): Result<WearListing> {
        return try {
            val doc = listingsCollection.document(listingId).get().await()
            val listing = doc.toObject(WearListing::class.java)
            listing?.let { Result.success(it) }
                ?: Result.failure(Exception("Listing not found"))
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    /**
     * Get user's active bids
     * Limited to 10 most recent
     */
    fun getUserBids(userId: String): Flow<List<WearBid>> = callbackFlow {
        val listener = bidsCollection
            .whereEqualTo("bidderId", userId)
            .whereIn("status", listOf("active", "winning", "outbid"))
            .orderBy("createdAt", Query.Direction.DESCENDING)
            .limit(10)
            .addSnapshotListener { snapshot, error ->
                if (error != null) {
                    close(error)
                    return@addSnapshotListener
                }
                val bids = snapshot?.documents?.mapNotNull { doc ->
                    doc.toObject(WearBid::class.java)
                } ?: emptyList()
                trySend(bids)
            }
        awaitClose { listener.remove() }
    }

    /**
     * Place a new bid
     */
    suspend fun placeBid(
        listingId: String,
        amount: Int,
        message: String? = null
    ): Result<String> {
        return try {
            val userId = getCurrentUserId()
                ?: return Result.failure(Exception("Not logged in"))

            val bid = hashMapOf(
                "listingId" to listingId,
                "bidderId" to userId,
                "amount" to amount,
                "status" to "active",
                "message" to message,
                "isAutoBid" to false,
                "createdAt" to com.google.firebase.Timestamp.now()
            )

            val docRef = bidsCollection.add(bid).await()
            Result.success(docRef.id)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    /**
     * Get user's unread notifications
     * Limited to 10 most recent
     */
    fun getUserNotifications(userId: String): Flow<List<WearNotification>> = callbackFlow {
        val listener = notificationsCollection
            .whereEqualTo("userId", userId)
            .whereEqualTo("isRead", false)
            .orderBy("createdAt", Query.Direction.DESCENDING)
            .limit(10)
            .addSnapshotListener { snapshot, error ->
                if (error != null) {
                    close(error)
                    return@addSnapshotListener
                }
                val notifications = snapshot?.documents?.mapNotNull { doc ->
                    doc.toObject(WearNotification::class.java)
                } ?: emptyList()
                trySend(notifications)
            }
        awaitClose { listener.remove() }
    }

    /**
     * Mark notification as read
     */
    suspend fun markNotificationAsRead(notificationId: String): Result<Unit> {
        return try {
            notificationsCollection.document(notificationId)
                .update("isRead", true)
                .await()
            Result.success(Unit)
        } catch (e: Exception) {
            Result.failure(e)
        }
    }

    /**
     * Get trending wishes (public, high engagement)
     * Limited to 10 for performance
     */
    fun getTrendingWishes(): Flow<List<WearWish>> = callbackFlow {
        val listener = wishesCollection
            .whereEqualTo("isPublic", true)
            .whereEqualTo("status", "active")
            .orderBy("createdAt", Query.Direction.DESCENDING)
            .limit(10)
            .addSnapshotListener { snapshot, error ->
                if (error != null) {
                    close(error)
                    return@addSnapshotListener
                }
                val wishes = snapshot?.documents?.mapNotNull { doc ->
                    doc.toObject(WearWish::class.java)
                } ?: emptyList()
                trySend(wishes)
            }
        awaitClose { listener.remove() }
    }
}
