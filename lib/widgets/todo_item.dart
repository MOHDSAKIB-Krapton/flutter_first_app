import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        onTap: () {
          print("Clicked on Todo Item.");
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: todo.isDone
            ? Icon(Icons.check_box, color: tdBlue)
            : Icon(Icons.check_box_outline_blank, color: tdGrey),
        title: Text(
          todo.todoText,
          style: TextStyle(
            fontSize: 16,
            color: tdBlack,
            decoration: todo.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.symmetric(vertical: 12),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            // border: Border.all(width: 1, color: tdRed),
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            color: tdRed,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              print("Clicked on delete icon.");
            },
          ),
        ),
      ),
    );
  }
}
