import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/widgets/todo_card.dart';
import 'package:flutter/material.dart';

class TodoList extends StatelessWidget {
  final List<TodoEntity> todos;
  final String status;

  const TodoList({
    super.key,
    required this.todos,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: Row(
            children: [
              Text(
                '$status: ',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (_, index) {
            return TodoCard(
              todo: todos[index],
            );
          },
        ),
      ],
    );
  }
}
