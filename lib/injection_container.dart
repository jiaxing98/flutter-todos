import 'package:bloc_tutorial_todo/features/todos/data/data_sources/local/dao/todo_dao.dart';
import 'package:bloc_tutorial_todo/features/todos/data/data_sources/local/dao/todo_dao_impl.dart';
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
import 'package:bloc_tutorial_todo/features/weather/data/data_sources/remote/weather_service.dart';
import 'package:bloc_tutorial_todo/features/weather/data/repositories/weather_repositories_impl.dart';
import 'package:bloc_tutorial_todo/features/weather/domain/repositories/weather_repositories.dart';
import 'package:bloc_tutorial_todo/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:bloc_tutorial_todo/shared/bottom_tabs/bloc/bottom_tabs_bloc.dart';
import 'package:bloc_tutorial_todo/shared/dialog/bloc/dialog_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

import 'features/weather/domain/usecases/get_current_weather.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());

  // DAO
  sl.registerSingleton<TodoDao>(TodoDaoImpl());

  // Dio
  sl.registerSingleton(Dio());

  // Service
  sl.registerSingleton<WeatherService>(WeatherServiceImpl(sl()));

  // Repositories
  sl.registerSingleton<TodoRepository>(TodoRepositoryImpl(sl()));
  sl.registerSingleton<WeatherRepository>(WeatherRepositoryImpl(sl()));

  // Usecases
  sl.registerLazySingleton<GetAllUseCase>(() => GetAllUseCase(sl()));
  sl.registerLazySingleton<GetTodoUseCase>(() => GetTodoUseCase(sl()));
  sl.registerLazySingleton<AddTodoUseCase>(() => AddTodoUseCase(sl()));
  sl.registerLazySingleton<UpdateTodoUseCase>(() => UpdateTodoUseCase(sl()));
  sl.registerLazySingleton<DeleteTodoUseCase>(() => DeleteTodoUseCase(sl()));
  sl.registerLazySingleton<DeleteAllUseCase>(() => DeleteAllUseCase(sl()));

  sl.registerLazySingleton<GetCurrentWeatherUseCase>(
      () => GetCurrentWeatherUseCase(sl()));

  // Bloc
  sl.registerSingleton(BottomTabsBloc());

  sl.registerSingleton<DialogBloc>(DialogBloc());

  sl.registerSingleton<TodosBloc>(
    TodosBloc(sl(), sl(), sl(), sl(), sl(), sl()),
  );

  sl.registerSingleton<WeatherBloc>(WeatherBloc(sl()));
}
