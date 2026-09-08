import 'package:flutter/material.dart';
import 'package:task_manager/features/task/data/models/task/task_model.dart';
import 'package:task_manager/features/task/presentation/pages/add_task_page.dart';
import 'package:task_manager/features/task/presentation/providers/task_providers.dart';
import 'package:task_manager/features/task/presentation/providers/task_state.dart';
import 'package:task_manager/features/task/presentation/widgets/empty_state.dart';
import 'package:task_manager/features/task/presentation/widgets/filter_widgets.dart';
import 'package:task_manager/features/task/presentation/widgets/sort_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/task/presentation/widgets/task_list.dart';
import 'package:task_manager/features/task/presentation/widgets/task_search_bar.dart';

/// Displays the user's tasks and provides controls for
/// searching, filtering, sorting, completing, deleting,
/// and adding tasks.
class TaskPage extends ConsumerStatefulWidget {
  const TaskPage({super.key});

  @override
  ConsumerState<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends ConsumerState<TaskPage> {
  @override
  void initState() {
    super.initState();

    // Load tasks when the page is first created.
    Future.microtask(() {
      ref.read(taskNotifierProvider.notifier).getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskState = ref.watch(taskNotifierProvider);

    final filteredTasks = taskState.filteredTasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            tooltip: 'Sort',
            onPressed: () {
              showTaskSortSheet(
                context,
                ref,
              );
            },
            icon: const Icon(
              Icons.sort,
            ),
          ),
        ],
      ),

      body: _buildBody(
        context,
        ref,
        taskState,
        filteredTasks,
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: taskState.isProcessing
          ? null
          : () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AddTaskPage(),
                ),
              );
            },
        // onPressed: taskState.isProcessing
        //     ? null
        //     : () {
        //         showAddTaskDialog(
        //           context,
        //           ref,
        //         );
        //       },
        icon: const Icon(
          Icons.add,
        ),
        label: const Text(
          'Add Task',
        ),
      ),
    );
  }

  /// Builds the task screen body based on the current state.
  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    TaskState taskState,
    List<TaskModel> filteredTasks,
  ) {

    if (taskState.isLoading && taskState.tasks.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (taskState.errorMessage != null &&
        taskState.tasks.isEmpty) {
      return _buildErrorView(
        context,
        ref,
        taskState.errorMessage!,
      );
    }

    return Column(
      children: [
        // Search
        const TaskSearchBar(),

        // Filters
        const TaskFilterChips(),

        // Optional loading indicator when refreshing
        if (taskState.isLoading)
          const LinearProgressIndicator(
            minHeight: 2,
          ),

        // Task list
        Expanded(
          child: filteredTasks.isEmpty
              ? const EmptyTaskView()
              : TaskList(
                  tasks: filteredTasks,
                ),
        ),
      ],
    );
  }

  /// Builds the error view displayed when tasks
  /// cannot be loaded and no cached tasks exist.
  Widget _buildErrorView(
    BuildContext context,
    WidgetRef ref,
    String message,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
            ),

            const SizedBox(height: 12),

            const Text(
              'Unable to load tasks.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              message,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            FilledButton(
              onPressed: () {
                ref
                    .read(taskNotifierProvider.notifier)
                    .getTasks();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}