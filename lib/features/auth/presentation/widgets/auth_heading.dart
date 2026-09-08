import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_spacing.dart';

/// A reusable heading for authentication screens.
/// 
/// Displays a title and a subtitle, typically used at the top of login or registration pages.
class AuthHeading extends StatelessWidget {
  const AuthHeading({
    super.key, 
    required this.title, 
    required this.subtitle});
  
  /// The main title text displayed at the top of the authentication screen.
  final String title;

  /// The subtitle text displayed below the title.
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [      
        const SizedBox(height: AppSpacing.xxl),
        Text(title, style: theme.textTheme.headlineLarge),
        const SizedBox(height: AppSpacing.sm),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
      ],
    );
  }
}