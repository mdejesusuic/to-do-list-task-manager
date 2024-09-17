import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:task_manager/utils/file_storage.dart';
import 'file_storage.dart';
import '../models/task.dart';

class TaskService {
  final List<Task> _tasks = [];
  final FileStorage _storage =
      FileStorage(p.join(Directory.current.path, 'tasks.json'));

  TaskService() {
    _loadTasks();
  }

  List<Task> getTasks() => _tasks;

  void addTask(String description) {
    final task = Task(id: DateTime.now().toString(), description: description);
    _tasks.add(task);
    _saveTasks();
  }

  void completeTask(String id) {
    final task = _tasks.firstWhere(
      (task) => task.id == id,
      orElse: () => throw Exception('Task with id $id not found'),
    );
    task.complete();
    _saveTasks();
  }

  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    _saveTasks();
  }

  Future<void> _saveTasks() async {
    await _storage.saveTasks(_tasks);
  }

  Future<void> _loadTasks() async {
    _tasks.addAll(await _storage.loadTasks());
  }
}
