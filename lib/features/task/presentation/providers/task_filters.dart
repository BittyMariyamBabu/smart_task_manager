/// Defines the available task filters.
enum TaskFilter {
  /// Displays all tasks.
  all,

  /// Displays only completed tasks.
  completed,

  /// Displays only pending tasks.
  pending,
}

/// Defines the available task sorting options.
enum TaskSort {
  /// Sorts tasks by due date.
  dueDate,

  /// Sorts tasks by priority.
  priority,

  /// Sorts tasks by creation date.
  createdDate,
}