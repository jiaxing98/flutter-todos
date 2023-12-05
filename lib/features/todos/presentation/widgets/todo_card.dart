import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/bloc/todos_event.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/bloc/todos_state.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/pages/add_todo_page.dart';
import 'package:bloc_tutorial_todo/shared/dialog/bloc/dialog_bloc.dart';
import 'package:bloc_tutorial_todo/shared/dialog/bloc/dialog_event.dart';
import 'package:bloc_tutorial_todo/shared/dialog/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCard extends StatelessWidget {
  final TodoEntity todo;

  const TodoCard({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddTodoPage(existingTodo: todo),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                todo.task,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              BlocBuilder<TodosBloc, TodosState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<TodosBloc>().add(
                                UpdateTodo(
                                  todo: todo.copyWith(
                                    isCompleted: !todo.isCompleted,
                                  ),
                                ),
                              );
                        },
                        icon: Icon(
                          Icons.add_task,
                          color: todo.isCompleted ? Colors.green : Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context
                              .read<DialogBloc>()
                              .add(OpenDialog(builder: _confirmationDialog));
                        },
                        icon: const Icon(Icons.cancel),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _confirmationDialog(BuildContext context) {
    return ConfirmationDialog(
      title: 'ALERT',
      content: 'Do you want to delete todo "${todo.task}"?',
      positiveLabel: 'YES',
      negativeLabel: 'NO',
      onPositive: () => context.read<TodosBloc>().add(DeleteTodo(id: todo.id)),
    );
  }
}
