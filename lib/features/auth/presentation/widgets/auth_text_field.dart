import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_spacing.dart';
import 'package:task_manager/core/theme/app_typography.dart';

/// A reusable text field for authentication screens.
///
/// Displays a label, hint text, controller and a prefix icon, typically used 
/// for input fields on login or registration pages.
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    required this.controller,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.obscureText = false,
    this.onToggleObscured,
    super.key,
  });

  /// The controller for the text field, used to read and modify the text.
  final TextEditingController controller;

  /// The label displayed above the text field.
  final String label;

  /// The hint text displayed inside the text field when it is empty.
  final String hintText;

  /// The icon displayed at the start of the text field.
  final IconData prefixIcon;

  /// The type of keyboard to use for the text field. 
  /// 
  /// Defaults to null, which uses the default keyboard.
  final TextInputType? keyboardType;

  /// The action button to use for the keyboard.
  /// 
  /// Defaults to null, which uses the default action button.
  final TextInputAction? textInputAction;

  /// The function used to validate the text field's input.
  /// 
  /// Returns an error message string if the input is invalid, or null if it is valid.
  final String? Function(String?)? validator;

  //// Whether the text field should obscure the text, typically used for password fields.
  final bool obscureText;

  /// Called when the user taps the toggle button to show or hide the text.
  /// 
  /// If null, the toggle button is not displayed.
  final VoidCallback? onToggleObscured;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.textTheme.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          textInputAction: textInputAction ?? TextInputAction.done,
          style: AppTypography.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTypography.textTheme.bodyLarge?.copyWith(
              color: colors.onSurfaceVariant,
            ),
            prefixIcon: Icon(prefixIcon, size: 20),
            suffixIcon: onToggleObscured == null
              ? null
              : IconButton(
                  tooltip: obscureText ? 'Show password' : 'Hide password',
                  onPressed: onToggleObscured,
                  icon: Icon(
                    obscureText
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 20,
                  ),
                ),
            errorStyle: AppTypography.textTheme.bodySmall?.copyWith(
              color: AppColors.error,
            ),
          ),
        ),
      ],
    );
  }
}