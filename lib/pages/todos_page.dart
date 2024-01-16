import 'package:bloc_todo_app/pages/create_todo.dart';
import 'package:bloc_todo_app/pages/todo_header.dart';
import 'package:flutter/material.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          child: Column(
            children: [
              TodoHeader(),
              CreateTodo(),
            ],
          ),
        ),
      ),
    );
  }
}
