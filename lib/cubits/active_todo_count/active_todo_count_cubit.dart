import 'package:bloc/bloc.dart';
import 'package:bloc_todo_app/models/todo_model.dart';
import 'package:equatable/equatable.dart';

part 'active_todo_count_state.dart';

class ActiveTodoCountCubit extends Cubit<ActiveTodoCountState> {
  final int initialActiveTodoCount;

  ActiveTodoCountCubit({
    required this.initialActiveTodoCount,
  }) : super(ActiveTodoCountState(activeTodoCount: initialActiveTodoCount));
  setTodoActiveCount(List<Todo> todoList) {
    final activeTodoCount =
        todoList.where((todo) => !todo.completed).toList().length;
    emit(state.copyWith(activeTodoCount: activeTodoCount));
  }
}
