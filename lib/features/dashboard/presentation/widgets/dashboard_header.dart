import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_spacing.dart';
 
/// A widget that displays a welcome message and a brief description for the dashboard page.
/// 
/// The [DashboardHeader] widget takes a [name] parameter, which is used to personalize the welcome message.
class DashboardHeader extends StatelessWidget {
  /// The user's profile information, used to display the user's name in the welcome message.
  final String name;

  const DashboardHeader({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome, $name 👋',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),

        const SizedBox(height: AppSpacing.sm),

        Text(
          "Here's what's happening today",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context)
                    .colorScheme
                    .onSurface
                    .withValues(alpha: 0.6),
              ),
        ),

        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
