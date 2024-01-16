import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/cubits/todo_list/todo_list_cubit.dart';
import 'package:equatable/equatable.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  final TodoListCubit todoListCubit;
  late final StreamSubscription todoListStream;
  ActiveTodoCountCubit({required this.todoListCubit})
      : super(ActiveTodoCountState.initial()) {
    todoListStream = todoListCubit.stream.listen((todoListState) {
      print('todoListState: $todoListState');
      final activeTodoCount = todoListState.todoList
          .where((todo) => !todo.completed)
          .toList()
          .length;
      emit(state.copyWith(activeTodoCount: activeTodoCount));
    });
  }
  @override
  Future<void> close() {
    todoListStream.cancel();
    return super.close();
  }
}
