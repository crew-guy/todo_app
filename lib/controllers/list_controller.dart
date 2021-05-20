//! FOR LOCALLY MANAGED TODO LIST

// import 'package:todo_app/models/todo.dart';
// import 'package:todo_app/services/database.dart';
// import 'package:flutter/material.dart';

// class ListController {
//   final Database database;
//   List<TodoModel> todoList = List();

//   ListController({this.database});

//   void addTodo(TodoModel todo) {
//     todoList.add(todo);
//   }

//   void checkBoxSelected(bool newValue, int index) {
//     todoList[index].done = newValue;
//   }

//   void clear() {
//     todoList.clear();
//   }

//   Future<void> loadFromDatabase() async {
//     todoList.add(await database.loadDatabase());
//   }
// }
