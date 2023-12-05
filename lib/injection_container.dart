import 'package:bloc_tutorial_todo/features/todos/data/models/todo.dart';
import 'package:bloc_tutorial_todo/features/todos/data/repositories/todo_repository_impl.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/repositories/todo_repository.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/usecases/add_todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/usecases/delete_all.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/usecases/delete_todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/usecases/get_all.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/usecases/get_todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/usecases/update_todo.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:bloc_tutorial_todo/shared/dialog/bloc/dialog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());

  // Repositories
  sl.registerSingleton<TodoRepository>(TodoRepositoryImpl());

  // Usecases
  sl.registerLazySingleton<GetAllUseCase>(() => GetAllUseCase(sl()));
  sl.registerLazySingleton<GetTodoUseCase>(() => GetTodoUseCase(sl()));
  sl.registerLazySingleton<AddTodoUseCase>(() => AddTodoUseCase(sl()));
  sl.registerLazySingleton<UpdateTodoUseCase>(() => UpdateTodoUseCase(sl()));
  sl.registerLazySingleton<DeleteTodoUseCase>(() => DeleteTodoUseCase(sl()));
  sl.registerLazySingleton<DeleteAllUseCase>(() => DeleteAllUseCase(sl()));

  // Bloc
  sl.registerFactory<DialogBloc>(
    () => DialogBloc(),
  );

  sl.registerFactory<TodosBloc>(
    () => TodosBloc(sl(), sl(), sl(), sl(), sl(), sl()),
  );
}
