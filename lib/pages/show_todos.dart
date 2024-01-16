import 'package:bloc_todo_app/cubits/cubits.dart';
import 'package:bloc_todo_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosCubit>().state.filteredTodos;
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return Text(todos[index].desc);
      },
      separatorBuilder: (_, __) {
        return const Divider(color: Colors.grey);
      },
    );
  }

  Widget todoItem(Todo todo) {
    return const ListTile();
  }
}
