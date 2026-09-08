import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/task/presentation/providers/task_filters.dart';
import 'package:task_manager/features/task/presentation/providers/task_providers.dart';

/// Displays the task sorting options in a modal bottom sheet.
void showTaskSortSheet(
  BuildContext context,
  WidgetRef ref,
) {
  final currentSort = ref.read(
    taskNotifierProvider.select(
      (state) => state.sort,
    ),
  );

  showModalBottomSheet(
    context: context,
    builder: (sheetContext) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ListTile(
              title: Text(
                'Sort Tasks',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            RadioListTile<TaskSort>(
              value: TaskSort.dueDate,
              groupValue: currentSort,
              title: const Text('Due Date'),
              onChanged: (value) {
                if (value == null) return;

                ref
                    .read(taskNotifierProvider.notifier)
                    .setSort(value);

                Navigator.pop(sheetContext);
              },
            ),

            RadioListTile<TaskSort>(
              value: TaskSort.priority,
              groupValue: currentSort,
              title: const Text('Priority'),
              onChanged: (value) {
                if (value == null) return;

                ref
                    .read(taskNotifierProvider.notifier)
                    .setSort(value);

                Navigator.pop(sheetContext);
              },
            ),

            RadioListTile<TaskSort>(
              value: TaskSort.createdDate,
              groupValue: currentSort,
              title: const Text('Created Date'),
              onChanged: (value) {
                if (value == null) return;

                ref
                    .read(taskNotifierProvider.notifier)
                    .setSort(value);

                Navigator.pop(sheetContext);
              },
            ),
          ],
        ),
      );
    },
  );
}