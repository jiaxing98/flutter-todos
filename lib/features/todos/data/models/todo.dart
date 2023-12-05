import 'package:bloc_tutorial_todo/features/todos/domain/entities/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class TodoModel extends TodoEntity {
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String task;

  @HiveField(2)
  final String description;

  @HiveField(3, defaultValue: false)
  final bool isCompleted;

  TodoModel({
    required this.id,
    required this.task,
    required this.description,
    this.isCompleted = false,
  }) : super(
          id: id,
          task: task,
          description: description,
          isCompleted: isCompleted,
        );

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      id: entity.id,
      task: entity.task,
      description: entity.description,
      isCompleted: entity.isCompleted,
    );
  }
}
