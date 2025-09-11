class Todo {
  final String id;
  final String todoText;
  final bool isDone;

  Todo({required this.id, required this.todoText, this.isDone = false});

  static List<Todo> todoList() {
    return [
      Todo(id: '01', todoText: 'Buy groceries', isDone: true),
      Todo(id: '02', todoText: 'Walk the dog'),
      Todo(id: '03', todoText: 'Finish Flutter project'),
      Todo(id: '04', todoText: 'Call Mom'),
      Todo(id: '05', todoText: 'Read 20 pages of a book'),
      Todo(id: '06', todoText: 'Workout for 30 minutes'),
      Todo(id: '07', todoText: 'Prepare presentation slides'),
      Todo(id: '08', todoText: 'Reply to pending emails', isDone: true),
    ];
  }
}
