import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = Todo.todoList();
  String _filter = 'all'; // 'completed', 'not_completed', or 'all'
  bool _isSearching = false;
  final FocusNode _searchFocus = FocusNode();

  List<Todo> get _filteredTodoList {
    switch (_filter) {
      case 'completed':
        return todosList.where((todo) => todo.isDone).toList();
      case 'not_completed':
        return todosList.where((todo) => !todo.isDone).toList();
      case 'all':
      default:
        return todosList;
    }
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
                      this.setState(() {});
                      Navigator.pop(context);
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Not Completed'),
                    value: 'not_completed',
                    groupValue: _filter,
                    onChanged: (value) {
                      setState(() => _filter = value!);
                      this.setState(() {});
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

  @override
  void initState() {
    super.initState();
    _searchFocus.addListener(() {
      setState(() {
        _isSearching = _searchFocus.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _bluidAppBar(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // <- unfocus on outside tap
        },
        child: _todoList(todosList),
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
            onPressed: () {},
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
      padding: const EdgeInsets.symmetric(horizontal: 10), // 10px padding
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: 50,
          width: double.infinity, // full width inside padding
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              TextField(
                focusNode: _searchFocus,
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
              // Filter icon on the right
              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                right: _isSearching ? -60 : 0, // slide out when focused
                top: 0,
                bottom: 0,
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _isSearching ? 0 : 1,
                  child: GestureDetector(
                    onTap: _showFilterModal,
                    child: Container(
                      width: 50,
                      height: 50,
                      color: tdBlue,
                      child: Icon(Icons.filter_list, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
