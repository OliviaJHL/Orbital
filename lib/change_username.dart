import 'package:flutter/material.dart';
import 'package:mealthy/name.dart';
import 'package:mealthy/reuse.dart';
import 'package:mealthy/email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChangeName extends StatefulWidget {
  const ChangeName({Key? key}) : super(key: key);

  @override
  _ChangeNameState createState() => _ChangeNameState();
}

final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

class _ChangeNameState extends State<ChangeName> {
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
                    "Change username",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF143A62),
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 18.0),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: buildInputDecoration('Name'),
                        validator: (String? value) {
                          if (value == "") {
                            return 'Please key in new username';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          Name = value!;
                        },
                      ),
                      SizedBox(height: 12.0),
                      UIButton(
                        context,
                        'Save',
                        () async {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            db
                                .collection('Users')
                                .where('Email', isEqualTo: Email)
                                .get()
                                .then((value) {
                              db
                                  .collection('Users')
                                  .doc(value.docs[0].id)
                                  .update({"Name": Name});
                            });
                            Navigator.pop(context);
                          }
                        },
                      ),
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
