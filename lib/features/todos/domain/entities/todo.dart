import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class TodoEntity extends Equatable {
  final String id;
  final String task;
  final String description;
  final bool isCompleted;

  TodoEntity({
    String? id,
    required this.task,
    required this.description,
    this.isCompleted = false,
  }) : id = id ?? const Uuid().v1();

  TodoEntity copyWith({
    String? task,
    String? description,
    bool? isCompleted,
  }) {
    return TodoEntity(
      id: id,
      task: task ?? this.task,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        task,
        description,
        isCompleted,
      ];
}
