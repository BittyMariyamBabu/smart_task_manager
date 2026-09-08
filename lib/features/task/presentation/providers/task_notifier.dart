import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/features/auth/presentation/providers/auth_providers.dart';
import 'package:task_manager/features/task/domain/repositories/task_repository.dart';
import 'package:task_manager/features/task/presentation/providers/task_filters.dart';
import 'package:task_manager/features/task/presentation/providers/task_providers.dart';
import 'task_state.dart';

/// Manages task data and task-screen state.
///
/// The notifier communicates with the repository and exposes
/// task operations to the UI.
class TaskNotifier extends Notifier<TaskState> {

  late final TaskRepository _repository;
  late final FirebaseAuth _auth;

  @override
  TaskState build() {
    _repository = ref.watch(taskRepositoryProvider);
    _auth = ref.watch(firebaseAuthProvider);

    return const TaskState();
  }

   /// Returns the UID of the currently authenticated user.
  ///
  /// Throws an exception when no user is signed in.
  String get userId {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('User is not authenticated.');
    }

    return user.uid;
  }

  /// Fetches tasks from the repository.
  ///
  /// The repository handles remote/local data selection.
  Future<void> getTasks() async {
    state = state.copyWith(
      isLoading: true,
      clearError: true,
    );

    try {
      final tasks = await _repository.getTasks(userId);

      state = state.copyWith(
        tasks: tasks,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Creates a new task.
  Future<void> createTask(
    Map<String, dynamic> data,
  ) async {
    state = state.copyWith(
      isProcessing: true,
      clearError: true,
    );

    try {
      final task = await _repository.createTask(userId,data);

      state = state.copyWith(
        tasks: [
          task,
          ...state.tasks,
        ],
        isProcessing: false,
      );
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        errorMessage: e.toString(),
      );

      rethrow;
    }
  }

  /// Updates an existing task.
  Future<void> updateTask(
    int id,
    Map<String, dynamic> data,
  ) async {
    state = state.copyWith(
      isProcessing: true,
      clearError: true,
    );

    try {
      final updatedTask = await _repository.updateTask(
        userId,
        id,
        data,
      );

      final updatedTasks = state.tasks.map((task) {
        if (task.id == id) {
          return updatedTask;
        }

        return task;
      }).toList();

      state = state.copyWith(
        tasks: updatedTasks,
        isProcessing: false,
      );
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        errorMessage: e.toString(),
      );

      rethrow;
    }
  }

  /// Deletes a task.
  Future<void> deleteTask(int id) async {
    state = state.copyWith(
      isProcessing: true,
      clearError: true,
    );

    try {
      await _repository.deleteTask(userId,id);

      final updatedTasks = state.tasks
          .where((task) => task.id != id)
          .toList();

      state = state.copyWith(
        tasks: updatedTasks,
        isProcessing: false,
      );
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        errorMessage: e.toString(),
      );

      rethrow;
    }
  }

  /// Changes the current task filter.
  void setFilter(TaskFilter filter) {
    state = state.copyWith(
      filter: filter,
    );
  }

  /// Changes the task search query.
  void setSearchQuery(String query) {
    state = state.copyWith(
      searchQuery: query,
    );
  }

  /// Changes the task sorting option.
  void setSort(TaskSort sort) {
    state = state.copyWith(
      sort: sort,
    );
  }

  /// Clears the current error.
  void clearError() {
    state = state.copyWith(
      clearError: true,
    );
  }
}