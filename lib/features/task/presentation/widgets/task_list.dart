import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/task/data/models/task/task_model.dart';
import 'package:task_manager/features/task/presentation/providers/task_providers.dart';
import 'package:task_manager/features/task/presentation/widgets/task_card.dart';

/// Displays the currently filtered and sorted task list.
class TaskList extends ConsumerWidget {
  final List<TaskModel> tasks;

  const TaskList({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      separatorBuilder: (_, __) {
        return const SizedBox(
          height: 10,
        );
      },
      itemBuilder: (context, index) {
        final task = tasks[index];

        return TaskCard(
          task: task,

          // Toggle task completion.
          onToggle: () {
            ref
                .read(taskNotifierProvider.notifier)
                .updateTask(
                  task.id,
                  {
                    'is_completed': !task.isCompleted,
                  },
                );
          },

          // Delete task.
          onDelete: () {
            ref
                .read(taskNotifierProvider.notifier)
                .deleteTask(
                  task.id,
                );
          },
        );
      },
    );
  }
}