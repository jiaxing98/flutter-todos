import 'package:bloc_tutorial_todo/core/usecase.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/repositories/todo_repository.dart';

class DeleteAllUseCase extends UseCase<void, void> {
  final TodoRepository _todoRepository;

  DeleteAllUseCase(this._todoRepository);

  @override
  Future<void> call([void params]) async {
    return _todoRepository.deleteAll();
  }
}
