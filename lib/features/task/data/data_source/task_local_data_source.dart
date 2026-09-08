import 'package:hive/hive.dart';
import 'package:task_manager/features/task/data/models/task/task_model.dart';

/// Handles local persistence of tasks.
///
/// This data source is responsible only for reading and writing
/// task data from local storage.
class TaskLocalDataSource {
  static const String _boxName = 'tasks';

  /// Returns the Hive box used to store tasks.
  Future<Box> get _box async {
    if (Hive.isBoxOpen(_boxName)) {
      return Hive.box(_boxName);
    }

    return Hive.openBox(_boxName);
  }

  /// Saves all tasks locally.
  ///
  /// Existing local tasks are replaced with the supplied list.
  Future<void> saveTasks(List<TaskModel> tasks) async {
    final box = await _box;

    await box.clear();

    for (final task in tasks) {
      await box.put(
        task.id,
        task.toJson(),
      );
    }
  }

  /// Returns all locally stored tasks.
  Future<List<TaskModel>> getTasks() async {
    final box = await _box;

    return box.values.map((value) {
      return TaskModel.fromJson(
        Map<String, dynamic>.from(value as Map),
      );
    }).toList();
  }

  /// Saves or updates a single task.
  Future<void> saveTask(TaskModel task) async {
    final box = await _box;

    await box.put(
      task.id,
      task.toJson(),
    );
  }

  /// Deletes a task from local storage.
  Future<void> deleteTask(int id) async {
    final box = await _box;

    await box.delete(id);
  }

  /// Clears all locally stored tasks.
  Future<void> clearTasks() async {
    final box = await _box;

    await box.clear();
  }
}