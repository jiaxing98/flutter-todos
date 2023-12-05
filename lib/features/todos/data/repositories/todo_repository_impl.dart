import 'package:bloc_tutorial_todo/features/todos/data/models/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  @override
  Future<List<TodoModel>> getAllItems() async {
    var box = await boxFromHive;
    return box.values.toList();
  }

  @override
  Future<TodoModel?> getItem(String id) async {
    var box = await boxFromHive;
    return box.get(id);
  }

  @override
  Future<void> addItem(TodoEntity todoEntity) async {
    var box = await boxFromHive;
    await box.put(todoEntity.id, TodoModel.fromEntity(todoEntity));
  }

  @override
  Future<void> updateItem(TodoEntity todoEntity) async {
    var box = await boxFromHive;
    await box.put(todoEntity.id, TodoModel.fromEntity(todoEntity));
  }

  @override
  Future<void> deleteItem(String id) async {
    var box = await boxFromHive;
    await box.delete(id);
  }

  @override
  Future<void> deleteAll() async {
    var box = await boxFromHive;
    await box.clear();
  }
}
