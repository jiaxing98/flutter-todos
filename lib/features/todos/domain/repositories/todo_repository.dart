import 'package:bloc_tutorial_todo/core/mixins/handle_exception.dart';
import 'package:bloc_tutorial_todo/core/network/failure.dart';
import 'package:bloc_tutorial_todo/features/todos/data/models/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:dartz/dartz.dart';

abstract class TodoRepository with HandleExceptionMixin {
  Future<Either<Failure, List<TodoModel>>> getAllItems();

  Future<Either<Failure, TodoModel?>> getItem(String id);

  Future<Option<Failure>> addItem(TodoEntity todoEntity);

  Future<Option<Failure>> updateItem(TodoEntity todoEntity);

  Future<Option<Failure>> deleteItem(String id);

  Future<Option<Failure>> deleteAll();
}
