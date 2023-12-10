import 'package:bloc_tutorial_todo/core/network/failure.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/repositories/todo_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllUseCase {
  final TodoRepository _todoRepository;

  GetAllUseCase(this._todoRepository);

  Future<Either<Failure, List<TodoEntity>>> call([void params]) async {
    return _todoRepository.getAllItems();
  }
}
