import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = Todo.todoList();
  String _filter = 'all'; // 'completed', 'not_completed', or 'all'
  String _searchQuery = "";
  bool _isSearching = false;
  final FocusNode _searchFocus = FocusNode();

  List<Todo> get _filteredTodoList {
    Iterable<Todo> filtered = todosList;
    switch (_filter) {
      case 'completed':
        filtered = filtered.where((todo) => todo.isDone);
        break;
      case 'not_completed':
        filtered = filtered.where((todo) => !todo.isDone);
        break;
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where(
        (todo) =>
            todo.todoText.toLowerCase().contains(_searchQuery.toLowerCase()),
      );
    }

    return filtered.toList();
  }

  void _toggleTodoStatus(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteTodoItem(String id) {
    // Find the Todo by its id
    final todo = todosList.firstWhere((t) => t.id == id);

    if (!todo.isDone) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.error_outline, color: Colors.white),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Please mark the task as done before deleting.',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,

          backgroundColor: Colors.redAccent.shade700,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          duration: const Duration(seconds: 2),
        ),
      );

      return;
    }

    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Filter Tasks',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  RadioListTile<String>(
                    title: const Text('All'),
                    value: 'all',
                    groupValue: _filter,
                    onChanged: (value) {
                      setState(() => _filter = value!);
                      this.setState(() {}); // Update the main UI
                      Navigator.pop(context);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Completed'),
                    value: 'completed',
                    groupValue: _filter,
                    onChanged: (value) {
                      setState(() => _filter = value!);
                      this.setState(() {}); // Update the main UI
                      Navigator.pop(context);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Not Completed'),
                    value: 'not_completed',
                    groupValue: _filter,
                    onChanged: (value) {
                      setState(() => _filter = value!);
                      this.setState(() {}); // Update the main UI
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showAddTodoDialog() {
    final TextEditingController todoController = TextEditingController();

    showDialog(
      context: context,
      fullscreenDialog: true,
      barrierDismissible: true, // user must tap buttons
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Add a new ToDo"),
          content: TextField(
            controller: todoController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Enter your task here...",
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: tdBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                final text = todoController.text.trim();
                if (text.isNotEmpty) {
                  setState(() {
                    todosList.insert(
                      0,
                      Todo(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        todoText: text,
                      ),
                    );
                  });
                }
                Navigator.pop(context); // close dialog
              },
              child: const Text("Add", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // _searchFocus.addListener(() {
    //   setState(() {
    //     _isSearching = _searchFocus.hasFocus;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _bluidAppBar(),
      body: GestureDetector(
        // onTap: () {
        //   FocusScope.of(context).unfocus(); // <- unfocus on outside tap
        // },
        onTap: () {
          FocusScope.of(context).unfocus(); // remove keyboard
          setState(() => _isSearching = false); // reset only here
        },
        child: _todoList(_filteredTodoList),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          height: 60,
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ElevatedButton(
            onPressed: _showAddTodoDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: tdBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              "+ Add a new ToDo",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    super.dispose();
  }

  Container _todoList(List<Todo> todosList) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          searchBox(),
          Expanded(
            child: todosList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // GIF Animation
                        Lottie.asset(
                          'assets/animations/notfound.json', // Lottie animation file
                          height: 200,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "No ToDos yet!\nAdd something to get started.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: todosList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Container(
                          margin: EdgeInsets.only(top: 30, bottom: 10),
                          child: Text(
                            'All ToDos (${todosList.length})',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }

                      final todo = todosList[index - 1];
                      return TodoItem(
                        todo: todo,
                        onToggle: () => _toggleTodoStatus(todo),
                        onDelete: () => _deleteTodoItem(todo.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                autofocus: false,
                focusNode: _searchFocus,
                onTap: () {
                  setState(() => _isSearching = true);
                },
                onChanged: (value) {
                  setState(() => _searchQuery = value);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
                  prefixIconConstraints: BoxConstraints(
                    maxHeight: 20,
                    minWidth: 25,
                  ),
                  border: InputBorder.none,
                  hintText: "Search",
                  hintStyle: TextStyle(color: tdGrey),
                ),
              ),
            ),
          ),

          SizedBox(width: 10),

          // Filter button that animates in/out
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axis: Axis.horizontal,
                child: child,
              ),
            ),
            child: _isSearching
                ? SizedBox.shrink()
                : GestureDetector(
                    key: ValueKey("filter"),
                    onTap: _showFilterModal,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: tdBlue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.filter_list, color: Colors.white),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  AppBar _bluidAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: tdBlack, size: 30),
          SizedBox(
            height: 40,
            width: 40,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/images/logo.jpg"),
            ),
          ),
        ],
      ),
    );
  }
}
