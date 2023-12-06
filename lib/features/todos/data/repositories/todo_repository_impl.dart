import 'package:bloc_tutorial_todo/features/todos/data/data_sources/local/dao/todo_dao.dart';
import 'package:bloc_tutorial_todo/features/todos/data/models/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl extends TodoRepository {
  final TodoDao _todoDao;

  TodoRepositoryImpl(this._todoDao);

  @override
  Future<List<TodoModel>> getAllItems() async {
    return _todoDao.getAllItems();
  }

  @override
  Future<TodoModel?> getItem(String id) async {
    return _todoDao.getItem(id);
  }

  @override
  Future<void> addItem(TodoEntity todoEntity) async {
    await _todoDao.addItem(todoEntity);
  }

  @override
  Future<void> updateItem(TodoEntity todoEntity) async {
    await _todoDao.updateItem(todoEntity);
  }

  @override
  Future<void> deleteItem(String id) async {
    await _todoDao.deleteItem(id);
  }

  @override
  Future<void> deleteAll() async {
    await _todoDao.deleteAll();
  }
}
