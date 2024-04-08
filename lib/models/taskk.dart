class Task {
  String? id;
  String? taskName;
  bool isDone;

  Task({required this.id, required this.taskName, this.isDone = false});

  static List<Task> taskList() {
    return [
      Task(id: '001', taskName: 'Morning exercise', isDone: true),
      Task(id: '002', taskName: 'Buy groceries', isDone: true),
      Task(id: '003', taskName: 'Check emails'),
      Task(id: '004', taskName: 'Team meeting'),
      Task(id: '005', taskName: 'Work on task app'),
      Task(id: '006', taskName: 'Dinner with Tania'),
      Task(id: '007', taskName: 'Dog walk'),
    ];
  }
}
