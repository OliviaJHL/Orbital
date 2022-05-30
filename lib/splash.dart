import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mealthy/login_screen.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,

              colors: [Color(0xFF01579B),Color(0xFF01579B),]
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/logo.png",
                  height: 300.0,
                  width: 300.0,
                ),
              ],
            ),

            const CircularProgressIndicator(
              valueColor:  AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}