import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:equatable/equatable.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosEmpty extends TodosState {
  const TodosEmpty();
}

class TodosLoading extends TodosState {
  const TodosLoading();
}

class TodosLoaded extends TodosState {
  final List<TodoEntity> todos;
  const TodosLoaded({this.todos = const <TodoEntity>[]});

  List<TodoEntity> get pending => todos.where((e) => !e.isCompleted).toList();
  List<TodoEntity> get completed => todos.where((e) => e.isCompleted).toList();

  @override
  List<Object> get props => [todos];
}

class TodosError extends TodosState {
  final String message;

  const TodosError(this.message);
}
