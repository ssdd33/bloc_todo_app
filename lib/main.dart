import 'package:bloc_todo_app/cubits/active_todo_count/active_todo_count_cubit.dart';
import 'package:bloc_todo_app/cubits/filtered_todos/filtered_todos_cubit.dart';
import 'package:bloc_todo_app/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:bloc_todo_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:bloc_todo_app/cubits/todo_search/todo_search_cubit.dart';
import 'package:bloc_todo_app/pages/todos_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoListCubit>(create: (context) => TodoListCubit()),
        BlocProvider<TodoFilterCubit>(create: (context) => TodoFilterCubit()),
        BlocProvider<TodoSearchCubit>(create: (context) => TodoSearchCubit()),
        BlocProvider<ActiveTodoCountCubit>(
            create: (context) => ActiveTodoCountCubit(
                initialActiveTodoCount:
                    context.read<TodoListCubit>().state.todoList.length,
                todoListCubit: context.read<TodoListCubit>())),
        BlocProvider<FilteredTodosCubit>(
            create: (context) => FilteredTodosCubit(
                  searchTermCubit: context.read<TodoSearchCubit>(),
                  todoListCubit: context.read<TodoListCubit>(),
                  todoFilterCubit: context.read<TodoFilterCubit>(),
                )),
      ],
      child: MaterialApp(
        title: 'todo app',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TodosPage(),
      ),
    );
  }
}
