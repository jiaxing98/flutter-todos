import 'package:bloc_tutorial_todo/core/network/failure.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/repositories/todo_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteAllUseCase {
  final TodoRepository _todoRepository;

  DeleteAllUseCase(this._todoRepository);

  Future<Option<Failure>> call([void params]) async {
    return _todoRepository.deleteAll();
  }
}
