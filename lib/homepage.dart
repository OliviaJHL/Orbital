import 'package:flutter/material.dart';
import 'package:mealthy/login_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "HOME",
              style: TextStyle(
                color: Color(0xFF0D47A1),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            MaterialButton(
              minWidth: double.infinity,
              height: 60,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => (const LoginPage())),
                );
              },
              color: Colors.orange,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Text(
                "Sign out",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}