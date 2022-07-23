import 'package:flutter/material.dart';
import 'package:mealthy/reuse.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealthy/recipe_nutrition_state.dart';
import 'package:mealthy/email.dart';
import 'package:mealthy/manage_stats.dart';

class Recipes extends StatefulWidget {
  const Recipes({Key? key}) : super(key: key);

  @override
  _RecipesState createState() => _RecipesState();
}

RichText info(Icon icons, String text) {
  return RichText(
    text: TextSpan(children: [
      WidgetSpan(alignment: PlaceholderAlignment.middle, child: icons),
      WidgetSpan(
          child: SizedBox(
        width: 6.0,
      )),
      TextSpan(
        text: text,
        style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4A4A4A)),
      ),
    ]),
  );
}

bool ifAllergen(recipeAllergen, userAllergen) {
  for (int index = 0; index < recipeAllergen.length; index++) {
    print(recipeAllergen[index]);
    if (myTitle.indexOf(recipeAllergen[index]) != -1 &&
        userAllergen[myTitle.indexOf(recipeAllergen[index])]) {
      return true;
    }
  }
  return false;
}

class _RecipesState extends State<Recipes> {
  final List<String> allMeals = ['Breakfast', 'Lunch', 'Dinner', 'Others'];
  String? selectedMeal;

