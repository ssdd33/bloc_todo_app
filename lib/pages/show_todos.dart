import 'package:bloc_todo_app/cubits/cubits.dart';
import 'package:bloc_todo_app/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowTodos extends StatelessWidget {
  const ShowTodos({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.watch<FilteredTodosCubit>().state.filteredTodos;
    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListCubit, TodoListState>(listener: (context, state) {
          context.read<FilteredTodosCubit>().setFilteredTodos(
                state.todoList,
                context.read<TodoSearchCubit>().state.searchTerm,
                context.read<TodoFilterCubit>().state.filter,
              );
        }),
        BlocListener<TodoFilterCubit, TodoFilterState>(
            listener: (context, state) {
          context.read<FilteredTodosCubit>().setFilteredTodos(
                context.read<TodoListCubit>().state.todoList,
                context.read<TodoSearchCubit>().state.searchTerm,
                state.filter,
              );
        }),
        BlocListener<TodoSearchCubit, TodoSearchState>(
            listener: (context, state) {
          context.read<FilteredTodosCubit>().setFilteredTodos(
                context.read<TodoListCubit>().state.todoList,
                state.searchTerm,
                context.read<TodoFilterCubit>().state.filter,
              );
        })
      ],
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return Dismissible(
              key: ValueKey(todos[index].id),
              background: showBackground(1),
              secondaryBackground: showBackground(0),
              onDismissed: (_) {
                context.read<TodoListCubit>().removeTodo(todos[index]);
              },
              child: TodoItem(todo: todos[index]));
        },
        separatorBuilder: (_, __) {
          return const Divider(color: Colors.grey);
        },
      ),
    );
  }

  Widget showBackground(int direction) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.all(4),
      color: Colors.redAccent,
      alignment: direction == 1 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        color: Colors.white,
        size: 30,
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          context.read<TodoListCubit>().toggleTodo(widget.todo.id);
        },
      ),
      title: Text(widget.todo.desc),
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              bool error = false;
              _textEditingController.text = widget.todo.desc;
              return StatefulBuilder(
                builder: (BuildContext context, setState) {
                  return AlertDialog(
                    title: const Text('edit'),
                    content: TextField(
                      controller: _textEditingController,
                      autofocus: true,
                      decoration: InputDecoration(
                          errorText: error ? "text is can't be empty" : ''),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('CANCEL')),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              error = _textEditingController.text.isEmpty;
                              if (!error) {
                                context.read<TodoListCubit>().editTodo(
                                    widget.todo.id,
                                    _textEditingController.text);
                                Navigator.pop(context);
                              }
                            });
                          },
                          child: const Text('EDIT'))
                    ],
                  );
                },
              );
            });
      },
    );
  }
}
