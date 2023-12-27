import 'package:equatable/equatable.dart';
import 'package:todo_app/models/todo_model.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object> get props => [];
}

class TodosInitial extends TodoState {}

class TodosLoadInProgress extends TodoState {}

class TodosLoadSuccess extends TodoState {
  final List<Todo> todos;
  TodosLoadSuccess(this.todos);
  @override
  List<Object> get props => [todos];
}

class TodosLoadFailure extends TodoState {}
