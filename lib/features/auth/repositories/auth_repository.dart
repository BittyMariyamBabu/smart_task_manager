import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager/core/errors/app_exception.dart';
import 'package:task_manager/core/errors/firebase_error_map.dart';
import 'package:task_manager/features/auth/models/auth_model.dart';


class AuthRepository {
  final FirebaseAuth _auth;

  AuthRepository(this._auth);

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

  Future<AuthUser> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await _auth.signInWithEmailAndPassword(
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

  Future<AuthUser> register({
    required String email,
    required String password,
  }) async {
    try {
      final credential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw const AppException(
          'Unable to create account.',
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