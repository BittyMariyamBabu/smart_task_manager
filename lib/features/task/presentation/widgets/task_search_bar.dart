import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/task/presentation/providers/task_providers.dart';

/// Provides client-side task search by title.
class TaskSearchBar extends ConsumerStatefulWidget {
  const TaskSearchBar({super.key});

  @override
  ConsumerState<TaskSearchBar> createState() =>
      _TaskSearchBarState();
}

class _TaskSearchBarState
    extends ConsumerState<TaskSearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the text field with the current
    // search query from TaskState.
    _controller = TextEditingController(
      text: ref.read(
        taskNotifierProvider.select(
          (state) => state.searchQuery,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watch only the search query.
    //
    // This causes the widget to rebuild when the
    // search query changes.
    final searchQuery = ref.watch(
      taskNotifierProvider.select(
        (state) => state.searchQuery,
      ),
    );

    final controller =
        ref.read(taskNotifierProvider.notifier);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        8,
      ),
      child: TextField(
        controller: _controller,
        onChanged: controller.setSearchQuery,
        decoration: InputDecoration(
          hintText: 'Search tasks by title',

          prefixIcon: const Icon(
            Icons.search,
          ),

          // Show clear button only when there
          // is something to clear.
          suffixIcon: searchQuery.isNotEmpty
              ? IconButton(
                  tooltip: 'Clear search',
                  onPressed: () {
                    _controller.clear();

                    controller.setSearchQuery('');
                  },
                  icon: const Icon(
                    Icons.clear,
                  ),
                )
              : null,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}