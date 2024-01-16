import 'package:bloc_todo_app/pages/create_todo.dart';
import 'package:bloc_todo_app/pages/search_and_filter_todo.dart';
import 'package:bloc_todo_app/pages/show_todos.dart';
import 'package:bloc_todo_app/pages/todo_header.dart';
import 'package:flutter/material.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 40,
          ),
          child: Column(
            children: [
              const TodoHeader(),
              const CreateTodo(),
              const SizedBox(height: 20),
              SearchAndFilterTodo(),
              const ShowTodos()
            ],
          ),
        ),
      ),
    );
  }
}
