import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constants/colors.dart';
import '../widgets/todo_item.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todosList = Todo.todoList();

    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _bluidAppBar(),
      body: _todoList(todosList),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          height: 60,
          decoration: BoxDecoration(
            // color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ElevatedButton(
            onPressed: () {
              print("Clicked on Add a new ToDo item.");
            },
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

  Container _todoList(List<Todo> todosList) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        children: [
          searchBox(),
          Expanded(
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 10),
                  child: Text(
                    "All ToDos",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  ),
                ),

                for (Todo todo in todosList) TodoItem(todo: todo),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search, color: tdBlack, size: 20),
          prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyle(color: tdGrey),
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
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
              child: Image.asset("assets/images/logo.jpg"),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}
