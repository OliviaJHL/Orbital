import 'package:flutter/material.dart';
import 'package:mealthy/manage_stats.dart';
import 'package:mealthy/reuse.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealthy/email.dart';

class Breakfast extends StatefulWidget {
  const Breakfast({Key? key}) : super(key: key);

  @override
  _BreakfastState createState() => _BreakfastState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

class _BreakfastState extends State<Breakfast> {
  var db = FirebaseFirestore.instance;

  var currentDate = "${DateTime.now().toLocal()}".split(' ')[0];

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
              children: [
                backToPrevious(context),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Breakfast",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF143A62),
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Current intake: " + breakfast + ' cal',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFFFCC25E),
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 18.0),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:
                            buildInputDecoration('Calorie intake (in cal)'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        validator: (String? value) {
                          if (value == "") {
                            return 'Please key in your calorie intake';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          breakfast = value!;
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
                              .collection('Calorie record')
                              .where('Date', isEqualTo: currentDate)
                              .get()
                              .then(
                            (ref) {
                              if (ref.docs.isEmpty) {
                                db
                                    .collection('Users')
                                    .doc(value.docs[0].id)
                                    .collection('Calorie record')
                                    .doc()
                                    .set({
                                  'Breakfast': breakfast,
                                  'Lunch': '0',
                                  'Dinner': '0',
                                  'Others': '0',
                                  'Date': currentDate
                                });
                              } else {
                                db
                                    .collection('Users')
                                    .doc(value.docs[0].id)
                                    .collection('Calorie record')
                                    .doc(ref.docs[0].id)
                                    .update({
                                  'Breakfast': breakfast,
                                });
                              }
                            },
                          );
                        });
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
