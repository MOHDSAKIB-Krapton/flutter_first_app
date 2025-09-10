import 'package:flutter/material.dart';
import 'model/task.dart';
import 'widgets/task_card.dart';
import 'widgets/task_input.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Task Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  // Mock List of Tasks
  final List<Task> _tasks = [
    Task(
      title: 'Learn Flutter Widgets',
      description: 'Explore Stateless and Stateful widgets.',
    ),
    Task(
      title: 'Build UI for Task App',
      description: 'Design a clean and modern user interface.',
      isCompleted: true,
    ),
    Task(
      title: 'Integrate Mock Data',
      description: 'Use a mock list to populate the task list.',
    ),
    Task(
      title: 'Make List Scrollable',
      description: 'Implement a ListView.builder for performance.',
    ),
    Task(
      title: 'Add New Task Functionality',
      description: 'Create a form to add new tasks.',
    ),
    Task(
      title: 'Handle Task State',
      description: 'Implement logic to mark tasks as completed.',
    ),
    Task(
      title: 'Refactor Code',
      description: 'Split code into reusable components.',
    ),
    Task(title: 'Celebrate First App', isCompleted: true),
    Task(
      title: 'Plan Next Feature',
      description: 'Think about adding task categories.',
    ),
    Task(title: 'Share with a Friend'),

    // Expanded tasks
    Task(
      title: 'Implement Dark Mode',
      description: 'Add theme switching between light and dark.',
    ),
    Task(
      title: 'Optimize App Performance',
      description: 'Use const constructors and widget rebuild checks.',
    ),
    Task(
      title: 'Add Task Deletion',
      description: 'Allow users to delete tasks with confirmation.',
    ),
    Task(
      title: 'Add Search Functionality',
      description: 'Filter tasks by title or description.',
    ),
    Task(
      title: 'Add Task Categories',
      description: 'Organize tasks by categories like work, personal.',
    ),
    Task(
      title: 'Implement Notifications',
      description: 'Add local notifications for pending tasks.',
    ),
    Task(
      title: 'Use Provider for State Management',
      description: 'Switch from setState to Provider.',
    ),
    Task(
      title: 'Test App on Emulator',
      description: 'Check responsiveness across multiple devices.',
      isCompleted: true,
    ),
    Task(
      title: 'Write Unit Tests',
      description: 'Cover business logic with test cases.',
    ),
    Task(
      title: 'Add Priority Levels',
      description: 'Mark tasks as high, medium, or low priority.',
    ),
    Task(
      title: 'Learn Dart Basics',
      description: 'Understand Dart syntax, functions, and classes.',
    ),
    Task(
      title: 'Improve App Logo',
      description: 'Design or pick a clean Flutter icon.',
    ),
    Task(
      title: 'Add Onboarding Screens',
      description: 'Show a quick app intro for first-time users.',
    ),
    Task(
      title: 'Implement User Authentication',
      description: 'Allow login and signup functionality.',
    ),
    Task(
      title: 'Connect Firebase',
      description: 'Save tasks to Firebase Realtime Database.',
    ),
    Task(
      title: 'Add Offline Support',
      description: 'Cache tasks locally for offline access.',
    ),
    Task(
      title: 'Sync Across Devices',
      description: 'Enable sync with Google account.',
    ),
    Task(
      title: 'Polish UI with Animations',
      description: 'Add Hero transitions and fade animations.',
    ),
    Task(
      title: 'Implement Swipe Actions',
      description: 'Swipe left or right to complete/delete task.',
    ),
    Task(
      title: 'Export Tasks to CSV',
      description: 'Add an option to download task history.',
    ),
    Task(
      title: 'Create Settings Page',
      description: 'Allow customization of preferences.',
    ),
    Task(
      title: 'Enable Drag and Drop',
      description: 'Reorder tasks by dragging them.',
    ),
    Task(
      title: 'Add Voice Input',
      description: 'Create tasks using speech recognition.',
    ),
    Task(
      title: 'Learn Flutter Navigation',
      description: 'Understand push and pop in Navigator 2.0.',
    ),
    Task(
      title: 'Build APK File',
      description: 'Generate a release build for Android.',
      isCompleted: true,
    ),
    Task(
      title: 'Deploy to Play Store',
      description: 'Publish the first version of the app.',
    ),
    Task(
      title: 'Create iOS Build',
      description: 'Generate iOS release build using Xcode.',
    ),
    Task(
      title: 'Handle App Permissions',
      description: 'Request permissions like notifications and storage.',
    ),
    Task(
      title: 'Collect User Feedback',
      description: 'Add a feedback form inside the app.',
    ),
    Task(
      title: 'Create About Page',
      description: 'Display app version and developer info.',
    ),
    Task(
      title: 'Use Custom Fonts',
      description: 'Integrate Google Fonts for better typography.',
    ),
    Task(
      title: 'Add Task Deadlines',
      description: 'Allow setting due dates for tasks.',
    ),
    Task(
      title: 'Sort Tasks by Deadline',
      description: 'Sort and group tasks by their due dates.',
    ),
    Task(
      title: 'Handle Empty States',
      description: 'Show illustrations when no tasks exist.',
    ),
    Task(
      title: 'Integrate Lottie Animations',
      description: 'Use animations to enhance user experience.',
    ),
    Task(
      title: 'Add Task Progress Bar',
      description: 'Show percentage of tasks completed.',
    ),
    Task(
      title: 'Enable Data Backup',
      description: 'Allow exporting and importing user data.',
    ),
    Task(
      title: 'Add Daily Reminders',
      description: 'Notify users every morning about pending tasks.',
    ),
    Task(
      title: 'Polish App for Release',
      description: 'Fix bugs, test thoroughly, and optimize assets.',
    ),
  ];

  List<Task> _getTasksForPage(int index) {
    if (index == 0) {
      return _tasks.where((task) => !task.isCompleted).toList();
    } else {
      return _tasks.where((task) => task.isCompleted).toList();
    }
  }

  // void _toggleTaskCompletion(Task task) {
  //   setState(() {
  //     task.isCompleted = !task.isCompleted;
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return DefaultTabController(
  //     length: 2,
  //     child: Scaffold(
  //       appBar: AppBar(title: Text(widget.title)),
  //       bottomNavigationBar: BottomNavigationBar(
  //         currentIndex: _currentIndex,
  //         onTap: (index) => setState(() => _currentIndex = index),
  //         items: const [
  //           BottomNavigationBarItem(icon: Icon(Icons.task), label: "Tasks"),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.check_circle),
  //             label: "Completed",
  //           ),
  //         ],
  //         showUnselectedLabels: false,
  //       ),
  //       body: SafeArea(child: _buildBodyForIndex(_currentIndex)),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // final tasksToShow = _getTasksForPage(_currentIndex);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),

      // ✅ Drawer only on Tasks tab (index 0)
      drawer: _currentIndex == 0
          ? Drawer(
              child: Column(
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(color: Colors.deepPurple),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Task Manager",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text("About"),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Settings"),
                    onTap: () => Navigator.pop(context),
                  ),
                  ListTile(
                    leading: const Icon(Icons.feedback),
                    title: const Text("Feedback"),
                    onTap: () => Navigator.pop(context),
                  ),
                ],
              ),
            )
          : null,

      body: SafeArea(child: _buildBodyForIndex(_currentIndex)),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: "Tasks"),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: "Completed",
          ),
        ],
      ),
    );
  }

  // Widget _buildBodyForIndex(int index) {
  //   final tasksToShow = _getTasksForPage(index);

  //   if (tasksToShow.isEmpty) {
  //     return Center(child: Text("No tasks yet! Add one to get started."));
  //   }

  //   return ListView.builder(
  //     itemCount: tasksToShow.length,
  //     itemBuilder: (context, idx) {
  //       final task = tasksToShow[idx];

  //       return Dismissible(
  //         key: ValueKey(task.title), // Use a unique key for the item
  //         background: Container(
  //           color: Colors.green,
  //           alignment: Alignment.centerLeft,
  //           padding: const EdgeInsets.only(left: 20),
  //           child: const Icon(Icons.check, color: Colors.white),
  //         ),
  //         secondaryBackground: Container(
  //           color: Colors.red,
  //           alignment: Alignment.centerRight,
  //           padding: const EdgeInsets.only(right: 20),
  //           child: const Icon(Icons.delete_forever, color: Colors.white),
  //         ),
  //         direction: DismissDirection
  //             .startToEnd, // Only allow swiping from left to right
  //         onDismissed: (direction) {
  //           setState(() {
  //             if (direction == DismissDirection.startToEnd) {
  //               // If the user swipes, toggle the task as completed.
  //               _toggleTaskCompletion(task);
  //             }
  //           });
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             SnackBar(
  //               content: Text(
  //                 task.isCompleted
  //                     ? 'Task marked as completed.'
  //                     : 'Task marked as uncompleted.',
  //               ),
  //             ),
  //           );
  //         },
  //         child: TaskCard(task: task),
  //       );
  //     },
  //   );
  // }

  Widget _buildBodyForIndex(int index) {
    final tasksToShow = _getTasksForPage(index);

    // ✅ For Completed tab
    if (index == 1) {
      final TextEditingController inputController = TextEditingController();

      return Column(
        children: [
          Expanded(
            child: tasksToShow.isEmpty
                ? const Center(child: Text("No completed tasks yet!"))
                : ListView.builder(
                    itemCount: tasksToShow.length,
                    itemBuilder: (context, idx) {
                      final task = tasksToShow[idx];
                      return TaskCard(task: task);
                    },
                  ),
          ),
          TaskInput(
            controller: inputController,
            hintText: "Add a note for completed tasks...",
            onSubmit: () {
              if (inputController.text.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Input: ${inputController.text}")),
                );
                inputController.clear();
              }
            },
          ),
        ],
      );
    }

    // ✅ For Tasks tab
    if (tasksToShow.isEmpty) {
      return const Center(child: Text("No tasks yet! Add one to get started."));
    }

    return ListView.builder(
      itemCount: tasksToShow.length,
      itemBuilder: (context, idx) {
        final task = tasksToShow[idx];
        return TaskCard(task: task);
      },
    );
  }
}
