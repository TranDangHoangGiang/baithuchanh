class Task {
  String title;
  String? name;
  DateTime deadline;

  Task({required this.title, required this.name, required this.deadline});

  bool isOverdue() {
    return deadline.isBefore(DateTime.now());
  }
}
