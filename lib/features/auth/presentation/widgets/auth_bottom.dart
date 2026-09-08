import 'package:flutter/material.dart';

/// A reusable bottom section for authentication screens.
/// 
/// Displays a main text and a subtext, typically used for 
/// navigation between login and registration pages.
class AuthBottom extends StatelessWidget {
  const AuthBottom({
    super.key,
    required this.mainText, 
    required this.subText, 
    this.onPressed,
  });

  /// The informational text displayed before the action button.
  final String mainText;

  /// The text displayed inside the action button.
  final String subText;

  /// Called when the action button is pressed.
  ///
  /// If null, the button is disabled.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          mainText,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(subText),
        ),
      ],
    );
  }
}
