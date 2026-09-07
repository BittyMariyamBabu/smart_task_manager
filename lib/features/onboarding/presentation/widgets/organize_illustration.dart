import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_colors.dart';

/// A widget that displays an illustration of a task dashboard, typically used in onboarding screens.
/// 
/// The illustration consists of a rectangular container with a shadow, a header row with an icon and title,
/// and a list of mini task rows indicating the user's tasks for the day.
class OrganizeIllustration extends StatelessWidget {
  const OrganizeIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: 205,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(24),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.checklist_rounded,
                  color: colors.primary,
                  size: 19,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Today\'s Tasks',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Icon(
                Icons.more_horiz_rounded,
                color: colors.onSurfaceVariant,
                size: 20,
              ),
            ],
          ),
    
          const SizedBox(height: 16),
    
          const _MiniTaskRow(
            title: 'Design homepage',
            completed: true,
          ),
    
          const SizedBox(height: 10),
    
          const _MiniTaskRow(
            title: 'Fix API integration',
            completed: false,
          ),
    
          const SizedBox(height: 10),
    
          const _MiniTaskRow(
            title: 'Review project',
            completed: false,
          ),
        ],
      ),
    );
  }
}

/// A private widget that represents a single row in the organize illustration,
/// displaying the title of a task and whether it is completed or not.
class _MiniTaskRow extends StatelessWidget {
  const _MiniTaskRow({
    required this.title,
    required this.completed,
  });

  /// The title of the task, displayed next to the completion indicator.
  final String title;

  /// A boolean indicating whether the task is completed or not.
  final bool completed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: completed
                ? colors.primary
                : AppColors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              color: completed
                  ? colors.primary
                  : colors.outline.withValues(alpha: 0.35),
              width: 1.5,
            ),
          ),
          child: completed
              ? const Icon(
                  Icons.check_rounded,
                  size: 12,
                  color: AppColors.white,
                )
              : null,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(
                  decoration:
                      completed
                          ? TextDecoration.lineThrough
                          : null,
                  color: completed
                      ? colors.onSurfaceVariant.withValues(
                          alpha: 0.55,
                        )
                      : colors.onSurface,
                ),
          ),
        ),
      ],
    );
  }
}
