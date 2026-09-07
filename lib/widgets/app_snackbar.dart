import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_colors.dart';

/// A utility class for displaying snackbars in the application.
/// 
/// This class provides static methods to show success and error snackbars with customizable messages.
class AppSnackbar {
  AppSnackbar._();
  
  /// Displays a success snackbar with the given message.
  ///
  /// The snackbar will have a green background to indicate success.
  static void success(
    BuildContext context,
    String message,
  ) {
    _show(
      context,
      message: message,
      backgroundColor: AppColors.success,
    );
  }
  
  /// Displays an error snackbar with the given message.
  /// 
  /// The snackbar will have a red background to indicate an error.
  static void error(
    BuildContext context,
    String message,
  ) {
    _show(
      context,
      message: message,
      backgroundColor: AppColors.error,
    );
  }
  
  /// A private method to show a snackbar with the specified message and background color.
  /// 
  /// This method is used internally by the `success` and `error` methods to display the snackbar.
  static void _show(
    BuildContext context, {
    required String message,
    required Color backgroundColor,
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
  }
}