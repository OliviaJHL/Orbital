import 'package:flutter/material.dart';
import 'package:mealthy/reuse.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealthy/email.dart';
import 'package:mealthy/recipe_nutrition_state.dart';

class allergensPage extends StatefulWidget {
  final String page;
  const allergensPage({Key? key, required this.page}) : super(key: key);

  @override
  State<allergensPage> createState() => _allergensPageState();
}

class _allergensPageState extends State<allergensPage> {
  var db = FirebaseFirestore.instance;

  var allergen = <String, dynamic>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
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
                  child: widget.page == '/Verification_sign_up'
                      ? null
                      : Column(
                          children: [
                            backToPrevious(context),
                            SizedBox(
                              height: 12.0,
                            )
                          ],
                        ),
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "I am allergic to",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF143A62),
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  height: 36.0,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      for (int index = 0; index < myTitle.length; index++)
                        Column(
                          children: <Widget>[
                            Theme(
                              data: ThemeData(
                                unselectedWidgetColor: Color(0xFF143A62),
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                              ),
                              child: CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                title: Text(
                                  myTitle[index],
                                  style: TextStyle(
                                    color: Color(0xFF4A4A4A),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                secondary: Image.asset(
                                  myImage[index],
                                ),
                                activeColor: Color(0xFF143A62),
                                checkColor: Colors.white,
                                autofocus: false,
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                selected: myCheckAllergens[index],
                                value: myCheckAllergens[index],
                                onChanged: (bool? value) {
                                  setState(() {
                                    myCheckAllergens[index] = value!;
                                  });
                                },
                              ),
                            ),
                            index < myTitle.length - 1
                                ? Divider(
                                    height: 64,
                                    thickness: 1,
                                    color: Color(0xFFC4C4C4),
                                  )
                                : SizedBox(
                                    height: 24,
                                  )
                          ],
                        ),
                    ],
                  ),
                ),
                UIButton(context, 'Save', () {
                  allergen["Eggs"] = myCheckAllergens[0];
                  allergen["Fish"] = myCheckAllergens[1];
                  allergen["Milk"] = myCheckAllergens[2];
                  allergen["Peanuts"] = myCheckAllergens[3];
                  allergen["Shellfish"] = myCheckAllergens[4];
                  allergen["Soya beans"] = myCheckAllergens[5];
                  allergen["Tree nuts"] = myCheckAllergens[6];
                  allergen["Wheat"] = myCheckAllergens[7];
                  db
                      .collection('Users')
                      .where('Email', isEqualTo: Email)
                      .get()
                      .then((value) {
                    db
                        .collection('Users')
                        .doc(value.docs[0].id)
                        .update({'Allergens': allergen});
                  });
                  if (widget.page == '/Verification_sign_up') {
                    Navigator.pushNamed(context, '/Navigation');
                  } else {
                    Navigator.pop(context);
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
