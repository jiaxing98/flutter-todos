import 'package:bloc_tutorial_todo/core/network/failure.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/repositories/todo_repository.dart';
import 'package:dartz/dartz.dart';

class GetTodoUseCase {
  final TodoRepository _todoRepository;

  GetTodoUseCase(this._todoRepository);

  Future<Either<Failure, TodoEntity?>> call([String? params]) async {
    return _todoRepository.getItem(params!);
  }
}
