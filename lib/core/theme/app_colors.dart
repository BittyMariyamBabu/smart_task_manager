import 'package:flutter/material.dart';

/// AppColors is a class that contains all the color constants used in the app.
abstract final class AppColors {
  // BRAND
  static const primary = Color(0xFF2962FF);
  static const primaryLight = Color(0xFF5C7CFA);
  static const primaryDark = Color(0xFF1749C6);

  // LIGHT THEME
  static const lightBackground = Color(0xFFF8FAFC);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightSurfaceVariant = Color(0xFFF1F5F9);

  static const lightTextPrimary = Color(0xFF111827);
  static const lightTextSecondary = Color(0xFF64748B);
  static const lightTextTertiary = Color(0xFF94A3B8);

  static const lightBorder = Color(0xFFE2E8F0);

  // DARK THEME
  static const darkBackground = Color(0xFF0B0F14);
  static const darkSurface = Color(0xFF121820);
  static const darkSurfaceVariant = Color(0xFF171E27);
  static const darkElevatedSurface = Color(0xFF1C2530);

  static const darkTextPrimary = Color(0xFFF5F7FA);
  static const darkTextSecondary = Color(0xFF9AA6B2);
  static const darkTextTertiary = Color(0xFF667381);

  static const darkBorder = Color(0xFF26313D);

  // SEMANTIC
  static const success = Color(0xFF22C55E);
  static const error = Color(0xFFEF4444);
  static const warning = Color(0xFFF59E0B);
  static const info = Color(0xFF38BDF8);

  // COMMON
  static const white = Colors.white;
  static const black = Colors.black;
  static const transparent = Colors.transparent;
}