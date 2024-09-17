class Task {
  final String id;
  final String description;
  bool isCompleted;

  Task({
    required this.id,
    required this.description,
    this.isCompleted = false,
  });

  void complete() {
    isCompleted = true;
  }

  @override
  String toString() {
    return 'Task(id: $id, description: $description, isCompleted: $isCompleted)';
  }
}
