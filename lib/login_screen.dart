import 'package:flutter/material.dart';
import 'package:mealthy/forget_password_screen.dart';
import 'package:mealthy/signup_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: const <Widget>[
                    Text(
                      "Login",
                      style: TextStyle(
                        color: Color(0xFF0D47A1),
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text(
                      "Please continue to sign in",
                      style: TextStyle(
                          fontSize: 18.0,
                          color:Colors.black
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: <Widget>[
                      const TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                      ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgetpasswordPage()));
                      },
                      child: const Text(
                        "Forget your password?",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    ],
                  ),
                ),
                Padding(padding:
                const EdgeInsets.symmetric(horizontal: 40),
                  child: Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {},
                      color: Colors.orange,
                      //const Color(0xff0095FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                      ),
                    ),
                  ),
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupPage()));
                      },
                    child: const Text(
                      " Sign up",
                      style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.orange,
                      ),
                    ),
                    ),
                  ],
                ),

                Container(
                  padding: const EdgeInsets.only(top: 100),
                  height: 200,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/login.png"),
                        fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ],
            ),
            ),
          ],
        ),
      ),
    );
  }
}