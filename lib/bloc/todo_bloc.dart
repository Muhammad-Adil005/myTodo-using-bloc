import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/bloc/search_todo.dart';

import '../repository/todo_repository.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _todosRepository;

  TodoBloc(this._todosRepository) : super(TodosInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<SearchTodo>(_onSearchTodo); // Add this line
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    try {
      emit(TodosLoadInProgress());
      final todos = _todosRepository.getTodos();
      emit(TodosLoadSuccess(todos));
    } catch (e) {
      emit(TodosLoadFailure());
      // Handle exception, log error or notify user
    }
  }

  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    try {
      _todosRepository.addTodo(event.todo);
      final updatedTodos = _todosRepository.getTodos();
      emit(TodosLoadSuccess(updatedTodos));
    } catch (e) {
      emit(TodosLoadFailure());
      // Handle exception, log error or notify user
    }
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) {
    try {
      // Logic to handle the update. For example:
      _todosRepository.updateTodo(event.todo);
      final updatedTodos = _todosRepository.getTodos();
      emit(TodosLoadSuccess(updatedTodos));
    } catch (e) {
      emit(TodosLoadFailure());
      // Handle exception, log error or notify user
    }
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) {
    try {
      _todosRepository.deleteTodo(event.id);
      final updatedTodos = _todosRepository.getTodos();
      emit(TodosLoadSuccess(updatedTodos));
    } catch (e) {
      emit(TodosLoadFailure());
    }
  }

  void _onSearchTodo(SearchTodo event, Emitter<TodoState> emit) {
    final searchResults = _todosRepository
        .getTodos()
        .where((todo) => todo.title.toLowerCase().contains(event.query))
        .toList();
    emit(TodosLoadSuccess(searchResults));
  }
}