  var db = FirebaseFirestore.instance;

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
              children: [
                backToPrevious(context),
                SizedBox(
                  height: 12.0,
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                        future: recipeName(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            print(snapshot.data);
                            var currentDocs = snapshot.data;
                            currentRecipeCal = currentDocs['Calorie'];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32.0, right: 32.0),
                                  child: /*Image.network(
                                    currentDocs['Image'],*/
                                      showNetworkImg(
                                          currentDocs['Image'],
                                          onWait: Image.asset(
                                              'images/image_loader.gif'),
                                          1.0,
                                          onError: const Icon(
                                            Icons.not_interested,
                                            color: Colors.grey,
                                            size: 80.0,
                                          )),
                                ),
                                SizedBox(height: 24.0),
                                Text(currentDocs['Name'],
                                    style: TextStyle(
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4A4A4A))),
                                SizedBox(height: 12.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    info(
                                        Icon(Icons.timer_outlined,
                                            color: Color(0xFFFCC25E)),
                                        currentDocs['Duration']),
                                    info(
                                        Icon(Icons.person_outline,
                                            color: Color(0xFFFCC25E)),
                                        currentDocs['Serving']),
                                    info(
                                        Icon(Icons.rice_bowl_outlined,
                                            color: Color(0xFFFCC25E)),
                                        currentDocs['Calorie'] + ' cal'),
                                  ],
                                ),
                                SizedBox(height: 12.0),
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    currentDocs['Briefing'],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(0xFF4A4A4A)),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: ifAllergen(currentDocs['Allergens'],
                                          myCheckAllergens)
                                      ? Column(
                                          children: [
                                            SizedBox(height: 12.0),
                                            RichText(
                                              text: TextSpan(
                                                children: [
                                                  WidgetSpan(
                                                    child: Icon(
                                                      Icons.report_problem,
                                                      size: 20,
                                                      color: Color(0xFFDC0C15),
                                                    ),
                                                  ),
                                                  TextSpan(
                                                      text:
                                                          " This recipe contains your allergens.",
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFDC0C15),
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : null,
                                ),
                                Divider(
                                  height: 24,
                                  thickness: 1,
                                  color: Color(0xFFC4C4C4),
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    'Ingredients',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF4A4A4A)),
                                  ),
                                ),
                                SizedBox(
                                  height: 6.0,
                                ),
                                //Check if firestore can wrtie in few line format
                                //else should have for loop to went through the ingredients
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    currentDocs['Ingredients']
                                        .toString()
                                        .replaceAll('\\n', '\n'),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(height: 1.6),
                                  ),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    'Preperation',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF4A4A4A)),
                                  ),
                                ),
                                SizedBox(
                                  height: 6.0,
                                ),
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      currentDocs['Preparation']
                                          .toString()
                                          .replaceAll('\\n', '\n'),
                                    )),
                                SizedBox(height: 12.0),
                                DecoratedBox(
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2.0,
                                          style: BorderStyle.solid,
                                          color: Color(0xFFFCC25E)),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  child: DropdownButtonFormField2(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    isExpanded: true,
                                    hint: Text(
                                      '+ Add to my meal',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFFFCC25E)),
                                    ),
                                    value: selectedMeal,
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: Color(0xFFFCC25E),
                                    ),
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    onChanged: (String? value) {
                                      selectedMeal = value ?? "";
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        duration: const Duration(seconds: 2),
                                        content: Text('Added the recipe' +
                                            "'" +
                                            's calorie to your daily calorie intake.'),
                                      ));
                                      if (value == 'Breakfast') {
                                        breakfast = (int.parse(breakfast) +
                                                int.parse(currentRecipeCal))
                                            .toString();
                                        db
                                            .collection('Users')
                                            .where('Email', isEqualTo: Email)
                                            .get()
                                            .then((value) {
                                          db
                                              .collection('Users')
                                              .doc(value.docs[0].id)
                                              .collection('Calorie record')
                                              .where('Date',
                                                  isEqualTo: currentDate)
                                              .get()
                                              .then(
                                            (ref) {
                                              if (ref.docs.isEmpty) {
                                                db
                                                    .collection('Users')
                                                    .doc(value.docs[0].id)
                                                    .collection(
                                                        'Calorie record')
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
                                                    .collection(
                                                        'Calorie record')
                                                    .doc(ref.docs[0].id)
                                                    .update({
                                                  'Breakfast': breakfast,
                                                });
                                              }
                                            },
                                          );
                                        });
                                      }
                                      if (value == 'Lunch') {
                                        lunch = (int.parse(lunch) +
                                                int.parse(currentRecipeCal))
                                            .toString();
                                        db
                                            .collection('Users')
                                            .where('Email', isEqualTo: Email)
                                            .get()
                                            .then((value) {
                                          db
                                              .collection('Users')
                                              .doc(value.docs[0].id)
                                              .collection('Calorie record')
                                              .where('Date',
                                                  isEqualTo: currentDate)
                                              .get()
                                              .then(
                                            (ref) {
                                              if (ref.docs.isEmpty) {
                                                db
                                                    .collection('Users')
                                                    .doc(value.docs[0].id)
                                                    .collection(
                                                        'Calorie record')
                                                    .doc()
                                                    .set({
                                                  'Breakfast': '0',
                                                  'Lunch': lunch,
                                                  'Dinner': '0',
                                                  'Others': '0',
                                                  'Date': currentDate
                                                });
                                              } else {
                                                db
                                                    .collection('Users')
                                                    .doc(value.docs[0].id)
                                                    .collection(
                                                        'Calorie record')
                                                    .doc(ref.docs[0].id)
                                                    .update({
                                                  'Lunch': lunch,
                                                });
                                              }
                                            },
                                          );
                                        });
                                      }
                                      if (value == 'Dinner') {
                                        dinner = (int.parse(dinner) +
                                                int.parse(currentRecipeCal))
                                            .toString();
                                        db
                                            .collection('Users')
                                            .where('Email', isEqualTo: Email)
                                            .get()
                                            .then((value) {
                                          db
                                              .collection('Users')
                                              .doc(value.docs[0].id)
                                              .collection('Calorie record')
                                              .where('Date',
                                                  isEqualTo: currentDate)
                                              .get()
                                              .then(
                                            (ref) {
                                              if (ref.docs.isEmpty) {
                                                db
                                                    .collection('Users')
                                                    .doc(value.docs[0].id)
                                                    .collection(
                                                        'Calorie record')
                                                    .doc()
                                                    .set({
                                                  'Breakfast': '0',
                                                  'Lunch': '0',
                                                  'Dinner': dinner,
                                                  'Others': '0',
                                                  'Date': currentDate
                                                });
                                              } else {
                                                db
                                                    .collection('Users')
                                                    .doc(value.docs[0].id)
                                                    .collection(
                                                        'Calorie record')
                                                    .doc(ref.docs[0].id)
                                                    .update({
                                                  'Dinner': dinner,
                                                });
                                              }
                                            },
                                          );
                                        });
                                      }
                                      if (value == 'Others') {
                                        others = (int.parse(others) +
                                                int.parse(currentRecipeCal))
                                            .toString();
                                        db
                                            .collection('Users')
                                            .where('Email', isEqualTo: Email)
                                            .get()
                                            .then((value) {
                                          db
                                              .collection('Users')
                                              .doc(value.docs[0].id)
                                              .collection('Calorie record')
                                              .where('Date',
                                                  isEqualTo: currentDate)
                                              .get()
                                              .then(
                                            (ref) {
                                              if (ref.docs.isEmpty) {
                                                db
                                                    .collection('Users')
                                                    .doc(value.docs[0].id)
                                                    .collection(
                                                        'Calorie record')
                                                    .doc()
                                                    .set({
                                                  'Breakfast': '0',
                                                  'Lunch': '0',
                                                  'Dinner': '0',
                                                  'Others': others,
                                                  'Date': currentDate
                                                });
                                              } else {
                                                db
                                                    .collection('Users')
                                                    .doc(value.docs[0].id)
                                                    .collection(
                                                        'Calorie record')
                                                    .doc(ref.docs[0].id)
                                                    .update({
                                                  'Others': others,
                                                });
                                              }
                                            },
                                          );
                                        });
                                      }
                                    },
                                    items: allMeals.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFFFCC25E)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Text('');
                          }
                        },
                      ),
                      SizedBox(height: 24.0),
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
