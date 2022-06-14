import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mealthy/forget_password_screen.dart';
import 'package:mealthy/homepage.dart';
import 'package:mealthy/login_screen.dart';
import 'package:mealthy/nutrition.dart';
import 'package:mealthy/signup_screen.dart';
import 'package:mealthy/verification_sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MealThy',
      debugShowCheckedModeBanner: false,
      initialRoute: '/Login',
      routes: {
        '/HomePage': (context) => const HomePage(),
        '/Nutrition': (context) => const Nutrition(),
        //'/Verification_forgot_password': (context) => const VerificationPage(),
        '/Verification_sign_up': (context) => const VerificationPage_sign_up(),
        '/Login': (context) => const LoginPage(),
        '/ForgotPassword': (context) => const ForgetpasswordPage(),
        '/SignUp': (context) => const SignupPage(),
        //'/NewPassword': (context) => const NewpasswordPage(),
      },
    );
  }
}
