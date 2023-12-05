import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/bloc/todos_event.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/bloc/todos_state.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/widgets/todo_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTodoPage extends StatelessWidget {
  final TodoEntity? existingTodo;
  const AddTodoPage({
    Key? key,
    this.existingTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerTask =
        TextEditingController(text: existingTodo?.task);
    TextEditingController controllerDescription =
        TextEditingController(text: existingTodo?.description);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BloC Pattern: ${existingTodo == null ? "Add a To Do" : "Update a To Do"}',
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is TodosEmpty || state is TodosLoaded) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TodoInputField(
                        field: 'Task',
                        controller: controllerTask,
                      ),
                      TodoInputField(
                        field: 'Description',
                        controller: controllerDescription,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (existingTodo == null) {
                            var newTodo = TodoEntity(
                              task: controllerTask.value.text,
                              description: controllerDescription.value.text,
                            );
                            context
                                .read<TodosBloc>()
                                .add(AddTodo(todo: newTodo));
                          } else {
                            var updateTodo = existingTodo!.copyWith(
                              task: controllerTask.value.text,
                              description: controllerDescription.value.text,
                            );
                            context
                                .read<TodosBloc>()
                                .add(UpdateTodo(todo: updateTodo));
                          }

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                        ),
                        child: Text(
                          existingTodo != null ? 'Add To Do' : 'Update To Do',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Text('Something went wrong.');
            }
          },
        ),
      ),
    );
  }
}
