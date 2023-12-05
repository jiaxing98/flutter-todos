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
    await _crud(
      emit,
      mustLoaded: false,
      onAction: () => {},
    );
  }

  void _onAddTodo(AddTodo event, Emitter<TodosState> emit) async {
    await _crud(
      emit,
      mustLoaded: false,
      onAction: () => _addTodoUseCase(event.todo),
    );
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodosState> emit) async {
    await _crud(
      emit,
      mustLoaded: true,
      onAction: () => _updateTodoUseCase(event.todo),
    );
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodosState> emit) async {
    await _crud(
      emit,
      mustLoaded: true,
      onAction: () => _deleteTodoUseCase(event.id),
    );
  }

  void _onDeleteAll(DeleteAll event, Emitter<TodosState> emit) async {
    await _crud(
      emit,
      mustLoaded: true,
      onAction: () => _deleteAllUseCase(),
    );
  }

  Future _crud(
    Emitter<TodosState> emit, {
    required bool mustLoaded,
    required Function() onAction,
    Function()? onFinish,
    Function()? onError,
  }) async {
    if (mustLoaded) {
      emit(
        const TodosLoading(),
      );
    }

    try {
      await onAction();
      await Future.delayed(const Duration(milliseconds: 500));

      final todos = await _getAllTodosUseCases();
      if (todos.isEmpty) {
        emit(
          const TodosEmpty(),
        );
      } else {
        emit(
          TodosLoaded(todos: todos),
        );
      }
      await onFinish?.call();
    } catch (ex) {
      emit(
        TodosError(ex.toString()),
      );
      await onError?.call();
    }
  }
}
