import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_radius.dart';
import 'package:task_manager/core/theme/app_spacing.dart';
import 'package:task_manager/core/theme/app_typography.dart';

/// A reusable branding widget for authentication screens.
/// 
/// Displays an icon, title, and subtitle, typically used at the top of login or registration pages.
class AuthBranding extends StatelessWidget {
  const AuthBranding({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: const Icon(Icons.check_rounded, color: Colors.white, size: 28),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Smart Task Manager',
                style: AppTypography.textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Organize your tasks. Get things done.',
                style: AppTypography.textTheme.bodySmall?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}