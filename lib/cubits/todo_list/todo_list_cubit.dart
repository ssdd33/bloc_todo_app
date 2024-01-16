import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/models/todo_model.dart';
import 'package:equatable/equatable.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initial());

  void addTodo(String todoDesc) {
    emit(state.copyWith(todoList: [...state.todoList, Todo(desc: todoDesc)]));
  }

//XXX id가 아닌 Todo를 받는 이유? ui함수 호출시 간단하게 하려고?
  void removeTodo(Todo todo) {
    final newTodos = state.todoList.where((t) => t.id != todo.id).toList();
    emit(state.copyWith(todoList: newTodos));
  }

//XXX 새로운 todo를 반환하는 이유? 왜 state객체는 copywith로 유지하고 내부 객체는 새로운 객체인지
  void editTodo(String id, String newDesc) {
    final newTodos = state.todoList.map((todo) {
      if (todo.id == id) {
        return Todo(id: id, desc: newDesc, completed: todo.completed);
      }
      return todo;
    }).toList();

    emit(state.copyWith(todoList: newTodos));
  }

  void toggleTodo(String id) {
    emit(state.copyWith(
        todoList: state.todoList.map((todo) {
      if (todo.id == id) {
        return Todo(id: id, desc: todo.desc, completed: !todo.completed);
      }
      return todo;
    }).toList()));
  }
}
