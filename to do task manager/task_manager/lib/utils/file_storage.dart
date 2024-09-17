import 'dart:convert';
import 'dart:io';
import '../models/task.dart';

class FileStorage {
  final String filePath;

  FileStorage(this.filePath);

  Future<void> saveTasks(List<Task> tasks) async {
    final file = File(filePath);
    final jsonTasks = tasks
        .map((task) => {
              'id': task.id,
              'description': task.description,
              'isCompleted': task.isCompleted
            })
        .toList();
    await file.writeAsString(jsonEncode(jsonTasks));
  }

  Future<List<Task>> loadTasks() async {
    final file = File(filePath);
    if (await file.exists()) {
      final jsonTasks = jsonDecode(await file.readAsString());
      return (jsonTasks as List)
          .map((json) => Task(
              id: json['id'],
              description: json['description'],
              isCompleted: json['isCompleted']))
          .toList();
    }
    return [];
  }
}
