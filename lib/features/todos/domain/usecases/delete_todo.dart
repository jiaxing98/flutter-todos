import 'package:bloc_tutorial_todo/core/usecase.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/repositories/todo_repository.dart';

class DeleteTodoUseCase extends UseCase<void, String> {
  final TodoRepository _todoRepository;

  DeleteTodoUseCase(this._todoRepository);

  @override
  Future<void> call([String? params]) async {
    _todoRepository.deleteItem(params!);
  }
}
