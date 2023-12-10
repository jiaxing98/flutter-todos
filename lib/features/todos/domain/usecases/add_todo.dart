import 'package:bloc_tutorial_todo/core/network/failure.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/repositories/todo_repository.dart';
import 'package:dartz/dartz.dart';

class AddTodoUseCase {
  final TodoRepository _todoRepository;

  AddTodoUseCase(this._todoRepository);

  Future<Option<Failure>> call([TodoEntity? params]) async {
    return _todoRepository.addItem(params!);
  }
}
