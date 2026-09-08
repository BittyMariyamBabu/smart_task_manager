import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Defines the typography system used throughout the application.
///
/// Uses Inter as the primary typeface with a consistent hierarchy
/// for headings, body content, labels, and supporting information.

abstract final class AppTypography {
  static TextTheme get textTheme {
    return GoogleFonts.interTextTheme(
      const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),

        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
        ),

        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        ),

        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),

        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),

        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),

        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),

        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),

        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),

        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),

        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),

        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),

        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}