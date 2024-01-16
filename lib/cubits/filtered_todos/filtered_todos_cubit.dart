import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/cubits/todo_filter/todo_filter_cubit.dart';
import 'package:bloc_todo_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:bloc_todo_app/cubits/todo_search/todo_search_cubit.dart';
import 'package:bloc_todo_app/models/todo_model.dart';
import 'package:equatable/equatable.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  final TodoListCubit todoListCubit;
  final TodoFilterCubit todoFilterCubit;
  final TodoSearchCubit searchTermCubit;
  late final StreamSubscription todoListStream;
  late final StreamSubscription todoFilterStream;
  late final StreamSubscription searchTermStream;
  FilteredTodosCubit({
    required this.todoListCubit,
    required this.todoFilterCubit,
    required this.searchTermCubit,
  }) : super(FilteredTodosState.initial()) {
    todoListStream = todoListCubit.stream.listen((event) {
      setFilteredTodos();
    });
    todoFilterStream = todoFilterCubit.stream.listen((event) {
      setFilteredTodos();
    });
    searchTermStream = searchTermCubit.stream.listen((event) {
      setFilteredTodos();
    });
  }

  void setFilteredTodos() {
    List<Todo> filteredTodos;
    final todos = todoListCubit.state.todoList;
    final searchTerm = searchTermCubit.state.searchTerm;
    switch (todoFilterCubit.state.filter) {
      case Filter.all:
        filteredTodos = todos;
        break;
      case Filter.active:
        filteredTodos = todos.where((todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        filteredTodos = todos.where((todo) => todo.completed).toList();
        break;
    }

    if (searchTerm.isNotEmpty) {
      filteredTodos = todos.where((todo) {
        return todo.desc.toLowerCase().contains(searchTerm.toLowerCase());
      }).toList();
    }
    emit(state.copyWith(filteredTodos: filteredTodos));
  }

  @override
  Future<void> close() {
    todoListStream.cancel();
    todoFilterStream.cancel();
    searchTermStream.cancel();

    return super.close();
  }
}
