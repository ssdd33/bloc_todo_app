import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/models/todo_model.dart';
import 'package:equatable/equatable.dart';

part 'filtered_todos_state.dart';

class FilteredTodosCubit extends Cubit<FilteredTodosState> {
  final List<Todo> initialTodoList;
  FilteredTodosCubit({required this.initialTodoList})
      : super(FilteredTodosState(filteredTodos: initialTodoList));

  setFilteredTodos(List<Todo> todos, String searchTerm, Filter filter) {
    List<Todo> filteredTodos;

    switch (filter) {
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
      filteredTodos = filteredTodos.where((todo) {
        return todo.desc.toLowerCase().contains(searchTerm.toLowerCase());
      }).toList();
    }
    emit(state.copyWith(filteredTodos: filteredTodos));
  }
}
