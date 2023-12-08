import 'package:bloc_tutorial_todo/features/todos/presentation/bloc/todos_bloc.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/bloc/todos_event.dart';
import 'package:bloc_tutorial_todo/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:bloc_tutorial_todo/injection_container.dart';
import 'package:bloc_tutorial_todo/shared/bottom_tabs/bloc/bottom_tabs_bloc.dart';
import 'package:bloc_tutorial_todo/shared/bottom_tabs/widgets/bottom_tabs.dart';
import 'package:bloc_tutorial_todo/shared/dialog/bloc/dialog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BottomTabsBloc>(
          create: (_) => sl(),
        ),
        BlocProvider<DialogBloc>(
          create: (_) => sl(),
        ),
        BlocProvider<TodosBloc>(
          create: (_) => sl()..add(const LoadTodos()),
        ),
        BlocProvider<WeatherBloc>(
          create: (_) => sl(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const BottomTabs(),
      ),
    );
  }
}
