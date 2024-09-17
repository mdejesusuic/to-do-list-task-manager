// lib/providers/task_provider.dart
import 'package:riverpod/riverpod.dart';
import '../services/task_service.dart';
import '../models/task.dart';

final taskServiceProvider = Provider<TaskService>((ref) => TaskService());

final taskProvider = Provider<List<Task>>((ref) {
  final taskService = ref.watch(taskServiceProvider);
  return taskService.getTasks();
});
