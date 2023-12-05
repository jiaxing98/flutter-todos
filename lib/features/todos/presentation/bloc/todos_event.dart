import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:equatable/equatable.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodosEvent {
  const LoadTodos();
}

class AddTodo extends TodosEvent {
  final TodoEntity todo;

  const AddTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

class UpdateTodo extends TodosEvent {
  final TodoEntity todo;

  const UpdateTodo({required this.todo});

  @override
  List<Object> get props => [todo];
}

class DeleteTodo extends TodosEvent {
  final String id;

  const DeleteTodo({required this.id});

  @override
  List<Object> get props => [id];
}

class DeleteAll extends TodosEvent {
  const DeleteAll();
}
