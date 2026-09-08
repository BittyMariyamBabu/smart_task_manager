import 'package:task_manager/features/task/data/models/task/task_model.dart';

/// Defines operations available for managing tasks.
///
/// The repository hides data-source implementation details
/// from the presentation layer.
abstract class TaskRepository {
  /// Fetches all tasks for the current user.
  Future<List<TaskModel>> getTasks(String userId,);

  /// Creates a new task.
  Future<TaskModel> createTask(
    String userId,
    Map<String, dynamic> data,
  );

  /// Updates an existing task.
  Future<TaskModel> updateTask(
    String userId,
    int id,
    Map<String, dynamic> data,
  );

  /// Deletes a task.
  Future<void> deleteTask(String userId,int id);
}