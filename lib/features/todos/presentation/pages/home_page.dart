import 'package:bloc_tutorial_todo/core/constants/enums.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/bloc/todos_event.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/bloc/todos_state.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/pages/add_todo_page.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/widgets/todo_list.dart';
import 'package:bloc_tutorial_todo/shared/dialog/bloc/dialog_bloc.dart';
import 'package:bloc_tutorial_todo/shared/dialog/bloc/dialog_event.dart';
import 'package:bloc_tutorial_todo/shared/dialog/widgets/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BloC Pattern: To Dos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTodoPage(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              context.read<DialogBloc>().add(
                    OpenDialog(builder: _confirmationDialog),
                  );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<TodosBloc, TodosState>(
            builder: (context, state) {
              if (state is TodosEmpty) {
                return const Center(
                  child:
                      Text('Todo List is empty. Start by adding more tasks.'),
                );
              } else if (state is TodosLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TodosLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.pending.isNotEmpty)
                        TodoList(
                          todos: state.pending,
                          status: TodoStatus.pending.name.toUpperCase(),
                        ),
                      if (state.completed.isNotEmpty)
                        TodoList(
                          todos: state.completed,
                          status: TodoStatus.completed.name.toUpperCase(),
                        )
                    ],
                  ),
                );
              } else if (state is TodosError) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return const Center(
                  child: Text('Something went wrong.'),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _confirmationDialog(BuildContext context) {
    return ConfirmationDialog(
      title: 'ALERT',
      content: 'Do you want to delete all todos',
      positiveLabel: 'YES',
      negativeLabel: 'NO',
      onPositive: () => context.read<TodosBloc>().add(const DeleteAll()),
    );
  }
}
