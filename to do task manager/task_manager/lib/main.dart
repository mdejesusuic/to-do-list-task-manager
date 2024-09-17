import 'dart:io';
import 'package:riverpod/riverpod.dart';
import 'providers/task_provider.dart';
import 'services/task_service.dart';
import 'models/task.dart';

void main() {
  final container = ProviderContainer();
  final taskService = container.read(taskServiceProvider);

  while (true) {
    print('\nTo-Do Task Manager');
    print('1. Add Task');
    print('2. List Tasks');
    print('3. Complete Task');
    print('4. Delete Task');
    print('5. Exit');
    stdout.write('Choose an option: ');

    final choice = stdin.readLineSync();
    switch (choice) {
      case '1':
        stdout.write('Enter task description: ');
        final description = stdin.readLineSync();
        if (description != null && description.isNotEmpty) {
          taskService.addTask(description);
          print('Task added.');
        } else {
          print('Description cannot be empty.');
        }
        break;
      case '2':
        print('Tasks:');
        final tasks = container.read(taskProvider);
        for (var task in tasks) {
          print(task);
        }
        break;
      case '3':
        stdout.write('Enter task ID to complete: ');
        final id = stdin.readLineSync();
        if (id != null && id.isNotEmpty) {
          taskService.completeTask(id);
          print('Task completed.');
        } else {
          print('Invalid ID.');
        }
        break;
      case '4':
        stdout.write('Enter task ID to delete: ');
        final id = stdin.readLineSync();
        if (id != null && id.isNotEmpty) {
          taskService.deleteTask(id);
          print('Task deleted.');
        } else {
          print('Invalid ID.');
        }
        break;
      case '5':
        container.dispose();
        return;
      default:
        print('Invalid option. Please try again.');
    }
  }
}
