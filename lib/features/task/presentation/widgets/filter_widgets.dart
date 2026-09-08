import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/task/presentation/providers/task_filters.dart';
import 'package:task_manager/features/task/presentation/providers/task_providers.dart';

/// Displays the available task filters.
class TaskFilterChips extends ConsumerWidget {
  const TaskFilterChips({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    // Listen only to the currently selected filter.
    final filter = ref.watch(
      taskNotifierProvider.select(
        (state) => state.filter,
      ),
    );

    final controller =
        ref.read(taskNotifierProvider.notifier);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Row(
        children: [
          _FilterChip(
            label: 'All',
            selected: filter == TaskFilter.all,
            onSelected: () {
              controller.setFilter(
                TaskFilter.all,
              );
            },
          ),

          const SizedBox(width: 8),

          _FilterChip(
            label: 'Completed',
            selected: filter == TaskFilter.completed,
            onSelected: () {
              controller.setFilter(
                TaskFilter.completed,
              );
            },
          ),

          const SizedBox(width: 8),

          _FilterChip(
            label: 'Pending',
            selected: filter == TaskFilter.pending,
            onSelected: () {
              controller.setFilter(
                TaskFilter.pending,
              );
            },
          ),
        ],
      ),
    );
  }
}

/// A reusable task filter chip.
class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onSelected;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      onSelected: (_) {
        onSelected();
      },
    );
  }
}