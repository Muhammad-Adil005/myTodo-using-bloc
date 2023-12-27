import 'package:todo_app/models/todo_model.dart';

class TodoRepository {
  final List<Todo> _todos = [];

  List<Todo> getTodos() => _todos;

  void addTodo(Todo todo) => _todos.add(todo);

  void updateTodo(Todo updatedTodo) {
    // Find the todo by id and replace it with the updated one
    int index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      _todos[index] = updatedTodo;
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }
}
