class Todo {
  String id;
  String todoText;
  bool isDone;

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
      Todo(id: '09', todoText: 'Clean the room'),
      Todo(id: '10', todoText: 'Pay electricity bill'),
      Todo(id: '11', todoText: 'Update resume'),
      Todo(id: '12', todoText: 'Water the plants'),
      Todo(id: '13', todoText: 'Schedule dentist appointment', isDone: true),
      Todo(id: '14', todoText: 'Organize workspace'),
      Todo(id: '15', todoText: 'Plan weekend trip'),
      Todo(id: '16', todoText: 'Backup phone data'),
      Todo(id: '17', todoText: 'Practice coding challenges'),
      Todo(id: '18', todoText: 'Review monthly budget', isDone: true),
      Todo(id: '19', todoText: 'Watch a tech tutorial'),
      Todo(id: '20', todoText: 'Clean kitchen'),
      Todo(id: '21', todoText: 'Meditate for 15 minutes'),
      Todo(id: '22', todoText: 'Write journal entry'),
      Todo(id: '23', todoText: 'Research investment options'),
      Todo(id: '24', todoText: 'Call best friend'),
      Todo(id: '25', todoText: 'Check car tire pressure', isDone: true),
      Todo(id: '26', todoText: 'Prepare healthy meal'),
      Todo(id: '27', todoText: 'Organize photo gallery'),
      Todo(id: '28', todoText: 'Update Flutter app dependencies'),
      Todo(id: '29', todoText: 'Learn new keyboard shortcuts'),
      Todo(id: '30', todoText: 'Take a 20-minute walk', isDone: true),
    ];
  }
}
