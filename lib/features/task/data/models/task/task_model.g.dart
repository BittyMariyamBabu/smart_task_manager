// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
  title: json['title'] as String,
  description: json['description'] as String?,
  isCompleted: json['is_completed'] as bool,
  dueDate: json['due_date'] == null
      ? null
      : DateTime.parse(json['due_date'] as String),
  priority: json['priority'] as String,
  category: json['category'] as String,
  id: (json['id'] as num).toInt(),
  userId: json['user_id'] as String,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'is_completed': instance.isCompleted,
  'due_date': instance.dueDate?.toIso8601String(),
  'priority': instance.priority,
  'category': instance.category,
  'id': instance.id,
  'user_id': instance.userId,
  'created_at': instance.createdAt.toIso8601String(),
  'updated_at': instance.updatedAt.toIso8601String(),
};
