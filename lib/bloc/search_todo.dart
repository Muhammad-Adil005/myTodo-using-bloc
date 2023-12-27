import 'package:todo_app/bloc/todo_event.dart';

class SearchTodo extends TodoEvent {
  final String query;

  SearchTodo(this.query);

  @override
  List<Object> get props => [query];
}
