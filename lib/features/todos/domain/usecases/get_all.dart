import 'package:bloc_tutorial_todo/core/usecase.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/repositories/todo_repository.dart';

class GetAllUseCase extends UseCase<List<TodoEntity>, void> {
  final TodoRepository _todoRepository;

  GetAllUseCase(this._todoRepository);

  @override
  Future<List<TodoEntity>> call([void params]) async {
    return _todoRepository.getAllItems();
  }
}
