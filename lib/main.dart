import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/ui/splash_screen.dart';

import 'bloc/todo_bloc.dart';

void main() {
  runApp(const TodoBlocApp());
}

class TodoBlocApp extends StatelessWidget {
  const TodoBlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        // Providing TodoBloc to the entire app
        return BlocProvider(
            create: (context) => TodoBloc(TodoRepository()),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Todo Bloc App',
              // You can use the library anywhere in the app even in theme
              // theme: ThemeData(
              //   primarySwatch: Colors.blue,
              //   textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
              // ),
              home: SplashPage(),
            ));
      },
    );
  }
}
