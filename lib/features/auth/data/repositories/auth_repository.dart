import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/core/constants/firebase_constants.dart';
import 'package:task_manager/core/errors/app_exception.dart';
import 'package:task_manager/core/errors/firebase_error_map.dart';
import 'package:task_manager/features/auth/data/models/auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// A repository class that handles authentication operations using Firebase Authentication.
/// 
/// This class provides methods for user login, registration, and logout.
///  It also exposes a stream to listen for authentication state changes. 
/// The repository uses the FirebaseAuth instance to perform authentication 
/// tasks and maps Firebase errors to user-friendly messages using the FirebaseErrorMapper.
class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository(this._auth, this._firestore);

  /// A stream that emits the current authentication state of the user.
  /// 
  /// The stream emits an [AuthUser] object when the user is logged in, and `null` when the user is logged out.
  Stream<AuthUser?> get authStateChanges {
    return _auth.authStateChanges().map(
      (user) {
        if (user == null) {
          return null;
        }

        return AuthUser(
          uid: user.uid,
          email: user.email ?? '',
        );
      },
    );
  }
  
  /// Logs in a user with the provided email and password.
  /// 
  /// Throws an [AppException] with a user-friendly message if the login fails.
  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw const AppException(
          'Unable to login. Please try again.',
        );
      }

      return AuthUser(
        uid: user.uid,
        email: user.email ?? '',
      );
    } on FirebaseAuthException catch (e) {
      throw AppException(
        FirebaseErrorMapper.authError(e),
      );
    }
  }
  
  /// Registers a new user with the provided name, email, and password.
  /// 
  /// Throws an [AppException] with a user-friendly message if the registration fails.
  /// The method creates a Firebase Authentication account and a Firestore user profile for the new user.
  Future<AuthUser> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // 1. Create Firebase Authentication account
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw const AppException(
          'Unable to create account.',
        );
      }

      // 2. Create Firestore user profile
      await _firestore
          .collection(FirestoreConstants.usersCollection)
          .doc(user.uid)
          .set({
        'name': name.trim(),
        'email': user.email ?? email.trim(),
        'createdAt': FieldValue.serverTimestamp(),
        'themeMode': 'system',
      });

      return AuthUser(
        uid: user.uid,
        email: user.email ?? '',
      );
    } on FirebaseAuthException catch (e) {
      throw AppException(
        FirebaseErrorMapper.authError(e),
      );
    } on FirebaseException catch (e) {
      throw AppException(
        e.message ?? 'Unable to create user profile.',
      );
    }
  }
  
  /// Logs out the currently authenticated user.
  /// 
  /// Throws an [AppException] with a user-friendly message if the logout fails.
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AppException(
        FirebaseErrorMapper.authError(e),
      );
    }
  }
}