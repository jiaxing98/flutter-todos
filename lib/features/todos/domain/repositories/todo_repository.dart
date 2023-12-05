import 'package:bloc_tutorial_todo/features/todos/data/models/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:hive/hive.dart';

abstract class TodoRepository {
  final String _boxName = 'todoBox';

  Future<Box<TodoModel>> get boxFromHive async =>
      await Hive.openBox<TodoModel>(_boxName);

  Future<List<TodoModel>> getAllItems();

  Future<TodoModel?> getItem(String id);

  Future<void> addItem(TodoEntity todoEntity);

  Future<void> updateItem(TodoEntity todoEntity);

  Future<void> deleteItem(String id);

  Future<void> deleteAll();
}
