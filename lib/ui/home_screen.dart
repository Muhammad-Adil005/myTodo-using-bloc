import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/search_todo.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import '../models/todo_model.dart';
import 'create_todo.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String _searchQuery = "";

    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        title: Text(
          'ToDo App',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        // actions: [
        //   Padding(
        //     padding: EdgeInsets.only(right: 10.w),
        //     child: Text(
        //       '5 items left',
        //       style: TextStyle(
        //         color: Colors.pinkAccent,
        //       ),
        //     ),
        //   ),
        // ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          // Navigate to the CreateTodoScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateTodoScreen(),
            ),
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 30.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'what to do? ',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 10.h),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search Todos .....',
                    prefixIcon: Icon(Icons.search),
                    // Border when TextField is not in focus
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    // Border when TextField is in focus
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    // Border when TextField is being interacted with
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    // Dispatch SearchTodo event
                    BlocProvider.of<TodoBloc>(context)
                        .add(SearchTodo(value.toLowerCase()));
                  },
                ),

                // TabBar with Tabs
                DefaultTabController(
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        tabs: [
                          Tab(text: 'All'),
                          Tab(text: 'Active'),
                          Tab(text: 'Completed'),
                        ],
                      ),
                      Container(
                        height: 300.h,
                        child: TabBarView(
                          children: [
                            // All Tasks Tab
                            BlocBuilder<TodoBloc, TodoState>(
                              builder: (context, state) {
                                if (state is TodosLoadSuccess) {
                                  return _buildTodoList(context, state.todos);
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                            // Active Tasks Tab
                            // Inside Active Tasks Tab BlocBuilder
                            BlocBuilder<TodoBloc, TodoState>(
                              builder: (context, state) {
                                if (state is TodosLoadSuccess) {
                                  final activeTodos = state.todos
                                      .where((todo) => !todo.isComplete)
                                      .toList();
                                  return _buildTodoList(context, activeTodos);
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),

                            // Completed Tasks Tab
                            BlocBuilder<TodoBloc, TodoState>(
                              builder: (context, state) {
                                if (state is TodosLoadSuccess) {
                                  var completedTodos = state.todos
                                      .where((todo) => todo.isComplete)
                                      .toList();
                                  return _buildTodoList(
                                      context, completedTodos);
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // A helper method to build the todo list
  Widget _buildTodoList(BuildContext context, List<Todo> todos) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        var todo = todos[index];
        return ListTile(
          title: Text(
            todo.title,
            style: TextStyle(
              color: todo.isComplete ? Colors.grey : Colors.black,
              decoration: todo.isComplete ? TextDecoration.lineThrough : null,
            ),
          ),
          leading: Checkbox(
            value: todo.isComplete,
            onChanged: (bool? newValue) {
              // Create a new updated todo
              Todo updatedTodo = todo.copyWith(isComplete: newValue);
              // Dispatch an UpdateTodo event with the updated todo
              context.read<TodoBloc>().add(UpdateTodo(updatedTodo));
            },
          ),
        );
      },
    );
  }
}
