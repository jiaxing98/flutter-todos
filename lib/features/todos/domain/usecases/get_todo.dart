import 'package:bloc_tutorial_todo/core/usecase.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/repositories/todo_repository.dart';

class GetTodoUseCase extends UseCase<void, String> {
  final TodoRepository _todoRepository;

  GetTodoUseCase(this._todoRepository);

  @override
  Future<void> call([String? params]) async {
    _todoRepository.getItem(params!);
  }
}
