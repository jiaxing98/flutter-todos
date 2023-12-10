import 'package:bloc_tutorial_todo/features/todos/domain/usecases/add_todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/usecases/delete_all.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/usecases/delete_todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/usecases/get_all.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/usecases/get_todo.dart';
import 'package:bloc_tutorial_todo/features/todos/domain/usecases/update_todo.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/bloc/todos_event.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/bloc/todos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final GetAllUseCase _getAllTodosUseCases;
  final GetTodoUseCase _getTodoUseCase;
  final AddTodoUseCase _addTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;
  final DeleteAllUseCase _deleteAllUseCase;

  TodosBloc(
    this._getAllTodosUseCases,
    this._getTodoUseCase,
    this._addTodoUseCase,
    this._updateTodoUseCase,
    this._deleteTodoUseCase,
    this._deleteAllUseCase,
  ) : super(const TodosEmpty()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<DeleteAll>(_onDeleteAll);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodosState> emit) async {
    emit(const TodosLoading());

    final result = await _getAllTodosUseCases();
    result.fold(
      (failure) => emit(const TodosError()),
      (data) {
        emit(TodosLoaded(todos: data));
      },
    );
  }

  void _onAddTodo(AddTodo event, Emitter<TodosState> emit) async {
    emit(const TodosLoading());

    final result = await _addTodoUseCase(event.todo);
    result.fold(
      () async => add(const LoadTodos()),
      (failure) => emit(const TodosError()),
    );
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodosState> emit) async {
    emit(const TodosLoading());

    final result = await _updateTodoUseCase(event.todo);
    result.fold(
      () => add(const LoadTodos()),
      (failure) => emit(const TodosError()),
    );
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodosState> emit) async {
    emit(const TodosLoading());

    final result = await _deleteTodoUseCase(event.id);
    result.fold(
      () => add(const LoadTodos()),
      (failure) => emit(const TodosError()),
    );
  }

  void _onDeleteAll(DeleteAll event, Emitter<TodosState> emit) async {
    emit(const TodosLoading());

    final result = await _deleteAllUseCase();
    result.fold(
      () => add(const LoadTodos()),
      (failure) => emit(const TodosError()),
    );
  }
}
