import 'package:flutter/material.dart';
import 'package:mealthy/login_screen.dart';
//import 'package:mealthy/new_password.dart';
//import 'package:mealthy/login_screen.dart';
import 'package:mealthy/signup_screen.dart';
//import 'package:mealthy/splash.dart';
//import 'package:mealthy/verification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      //SignupPage(),
    );
  }
}