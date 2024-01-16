import 'package:bloc_todo_app/cubits/cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "TODO",
          style: TextStyle(fontSize: 40),
        ),

        BlocListener<TodoListCubit, TodoListState>(
          listener: (context, state) {
            context
                .read<ActiveTodoCountCubit>()
                .setTodoActiveCount(state.todoList);
          },
          child: BlocBuilder<ActiveTodoCountCubit, ActiveTodoCountState>(
            builder: (context, state) {
              return Text(
                '${state.activeTodoCount} items left',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.redAccent,
                ),
              );
            },
          ),
        )

        //  Text('${context.watch<ActiveTodoCount>().state.activeTodoCount} items left',
        // style: TextStyle(fontSize: 20, color: Colors.redAccent))
      ],
    );
  }
}
