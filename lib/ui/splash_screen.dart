import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/home_screen.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      backgroundImage: AssetImage('assets/OurTodo.png'),
      logo: Image.asset('assets/OurTodo.png'), // Your transparent image
      navigator: HomeScreen(),
      durationInSeconds: 5,
      showLoader: false,
    );
  }
}
