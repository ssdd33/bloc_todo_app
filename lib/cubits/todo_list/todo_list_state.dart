part of 'todo_list_cubit.dart';

class TodoListState extends Equatable {
  final List<Todo> todoList;
  const TodoListState({
    required this.todoList,
  });
  factory TodoListState.initial() {
    return TodoListState(todoList: [
      Todo(id: '1', desc: 'live your time'),
      Todo(id: '2', desc: 'stay healthy'),
      Todo(id: '3', desc: 'being own'),
    ]);
  }

  @override
  List<Object?> get props => [todoList];

  TodoListState copyWith({
    List<Todo>? todoList,
  }) {
    return TodoListState(
      todoList: todoList ?? this.todoList,
    );
  }

  @override
  String toString() => 'TodoListState(todoList: $todoList)';
}
