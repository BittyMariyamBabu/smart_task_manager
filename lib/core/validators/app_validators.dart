/// Provides reusable form validation methods used throughout the application.
abstract final class AppValidators {
  /// Validates an email address.
  ///
  /// Returns an error message when the email is empty or invalid.
  /// Returns `null` when the value is valid.
  static String? validateEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Enter your email';
    if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email)) return 'Enter a valid email address';  
    return null;
  }

  /// Validates a password.
  ///
  /// Requires the password to contain at least 6 characters.
  static String? validatePassword(String? value) {
    if ((value ?? '').isEmpty) return 'Create a password';
    if (value!.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  /// Validates a required name field.
  static String? validateName(String? value) {
    if ((value?.trim() ?? '').isEmpty) return 'Enter your name';
    return null;
  }

    /// Validates a required name field.
  static String? validate(String? value) {
    if ((value?.trim() ?? '').isEmpty) return 'Enter your value';
    return null;
  }

  /// Validates that a confirmation password matches the original password.
  static String? confirmPassword(
  String? value,
  String password,
  ) {
    if ((value ?? '').isEmpty) return 'Re-enter your password';
    if (value != password) return 'Passwords do not match';
    return null;
  }
}
