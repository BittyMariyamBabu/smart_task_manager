import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_radius.dart';
import 'package:task_manager/core/theme/app_spacing.dart';
import 'package:task_manager/core/theme/app_typography.dart';

/// A reusable primary action button for authentication screens.
///
/// Displays a label and an optional loading indicator, typically used for
/// login or registration actions.
class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
  });

  /// Called when the button is pressed.
  ///
  /// If [isLoading] is true, this callback is disabled.
  final VoidCallback? onPressed;

  /// The text displayed when the button is not loading.
  final String label;

  /// Whether the button is currently performing an operation.
  ///
  /// When true, the button is disabled and displays a progress indicator.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          textStyle: AppTypography.textTheme.labelLarge,
        ),
        child: isLoading
            ? const SizedBox.square(
                dimension: AppSpacing.md,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Text(label),
      ),
    );
  }
}