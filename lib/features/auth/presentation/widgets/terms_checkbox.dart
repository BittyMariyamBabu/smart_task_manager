import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_spacing.dart';
import 'package:task_manager/core/theme/app_typography.dart';

/// A terms and condition widget for register screen.
/// 
/// Displays a checkbox with a label and links to the terms and conditions and privacy policy.
class TermsCheckbox extends StatelessWidget {
  const TermsCheckbox({super.key, required this.value, required this.onChanged});
  
  /// The current value of the checkbox, indicating whether the user has accepted the terms and conditions.
  final bool value;

  /// Called when the user toggles the checkbox, providing the new value.
  /// 
  /// If null, the checkbox is disabled and cannot be toggled.
  final ValueChanged<bool?>? onChanged;

  @override
  Widget build(BuildContext context) {
    // Get the current color scheme from the theme to style the text and links.
    final colors = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            child: Text.rich(
              TextSpan(
                text: 'I agree to the ',
                style: AppTypography.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
                children: [
                  TextSpan(
                    text: 'Terms & Conditions',
                    style: TextStyle(color: colors.primary),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(color: colors.primary),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}