import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class VerificationPage_sign_up extends StatefulWidget {
  const VerificationPage_sign_up({Key? key}) : super(key: key);
  @override
  _VerificationPage_sign_upState createState() =>
      _VerificationPage_sign_upState();
}

class _VerificationPage_sign_upState extends State<VerificationPage_sign_up> {
  final auth = FirebaseAuth.instance;
  User? user;
  late Timer timer;

  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      timer.cancel();
      Navigator.pushNamed(context, '/Allergens_fromVeri');
    }
  }

  @override
  void initState() {
    user = auth.currentUser;
    user!.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: double.infinity,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Verification",
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
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Please verify your email address",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF4A4A4A),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Your email address must be verified before using MealThy, please check your email to complete the verification process.",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4A4A4A),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(child: Image.asset("images/Signup_bottom.png")),
            ),
          ),
        ]));
  }
}
