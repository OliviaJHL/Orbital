import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mealthy/reuse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealthy/email.dart';
import 'package:mealthy/filter_stats.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Store user info
  String Password = "";

  var db = FirebaseFirestore.instance;

  var currentDate = "${DateTime.now().toLocal()}".split(' ')[0];

  //Use key to check if all are validified
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    /*AlertDialog dialog = AlertDialog(
      content: Text(
        "Expired food found in your pantry.",
        style: TextStyle(
            color: Color(0xFF4A4A4A),
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Close',
            style: TextStyle(
              color: Color(0xFFFCC25E),
              fontSize: 18,
            ),
          ),
        )
      ],
    );*/
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
                            /*myInitial(FirebaseAuth.instance.currentUser!.email,
                                context, '/Navigation');*/
                            /*//Get current calorie intake
                            db
                                .collection('Users')
                                .where('Email', isEqualTo: Email)
                                .get()
                                .then((value) {
                              db
                                  .collection('Users')
                                  .doc(value.docs[0].id)
                                  .collection('Calorie record')
                                  .where('Date', isEqualTo: currentDate)
                                  .get()
                                  .then(
                                (ref) {
                                  if (ref.docs.isNotEmpty) {
                                    db
                                        .collection('Users')
                                        .doc(value.docs[0].id)
                                        .collection('Calorie record')
                                        .doc(ref.docs[0].id)
                                        .get()
                                        .then(
                                      (value) {
                                        breakfast = value['Breakfast'];
                                        lunch = value['Lunch'];
                                        dinner = value['Dinner'];
                                        others = value['Others'];
                                      },
                                    );
                                  }
                                },
                              );
                            });
                            //Get name
                            db
                                .collection('Users')
                                .where('Email', isEqualTo: Email)
                                .get()
                                .then((value) {
                              db
                                  .collection('Users')
                                  .doc(value.docs[0].id)
                                  .get()
                                  .then((value) {
                                Name = value['Name'];
                              });
                            });
                            //Get goal
                            db
                                .collection('Users')
                                .where('Email', isEqualTo: Email)
                                .get()
                                .then((value) {
                              db
                                  .collection('Users')
                                  .doc(value.docs[0].id)
                                  .get()
                                  .then((value) {
                                goal = value['Set goal'];
                              });
                            });
                            //Check expiration
                            db
                                .collection('Users')
                                .where('Email', isEqualTo: Email)
                                .get()
                                .then((value) {
                              db
                                  .collection('Users')
                                  .doc(value.docs[0].id)
                                  .collection('Pantry')
                                  .get()
                                  .then((ref) {
                                for (var doc in ref.docs) {
                                  if (DateTime.parse(doc['ExpDate']).isBefore(
                                      DateTime.parse(
                                          "${DateTime.now().toLocal()}"
                                              .split(' ')[0]))) {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            dialog);
                                    break;
                                  }
                                }
                              });
                            });*/
                            choosenCuisine = [];
                            cuisineCheck = [
                              false,
                              false,
                              false,
                              false,
                              false,
                              false,
                              false,
                              false,
                              false,
                              false,
                              false,
                              false,
                              false,
                              false,
                              false,
                            ];
                            Navigator.pushNamed(
                                context,
                                myInitial(
                                    FirebaseAuth.instance.currentUser!.email,
                                    context,
                                    '/Navigation'));
                            /*db
                                .collection('Users')
                                .where('Email', isEqualTo: Email)
                                .get()
                                .then((value) {
                              db
                                  .collection('Users')
                                  .doc(value.docs[0].id)
                                  .get()
                                  .then((value) {
                                likedRecipe = [];
                                likedRecipe.addAll(value['likedRecipe']);
                                print(likedRecipe);
                                Navigator.pushNamed(
                                    context,
                                    myInitial(
                                        FirebaseAuth
                                            .instance.currentUser!.email,
                                        context,
                                        '/Navigation'));
                              });
                            });*/

                          } else {
                            Navigator.pushNamed(
                                context, '/Verification_sign_up');
                          }
                          ;
                        } on FirebaseAuthException catch (e) {
                          print(e);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 2),
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
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(child: Image.asset("images/Login_bottom.png")),
            ),
          ),
        ],
      ),
    );
  }
}
