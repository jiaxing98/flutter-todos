import 'package:bloc_tutorial_todo/features/todos/data/models/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';

abstract class TodoDao {
  Future<List<TodoModel>> getAllItems();

  Future<TodoModel?> getItem(String id);

  Future<void> addItem(TodoEntity todoEntity);

  Future<void> updateItem(TodoEntity todoEntity);

  Future<void> deleteItem(String id);

  Future<void> deleteAll();
}
