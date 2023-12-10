import 'package:bloc_tutorial_todo/core/network/failure.dart';
import 'package:bloc_tutorial_todo/features/todos/data/data_sources/local/dao/todo_dao.dart';
import 'package:bloc_tutorial_todo/features/todos/data/models/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/repositories/todo_repository.dart';
import 'package:dartz/dartz.dart';

class TodoRepositoryImpl extends TodoRepository {
  final TodoDao _todoDao;

  TodoRepositoryImpl(this._todoDao);

  @override
  Future<Either<Failure, List<TodoModel>>> getAllItems() async {
    try {
      var result = await _todoDao.getAllItems();
      //todo: model to entity
      return Right(result);
    } on Exception catch (ex) {
      var failure = handleLocalException(ex);
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, TodoModel?>> getItem(String id) async {
    try {
      var result = await _todoDao.getItem(id);
      return Right(result);
    } on Exception catch (ex) {
      var failure = handleLocalException(ex);
      return Left(failure);
    }
  }

  @override
  Future<Option<Failure>> addItem(TodoEntity todoEntity) async {
    try {
      await _todoDao.addItem(todoEntity);
      return const None();
    } on Exception catch (ex) {
      var failure = handleLocalException(ex);
      return Some(failure);
    }
  }

  @override
  Future<Option<Failure>> updateItem(TodoEntity todoEntity) async {
    try {
      await _todoDao.updateItem(todoEntity);
      return const None();
    } on Exception catch (ex) {
      var failure = handleLocalException(ex);
      return Some(failure);
    }
  }

  @override
  Future<Option<Failure>> deleteItem(String id) async {
    try {
      await _todoDao.deleteItem(id);
      return const None();
    } on Exception catch (ex) {
      var failure = handleLocalException(ex);
      return Some(failure);
    }
  }

  @override
  Future<Option<Failure>> deleteAll() async {
    try {
      await _todoDao.deleteAll();
      return const None();
    } on Exception catch (ex) {
      var failure = handleLocalException(ex);
      return Some(failure);
    }
  }
}
