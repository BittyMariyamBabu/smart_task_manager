import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_radius.dart';
import 'package:task_manager/core/theme/app_spacing.dart';
import 'package:task_manager/core/theme/app_typography.dart';

/// Defines the overall theme of the application, including color schemes, typography, and 
/// other visual elements.
abstract final class AppTheme {
  /// Returns the light theme configuration for the application.
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.light,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
      ),

      scaffoldBackgroundColor: AppColors.lightBackground,

      inputDecorationTheme: _inputDecorationTheme(
        fillColor: AppColors.lightSurface,
        borderColor: AppColors.lightBorder,
      ),

      textTheme: AppTypography.textTheme.apply(
        bodyColor: AppColors.lightTextPrimary,
        displayColor: AppColors.lightTextPrimary,
      ),

    );
  }
  
  /// Returns the dark theme configuration for the application.
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.dark,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
      ),

      scaffoldBackgroundColor: AppColors.darkBackground,

      inputDecorationTheme: _inputDecorationTheme(
        fillColor: AppColors.darkSurface,
        borderColor: AppColors.darkBorder,
      ),

      textTheme: AppTypography.textTheme.apply(
        bodyColor: AppColors.darkTextPrimary,
        displayColor: AppColors.darkTextPrimary,
      ),
    );
  }
}

  InputDecorationTheme _inputDecorationTheme({
    required Color fillColor,
    required Color borderColor,
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: BorderSide(color: borderColor),
    );

    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      border: border,
      enabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
    );
  }