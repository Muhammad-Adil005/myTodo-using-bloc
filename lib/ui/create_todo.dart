import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../models/todo_model.dart';

class CreateTodoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Create Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'What needs to be done?',
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
                // If you want to fill the TextField
                filled: true,
                fillColor:
                    Colors.white, // Change this color according to your design
              ),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () {
                // Dispatch event to add todo
                final todoText = _textController.text;
                if (todoText.isNotEmpty) {
                  // Create a new Todo object (assuming you have defined id and title in your model)
                  Todo newTodo =
                      Todo(id: UniqueKey().toString(), title: todoText);

                  // Dispatch an AddTodo event to the bloc
                  context.read<TodoBloc>().add(AddTodo(newTodo));

                  // Close the screen after adding todo
                  Navigator.pop(context);
                }
              },
              child: Text('Add Todo'),
            ),
          ],
        ),
      ),
    );
  }
}
