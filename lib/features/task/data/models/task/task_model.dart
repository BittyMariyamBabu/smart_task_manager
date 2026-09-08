import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

/// Represents a task received from the API.
///
/// This model is used for both remote API responses
/// and local task storage.
@JsonSerializable()
class TaskModel {
  /// Task title.
  final String title;

  /// Task description.
  ///
  /// Can be null when the task has no description.
  final String? description;

  /// Indicates whether the task is completed.
  @JsonKey(name: 'is_completed')
  final bool isCompleted;

  /// Task due date.
  ///
  /// Can be null when no due date is assigned.
  @JsonKey(name: 'due_date')
  final DateTime? dueDate;

  /// Task priority.
  final String priority;

  /// Task category.
  final String category;

  /// Unique task ID.
  final int id;

  /// ID of the user who owns the task.
  @JsonKey(name: 'user_id')
  final String userId;

  /// Date and time when the task was created.
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Date and time when the task was last updated.
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  const TaskModel({
    required this.title,
    this.description,
    required this.isCompleted,
    this.dueDate,
    required this.priority,
    required this.category,
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a [TaskModel] from JSON.
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return _$TaskModelFromJson(json);
  }

  /// Converts this model into JSON.
  Map<String, dynamic> toJson() {
    return _$TaskModelToJson(this);
  }
}