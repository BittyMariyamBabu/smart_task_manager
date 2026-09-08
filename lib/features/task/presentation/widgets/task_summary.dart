import 'package:flutter/material.dart';
import 'package:task_manager/features/task/presentation/providers/task_filters.dart';

/// Displays the number of currently visible tasks
/// and the active sorting option.
class TaskSummary extends StatelessWidget {
  final int count;
  final TaskSort sort;

  const TaskSummary({super.key, 
    required this.count,
    required this.sort,
  });

  String get sortName {
    switch (sort) {
      case TaskSort.dueDate:
        return 'Due Date';

      case TaskSort.priority:
        return 'Priority';

      case TaskSort.createdDate:
        return 'Created Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        8,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$count Tasks',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            sortName,
            style: Theme.of(context)
                .textTheme
                .bodySmall,
          ),
        ],
      ),
    );
  }
}