
import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_spacing.dart';

/// A widget that displays the status of tasks, including completed and pending tasks.
/// The [TaskStatus] widget consists of two cards, one for completed tasks and 
/// another for pending tasks, each displaying the count and an icon.
class TaskStatus extends StatelessWidget {
  const TaskStatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _TaskStatusCard(
            title: 'Completed',
            count: 5,
            icon: Icons.check_circle_outline,
          ),
        ),
    
        const SizedBox(width: AppSpacing.md),
    
        Expanded(
          child: _TaskStatusCard(
            title: 'Pending',
            count: 7,
            icon: Icons.pending_actions,
          ),
        ),
      ],
    );
  }
}

/// A private widget that represents a single task status card, displaying the title, count, and an icon.
class _TaskStatusCard extends StatelessWidget {

  /// The title of the task status (e.g., "Completed" or "Pending").
  final String title;

  /// The count of tasks for the given status.
  final int count;

  /// The icon representing the task status.
  final IconData icon;

  const _TaskStatusCard({
    required this.title,
    required this.count,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 28,
            ),

            const SizedBox(height: AppSpacing.sm),

            Text(
              '$count',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),

            const SizedBox(height: AppSpacing.xs),

            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.65),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
