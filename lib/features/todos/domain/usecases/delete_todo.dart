import 'package:bloc_tutorial_todo/core/network/failure.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/repositories/todo_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteTodoUseCase {
  final TodoRepository _todoRepository;

  DeleteTodoUseCase(this._todoRepository);

  Future<Option<Failure>> call([String? params]) async {
    return _todoRepository.deleteItem(params!);
  }
}
