import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/logger.dart';
import '../errors/exceptions.dart' as app_exceptions;

/// Generic Firestore service for CRUD operations
///
/// Provides type-safe methods for interacting with Firestore collections
class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get a document by ID
  Future<Map<String, dynamic>?> getDocument({
    required String collection,
    required String documentId,
  }) async {
    try {
      AppLogger.debug('Getting document: $collection/$documentId');

      final doc = await _firestore.collection(collection).doc(documentId).get();

      if (!doc.exists) {
        return null;
      }

      return doc.data();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get document', e, stackTrace);
      throw app_exceptions.FirestoreException(
        message: 'Failed to get document: ${e.toString()}',
      );
    }
  }

  /// Get documents with query
  Future<List<Map<String, dynamic>>> getDocuments({
    required String collection,
    Map<String, dynamic>? where,
    String? orderBy,
    bool descending = false,
    int? limit,
  }) async {
    try {
      AppLogger.debug('Getting documents from: $collection');

      Query query = _firestore.collection(collection);

      // Apply where clauses
      if (where != null) {
        where.forEach((field, value) {
          query = query.where(field, isEqualTo: value);
        });
      }

      // Apply ordering
      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }

      // Apply limit
      if (limit != null) {
        query = query.limit(limit);
      }

      final snapshot = await query.get();

      return snapshot.docs
          .map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id})
          .toList();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get documents', e, stackTrace);
      throw app_exceptions.FirestoreException(
        message: 'Failed to get documents: ${e.toString()}',
      );
    }
  }

  /// Stream a document
  Stream<Map<String, dynamic>?> streamDocument({
    required String collection,
    required String documentId,
  }) {
    try {
      AppLogger.debug('Streaming document: $collection/$documentId');

      return _firestore
          .collection(collection)
          .doc(documentId)
          .snapshots()
          .map((doc) => doc.exists ? doc.data() : null);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to stream document', e, stackTrace);
      throw app_exceptions.FirestoreException(
        message: 'Failed to stream document: ${e.toString()}',
      );
    }
  }

  /// Stream documents with query
  Stream<List<Map<String, dynamic>>> streamDocuments({
    required String collection,
    Map<String, dynamic>? where,
    String? orderBy,
    bool descending = false,
    int? limit,
  }) {
    try {
      AppLogger.debug('Streaming documents from: $collection');

      Query query = _firestore.collection(collection);

      // Apply where clauses
      if (where != null) {
        where.forEach((field, value) {
          query = query.where(field, isEqualTo: value);
        });
      }

      // Apply ordering
      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }

      // Apply limit
      if (limit != null) {
        query = query.limit(limit);
      }

      return query.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id})
          .toList());
    } catch (e, stackTrace) {
      AppLogger.error('Failed to stream documents', e, stackTrace);
      throw app_exceptions.FirestoreException(
        message: 'Failed to stream documents: ${e.toString()}',
      );
    }
  }

  /// Create a document
  Future<String> createDocument({
    required String collection,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      AppLogger.debug('Creating document in: $collection');

      // Add server timestamp
      final dataWithTimestamp = {
        ...data,
        'createdAt': FieldValue.serverTimestamp(),
      };

      if (documentId != null) {
        await _firestore
            .collection(collection)
            .doc(documentId)
            .set(dataWithTimestamp);
        return documentId;
      } else {
        final docRef =
            await _firestore.collection(collection).add(dataWithTimestamp);
        return docRef.id;
      }
    } catch (e, stackTrace) {
      AppLogger.error('Failed to create document', e, stackTrace);
      throw app_exceptions.FirestoreException(
        message: 'Failed to create document: ${e.toString()}',
      );
    }
  }

  /// Update a document
  Future<void> updateDocument({
    required String collection,
    required String documentId,
    required Map<String, dynamic> data,
  }) async {
    try {
      AppLogger.debug('Updating document: $collection/$documentId');

      // Add update timestamp
      final dataWithTimestamp = {
        ...data,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      await _firestore
          .collection(collection)
          .doc(documentId)
          .update(dataWithTimestamp);
    } catch (e, stackTrace) {
      AppLogger.error('Failed to update document', e, stackTrace);
      throw app_exceptions.FirestoreException(
        message: 'Failed to update document: ${e.toString()}',
      );
    }
  }

  /// Delete a document
  Future<void> deleteDocument({
    required String collection,
    required String documentId,
  }) async {
    try {
      AppLogger.debug('Deleting document: $collection/$documentId');

      await _firestore.collection(collection).doc(documentId).delete();
    } catch (e, stackTrace) {
      AppLogger.error('Failed to delete document', e, stackTrace);
      throw app_exceptions.FirestoreException(
        message: 'Failed to delete document: ${e.toString()}',
      );
    }
  }

  /// Batch write operations
  Future<void> batchWrite(List<Map<String, dynamic>> operations) async {
    try {
      AppLogger.debug('Performing batch write with ${operations.length} operations');

      final batch = _firestore.batch();

      for (final operation in operations) {
        final type = operation['type'] as String;
        final collection = operation['collection'] as String;
        final documentId = operation['documentId'] as String;
        final docRef = _firestore.collection(collection).doc(documentId);

        switch (type) {
          case 'set':
            batch.set(docRef, operation['data'] as Map<String, dynamic>);
            break;
          case 'update':
            batch.update(docRef, operation['data'] as Map<String, dynamic>);
            break;
          case 'delete':
            batch.delete(docRef);
            break;
        }
      }

      await batch.commit();
      AppLogger.debug('Batch write completed successfully');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to perform batch write', e, stackTrace);
      throw app_exceptions.FirestoreException(
        message: 'Failed to perform batch write: ${e.toString()}',
      );
    }
  }
}
