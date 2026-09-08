import 'package:task_manager/core/network/dio_client.dart';
import 'package:task_manager/features/task/data/models/task/task_model.dart';


/// Handles all task-related communication with the remote API.
///
/// This class is responsible only for API communication.
/// Business decisions should not be placed here.
class TaskRemoteDataSource {
  final DioClient _client;

  TaskRemoteDataSource(this._client);

  /// Fetches all tasks from the API.
  Future<List<TaskModel>> getTasks(String userId) async {
    final response = await _client.get<Map<String, dynamic>>(
      '/tasks/',
      queryParameters: {
        'user_id': userId,
      },
    );

    final data = response.data?['data'];

    if (data is! List) {
      throw Exception('Invalid tasks response.');
    }

    return data
        .map(
          (json) => TaskModel.fromJson(
            json as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  /// Creates a new task.
  Future<TaskModel> createTask(
    String userId,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.post<Map<String, dynamic>>(
      '/tasks/',
      queryParameters: {
        'user_id': userId,
      },
    );

    final responseData = response.data;

    if (responseData == null) {
      throw Exception('Empty server response.');
    }

    final taskData = responseData['data'];

    if (taskData is! Map<String, dynamic>) {
      throw Exception('Task data is missing from response.');
    }

    return TaskModel.fromJson(taskData);
  }

  /// Updates an existing task.
  Future<TaskModel> updateTask(
    String userId,
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await _client.put<Map<String, dynamic>>(
      '/tasks/$id',
      queryParameters: {
        'user_id': userId,
      },
      data: data,
    );

    final responseData = response.data;

    if (responseData == null) {
      throw Exception('Empty server response.');
    }

    final taskData = responseData['data'];

    if (taskData is! Map<String, dynamic>) {
      throw Exception('Task data is missing from response.');
    }

    return TaskModel.fromJson(taskData);
  }

  /// Deletes a task.
  Future<void> deleteTask(String userId,int id) async {
    await _client.delete(
      '/tasks/$id',
      queryParameters: {
        'user_id': userId,
      },
    );
  }
}