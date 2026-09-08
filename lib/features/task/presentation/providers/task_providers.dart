import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/core/network/network_provider.dart';
import 'package:task_manager/features/task/data/data_source/task_local_data_source.dart';
import 'package:task_manager/features/task/data/data_source/task_remote_data_source.dart';
import 'package:task_manager/features/task/data/repositories/task_repository_impl.dart';
import 'package:task_manager/features/task/domain/repositories/task_repository.dart';
import 'package:task_manager/features/task/presentation/providers/task_notifier.dart';
import 'package:task_manager/features/task/presentation/providers/task_state.dart';

/// Provides the remote task data source.
final taskRemoteDataSourceProvider = Provider<TaskRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);

  return TaskRemoteDataSource(
    dioClient,
  );
});

/// Provides the local task data source.
final taskLocalDataSourceProvider = Provider<TaskLocalDataSource>((ref) {
  return TaskLocalDataSource();
});

/// Provides the task repository implementation.
final taskRepositoryImplProvider = Provider<TaskRepositoryImpl>((ref) {
  return TaskRepositoryImpl(
    ref.watch(taskRemoteDataSourceProvider),
    ref.watch(taskLocalDataSourceProvider),
  );
});

/// Provides the task repository abstraction.
///
/// The presentation layer depends on [TaskRepository],
/// not directly on the implementation.
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return ref.watch(taskRepositoryImplProvider);
});

/// Provides the task notifier.
final taskNotifierProvider = NotifierProvider<TaskNotifier, TaskState>(
  TaskNotifier.new,
);