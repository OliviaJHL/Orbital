import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mealthy/manage_stats.dart';
import 'package:mealthy/recipe_nutrition_state.dart';
import 'package:mealthy/reuse.dart';
import 'package:mealthy/email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealthy/name.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String Password = "";

  //Use key to check if all are validified
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var db = FirebaseFirestore.instance;

  var currentDate = "${DateTime.now().toLocal()}".split(' ')[0];

  var user = <String, dynamic>{
    "Email": "",
    "Name": "",
    "Set goal": "",
    "likedRecipe": ["Null"],
  };

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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //reusable function
                        backToPrevious(context),
                        SizedBox(
                          height: 12.0,
                        ),
                        //Title
                        Container(
                          width: double.infinity,
                          child: Text(
                            "Create Account",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color(0xFF143A62),
                              fontSize: 36,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
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
                                    Email = value!.toLowerCase();
                                  },
                                ),
                              ),
                              //Password
                              Padding(
                                padding: EdgeInsets.only(top: 6.0, bottom: 6.0),
                                child: TextFormField(
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  decoration: buildInputDecoration('Password'),
                                  validator: (String? value) {
                                    if (value == "") {
                                      return 'Please enter a password';
                                    }
                                    if (value != null && value.length < 6) {
                                      return 'Password must be at least 6 characters long';
                                    }
                                    if (value != null && value.length > 18) {
                                      return 'Password must be less than 18 characters long';
                                    }
                                    return null;
                                  },
                                  onSaved: (String? value) {
                                    Password = value!;
                                  },
                                ),
                              ),
                              //Username
                              Padding(
                                padding: EdgeInsets.only(top: 6.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration: buildInputDecoration('Username'),
                                  validator: (String? value) {
                                    if (value == "") {
                                      return 'Please enter your username';
                                    }
                                    if (value != null && value.length > 18) {
                                      return 'username must be less than 18 characters long';
                                    }
                                    return null;
                                  },
                                  onSaved: (String? value) {
                                    Name = value!;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              UIButton(context, 'Next', () async {
                                if (_formkey.currentState!.validate()) {
                                  _formkey.currentState!.save();
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: Email.toLowerCase(),
                                            password: Password)
                                        .then((value) {
                                      user.update(
                                          'Email',
                                          (value) =>
                                              Email.toLowerCase().trim());
                                      user.update('Name', (value) => Name);
                                      user.update('Set goal', (value) => '');
                                      user.update(
                                          'likedRecipe', (value) => ["Null"]);
                                      db.collection("Users").add(user);
                                      myCheckAllergens = [
                                        false,
                                        false,
                                        false,
                                        false,
                                        false,
                                        false,
                                        false,
                                        false,
                                      ];
                                      likedRecipe = [];
                                      breakfast = '0';
                                      lunch = '0';
                                      dinner = '0';
                                      others = '0';
                                      Navigator.pushNamed(
                                          context, '/Verification_sign_up');
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      duration: const Duration(seconds: 2),
                                      content: Text(
                                          'Repeated email, please try using another email.'),
                                    ));
                                  }
                                }
                                ;
                              }),
                            ],
                          ),
                        ),
                      ],
                    ))),
          ),
        ],
      ),
    );
  }
}
