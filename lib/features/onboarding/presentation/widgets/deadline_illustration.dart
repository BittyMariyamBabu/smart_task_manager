import 'package:flutter/material.dart';
import 'package:task_manager/features/onboarding/presentation/widgets/productivity_illustration.dart';

/// A widget that displays an illustration of a calendar with deadlines, typically used in onboarding screens.
/// 
/// The illustration consists of a rectangular container with a shadow, a circular icon indicating the current date,
/// and a list of mini deadline rows indicating the user's upcoming deadlines for the day.
class DeadlineIllustration extends StatelessWidget {
  const DeadlineIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 190,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(
          color: colors.outline.withValues(alpha: 0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IllustrationIconWidget(
            boxRadius: 58, 
            icon:Icons.calendar_month_rounded,
            size: 30,
          ),
          const SizedBox(height: 16),
          Text(
            'Today',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 14),
          const _DeadlineRow(
            time: '09:00',
            title: 'Team meeting',
          ),
          const SizedBox(height: 10),
          const _DeadlineRow(
            time: '13:30',
            title: 'Design review',
          ),
        ],
      ),
    );
  }
}


/// A private widget that represents a single row in the deadline illustration, 
/// displaying the time and title of a task or event.
class _DeadlineRow extends StatelessWidget {
  const _DeadlineRow({
    required this.time,
    required this.title,
  });
  
  /// The time of the task or event, displayed on the left side of the row.
  final String time;

  /// The title of the task or event, displayed on the right side of the row.
  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Text(
          time,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colors.primary,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}
