import 'package:firebase_auth/firebase_auth.dart';

/// A class that maps Firebase authentication errors to user-friendly messages.
/// 
/// This class provides a static method to convert FirebaseAuthException codes into 
/// readable error messages that can be displayed to users. It helps in improving the 
/// user experience by providing clear feedback on authentication issues.
class FirebaseErrorMapper {
  FirebaseErrorMapper._();

  static String authError(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return 'Please enter a valid email address.';

      case 'user-disabled':
        return 'This account has been disabled.';

      case 'user-not-found':
        return 'No account found with this email.';

      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';

      case 'email-already-in-use':
        return 'An account already exists with this email.';

      case 'weak-password':
        return 'Password is too weak.';

      case 'operation-not-allowed':
        return 'Email/password authentication is not enabled.';

      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';

      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';

      default:
        return 'Something went wrong. Please try again.';
    }
  }
}