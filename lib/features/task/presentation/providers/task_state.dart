import 'package:task_manager/features/task/data/models/task/task_model.dart';
import 'package:task_manager/features/task/presentation/providers/task_filters.dart';

/// Represents the state of the task screen.
class TaskState {
  /// All tasks retrieved from the repository.
  final List<TaskModel> tasks;

  /// Indicates whether tasks are currently loading.
  final bool isLoading;

  /// Indicates whether an operation is currently running.
  final bool isProcessing;

  /// Error message displayed to the user.
  final String? errorMessage;

  /// Currently selected task filter.
  final TaskFilter filter;

  /// Search text used to filter tasks by title.
  final String searchQuery;

  /// Currently selected sorting option.
  final TaskSort sort;

  const TaskState({
    this.tasks = const [],
    this.isLoading = false,
    this.isProcessing = false,
    this.errorMessage,
    this.filter = TaskFilter.all,
    this.searchQuery = '',
    this.sort = TaskSort.createdDate,
  });

  /// Creates a copy of the current state with modified values.
  TaskState copyWith({
    List<TaskModel>? tasks,
    bool? isLoading,
    bool? isProcessing,
    String? errorMessage,
    TaskFilter? filter,
    String? searchQuery,
    TaskSort? sort,
    bool clearError = false,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
      isLoading: isLoading ?? this.isLoading,
      isProcessing: isProcessing ?? this.isProcessing,
      errorMessage: clearError
          ? null
          : errorMessage ?? this.errorMessage,
      filter: filter ?? this.filter,
      searchQuery: searchQuery ?? this.searchQuery,
      sort: sort ?? this.sort,
    );
  }

  /// Returns tasks after applying the selected filter,
  /// search query, and sorting.
  List<TaskModel> get filteredTasks {
    List<TaskModel> result = List<TaskModel>.from(tasks);

    // Apply completed/pending filter.
    switch (filter) {
      case TaskFilter.all:
        break;

      case TaskFilter.completed:
        result = result
            .where((task) => task.isCompleted)
            .toList();

      case TaskFilter.pending:
        result = result
            .where((task) => !task.isCompleted)
            .toList();
    }

    // Apply title search.
    if (searchQuery.trim().isNotEmpty) {
      final query = searchQuery.trim().toLowerCase();

      result = result.where((task) {
        return task.title.toLowerCase().contains(query);
      }).toList();
    }

    // Apply sorting.
    switch (sort) {
      case TaskSort.dueDate:
        result.sort((a, b) {
          if (a.dueDate == null && b.dueDate == null) {
            return 0;
          }

          if (a.dueDate == null) {
            return 1;
          }

          if (b.dueDate == null) {
            return -1;
          }

          return a.dueDate!.compareTo(b.dueDate!);
        });

      case TaskSort.priority:
        result.sort((a, b) {
          return _priorityValue(a.priority)
              .compareTo(_priorityValue(b.priority));
        });

      case TaskSort.createdDate:
        result.sort((a, b) {
          return b.createdAt.compareTo(a.createdAt);
        });
    }

    return result;
  }

  /// Converts priority names into sortable values.
  ///
  /// Higher priority appears first.
  static int _priorityValue(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return 0;

      case 'medium':
        return 1;

      case 'low':
        return 2;

      default:
        return 3;
    }
  }
}