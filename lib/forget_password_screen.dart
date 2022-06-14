import 'package:flutter/material.dart';
import 'package:mealthy/reuse.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetpasswordPage extends StatefulWidget {
  const ForgetpasswordPage({Key? key}) : super(key: key);
  @override
  _ForgetpasswordPageState createState() => _ForgetpasswordPageState();
}

class _ForgetpasswordPageState extends State<ForgetpasswordPage> {
  String Email = "";

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: <Widget>[
                      backToPrevious(context),
                      SizedBox(
                        height: 12.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          "Forgot Password",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF143A62),
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/Forgot_password.png"),
                              fit: BoxFit.fitHeight),
                        ),
                      ),
                      SizedBox(
                        height: 48.0,
                      ),
                      Form(
                        key: _formkey,
                        child: Padding(
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
                      ),
                      UIButton(context, 'Confirm', () async {
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: Email)
                                .then((value) {
                              AlertDialog dialog = AlertDialog(
                                content: Text(
                                  "Password reset email sent.",
                                  style: TextStyle(
                                      color: Color(0xFF4A4A4A),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/Login');
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyle(
                                        color: Color(0xFFFCC25E),
                                        fontSize: 18,
                                      ),
                                    ),
                                  )
                                ],
                              );
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => dialog);
                            });
                            ;
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Error occur, please ensure your email is correct'),
                            ));
                          }
                        }
                      })
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
