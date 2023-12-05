import 'package:bloc_tutorial_todo/core/usecase.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/repositories/todo_repository.dart';

class UpdateTodoUseCase extends UseCase<void, TodoEntity> {
  final TodoRepository _todoRepository;

  UpdateTodoUseCase(this._todoRepository);

  @override
  Future<void> call([TodoEntity? params]) async {
    _todoRepository.updateItem(params!);
  }
}
