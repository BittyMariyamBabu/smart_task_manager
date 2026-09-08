import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager/core/constants/firebase_constants.dart';
import 'package:task_manager/core/errors/app_exception.dart';
import 'package:task_manager/features/profile/data/models/user_model.dart';

/// A repository class that handles user profile operations using Firebase Firestore.
/// 
/// This class provides methods for fetching, creating, and updating user profiles.
class UserProfileRepository {
  final FirebaseFirestore _firestore;

  UserProfileRepository(this._firestore);

  /// Fetch user profile from:
  ///
  /// users/{uid}
  Future<UserProfile?> getUserProfile(String uid) async {
    try {
      final snapshot = await _firestore
          .collection(FirestoreConstants.usersCollection)
          .doc(uid)
          .get();

      if (!snapshot.exists || snapshot.data() == null) {
        return null;
      }

      return UserProfile.fromJson(
        snapshot.data()!,
        uid: snapshot.id,
      );
    } on FirebaseException catch (e) {
      throw AppException(
        e.message ?? 'Unable to fetch user profile.',
      );
    }
  }

  /// Update a user profile.
  Future<void> updateProfile({
    required String uid,
    required String name,
    required String email,
  }) async {
    try {
      await _firestore
          .collection(FirestoreConstants.usersCollection)
          .doc(uid)
          .update({
        'name': name.trim(),
        'email': email.trim(),
      });
    } on FirebaseException catch (e) {
      throw AppException(
        e.message ?? 'Unable to update profile.',
      );
    }
  }

  /// Update theme preference.
  Future<void> updateThemeMode({
    required String uid,
    required String themeMode,
  }) async {
    try {
      await _firestore
          .collection(FirestoreConstants.usersCollection)
          .doc(uid)
          .update({
        'themeMode': themeMode,
      });
    } on FirebaseException catch (e) {
      throw AppException(
        e.message ?? 'Unable to update theme.',
      );
    }
  }
}