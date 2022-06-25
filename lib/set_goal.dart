import 'package:flutter/material.dart';
import 'package:mealthy/reuse.dart';
import 'package:flutter/services.dart';
import 'package:mealthy/manage_stats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealthy/email.dart';

class setGoal extends StatefulWidget {
  const setGoal({Key? key}) : super(key: key);

  @override
  _setGoalState createState() => _setGoalState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

class _setGoalState extends State<setGoal> {
  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                backToPrevious(context),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Set goal",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF143A62),
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: goal != ""
                      ? Column(
                          children: [
                            SizedBox(height: 12.0),
                            Container(
                              width: double.infinity,
                              child: Text(
                                "Current goal: " + goal + ' cal',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xFFFCC25E),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 18.0)
                          ],
                        )
                      : Container(
                          child: Text(''),
                        ),
                ),
                Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration:
                              buildInputDecoration('Calorie goal (in cal)'),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          validator: (String? value) {
                            if (value == "") {
                              return 'Please key in your goal';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            goal = value!;
                          },
                        ),
                        SizedBox(height: 12.0),
                        UIButton(context, 'Save', () async {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            Navigator.pop(context);
                          }
                          db
                              .collection('Users')
                              .where('Email', isEqualTo: Email)
                              .get()
                              .then((value) {
                            db
                                .collection('Users')
                                .doc(value.docs[0].id)
                                .update({
                              'Set goal': goal,
                            });
                          });
                        }),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
