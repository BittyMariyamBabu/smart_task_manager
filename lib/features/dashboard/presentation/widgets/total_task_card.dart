import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_radius.dart';
import 'package:task_manager/core/theme/app_spacing.dart';

/// A widget that displays the total number of tasks in a card format.
/// 
/// The [TotalTasksCard] widget takes a [totalTasks] parameter, which is 
/// used to display the total number of tasks. It is styled with 
/// a primary container color and rounded corners.
class TotalTasksCard extends StatelessWidget {
  /// The total number of tasks to be displayed in the card.
  final int totalTasks;

  const TotalTasksCard({
    super.key, 
    required this.totalTasks,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          color: colorScheme.primaryContainer,
        ),
        child: Column(
          children: [
            Text(
              'MY TASKS',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
            ),

            const SizedBox(height: AppSpacing.sm),

            Text(
              '$totalTasks',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: AppSpacing.xs),

            Text(
              'Total Tasks',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
