import 'package:bloc_todo_app/cubits/cubits.dart';
import 'package:bloc_todo_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchAndFilterTodo extends StatelessWidget {
  const SearchAndFilterTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        decoration: const InputDecoration(
          labelText: 'search todos...',
          border: InputBorder.none,
          filled: true,
          prefix: Icon(Icons.search),
        ),
        onChanged: (String? newSearchTerm) {
          if (newSearchTerm != null && newSearchTerm.trim().isNotEmpty) {
            context.read<TodoSearchCubit>().changeSearchTerm(newSearchTerm);
          } else {
            context.read<TodoSearchCubit>().changeSearchTerm('');
          }
        },
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...Filter.values
              .map((filter) => filterButton(context, filter))
              .toList()
        ],
      )
    ]);
  }

  Widget filterButton(BuildContext context, Filter filter) {
    return TextButton(
        onPressed: () {
          context.read<TodoFilterCubit>().changeFilter(filter);
        },
        child: Text(filter.label,
            style: TextStyle(
                fontSize: 18,
                color: context.watch<TodoFilterCubit>().state.filter == filter
                    ? Colors.blueAccent
                    : Colors.grey)));
  }
}
