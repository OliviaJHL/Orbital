import 'package:flutter/material.dart';
import 'package:mealthy/reuse.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Store user info
  String Email = "";
  String Password = "";

  //Use key to check if all are validified
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: double.infinity,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //Title
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Login",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF143A62),
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    //Instruction
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Please sign in to continue",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF4A4A4A),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 36.0,
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: <Widget>[
                          //Email
                          Padding(
                            padding: EdgeInsets.only(bottom: 6.0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              decoration: buildInputDecoration('Email'),
                              validator: (String? value) {
                                if (value == "") {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(
                                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                    .hasMatch(value!)) {
                                  return 'Please enter valid email';
                                }
                                return null;
                              },
                              onSaved: (String? value) {
                                Email = value!;
                              },
                            ),
                          ),
                          //Password
                          Padding(
                            padding: EdgeInsets.only(top: 6.0),
                            child: TextFormField(
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              decoration: buildInputDecoration('Password'),
                              validator: (String? value) {
                                if (value == "") {
                                  return 'Please enter your password';
                                }
                                if (value != null && value.length < 6) {
                                  return 'Password is less than 6 characters long';
                                }
                                if (value != null && value.length > 18) {
                                  return 'Password is more than 18 characters long';
                                }
                                return null;
                              },
                              onSaved: (String? value) {
                                Password = value!;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 12.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/ForgotPassword');
                              },
                              child: Container(
                                width: double.infinity,
                                child: const Text(
                                  "Forget your password?",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xDD4A4A4A),
                                    fontSize: 14.0,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    UIButton(context, 'Sign in', () async {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: Email, password: Password);
                          final auth = FirebaseAuth.instance;
                          User? user = auth.currentUser;
                          if (user!.emailVerified) {
                            Navigator.pushNamed(context, '/HomePage');
                          } else {
                            Navigator.pushNamed(
                                context, '/Verification_sign_up');
                          }
                          ;
                        } on FirebaseAuthException catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'Incorrect email or password, please try again'),
                          ));
                        }
                      }
                      ;
                    }),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.ideographic,
                        children: <Widget>[
                          Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF4A4A4A),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/SignUp');
                            },
                            child: Text(
                              " Sign up",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                                color: Color(0xFFFCC25E),
                              ),
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/Login_bottom.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
