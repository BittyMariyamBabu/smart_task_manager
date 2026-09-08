import 'package:task_manager/features/task/data/data_source/task_local_data_source.dart';
import 'package:task_manager/features/task/data/data_source/task_remote_data_source.dart';
import 'package:task_manager/features/task/data/models/task/task_model.dart';
import 'package:task_manager/features/task/domain/repositories/task_repository.dart';

/// Concrete implementation of [TaskRepository].
///
/// This class decides whether data should come from the remote
/// API or local storage.
class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource _remoteDataSource;
  final TaskLocalDataSource _localDataSource;

  TaskRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  /// Fetches tasks.
  ///
  /// The repository follows an offline-first approach:
  ///
  /// 1. Try to fetch fresh data from the API.
  /// 2. Save successful API data locally.
  /// 3. Return the fresh data.
  /// 4. If the API fails, return cached data.
  @override
  Future<List<TaskModel>> getTasks(String userId) async {
    try {
      final tasks = await _remoteDataSource.getTasks(userId);

      await _localDataSource.saveTasks(tasks);

      return tasks;
    } catch (_) {
      final cachedTasks = await _localDataSource.getTasks();

      if (cachedTasks.isNotEmpty) {
        return cachedTasks;
      }

      rethrow;
    }
  }

  /// Creates a new task.
  ///
  /// After successful creation, the returned task is stored locally.
  @override
  Future<TaskModel> createTask(
    String userId,
    Map<String, dynamic> data,
  ) async {
    final task = await _remoteDataSource.createTask(userId, data);

    await _localDataSource.saveTask(task);

    return task;
  }

  /// Updates an existing task.
  ///
  /// The remote API is updated first and the successful result
  /// is then stored locally.
  @override
  Future<TaskModel> updateTask(
    String userId,
    int id,
    Map<String, dynamic> data,
  ) async {
    final task = await _remoteDataSource.updateTask(
      userId,
      id,
      data,
    );

    await _localDataSource.saveTask(task);

    return task;
  }

  /// Deletes a task.
  ///
  /// The remote API is updated first. Once successful,
  /// the task is removed from local storage.
  @override
  Future<void> deleteTask(String userId,int id) async {
    await _remoteDataSource.deleteTask(userId, id);

    await _localDataSource.deleteTask(id);
  }
}