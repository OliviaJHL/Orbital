import 'package:flutter/material.dart';
import 'package:mealthy/manage_stats.dart';
import 'package:mealthy/recipe_nutrition_state.dart';
import 'package:mealthy/reuse.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealthy/email.dart';

class NutritionDetail extends StatefulWidget {
  const NutritionDetail({Key? key}) : super(key: key);

  @override
  _NutritionDetailState createState() => _NutritionDetailState();
}

Container nutriInfo(String info, String unit) {
  return Container(
    height: 70,
    width: 70,
    decoration: BoxDecoration(
        color: Color(0xFFFCC25E),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          info,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Text(
          unit,
          style: TextStyle(fontSize: 14.0, color: Colors.white, height: 1.4),
        ),
      ],
    ),
  );
}

class _NutritionDetailState extends State<NutritionDetail> {
  final List<String> allSizes = ['100', '200', '500', '1000'];
  String selectedSize = '100';

  final List<String> allMeals = ['Breakfast', 'Lunch', 'Dinner', 'Others'];
  String? selectedMeal;

  var db = FirebaseFirestore.instance;

  final ValueNotifier<int> _updateInfoValue = ValueNotifier(100);

  @override
  Widget build(BuildContext context) {
    var nutri_currentDate = "${DateTime.now().toLocal()}".split(' ')[0];

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
                          future: nutritionName(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              print(snapshot.data);
                              var currentDocs = snapshot.data;
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 32.0, right: 32.0),
                                    child: showNetworkImg(
                                      currentDocs['Image'],
                                      onWait: Image.asset(
                                          'images/image_loader.gif'),
                                      0.6,
                                      onError: const Icon(
                                        Icons.not_interested,
                                        color: Colors.grey,
                                        size: 80.0,
                                      ),
                                    ),
                                  ),
                                  Text(currentDocs['Name'],
                                      style: TextStyle(
                                          fontSize: 28.0,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF4A4A4A))),
                                  SizedBox(height: 24.0),
                                  ValueListenableBuilder<int>(
                                    valueListenable: _updateInfoValue,
                                    builder: (BuildContext context, int value,
                                        Widget? child) {
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          nutriInfo(
                                              (double.parse(currentDocs[
                                                          'Calorie']) *
                                                      value /
                                                      100)
                                                  .round()
                                                  .toString(),
                                              'Cal'),
                                          nutriInfo(
                                              (double.parse(currentDocs[
                                                              'Protein']) *
                                                          value /
                                                          100)
                                                      .round()
                                                      .toString() +
                                                  ' g',
                                              'Protein'),
                                          nutriInfo(
                                              (double.parse(currentDocs[
                                                              'Sugar']) *
                                                          value /
                                                          100)
                                                      .round()
                                                      .toString() +
                                                  ' g',
                                              'Sugar'),
                                          nutriInfo(
                                              (double.parse(currentDocs[
                                                              'Fat']) *
                                                          value /
                                                          100)
                                                      .round()
                                                      .toString() +
                                                  ' g',
                                              'Fat'),
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 24.0,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      'Serving',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF4A4A4A)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  DecoratedBox(
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 2.0,
                                            style: BorderStyle.solid,
                                            color: Color(0xFFFCC25E)),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                    child: DropdownButtonFormField2(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      isExpanded: true,
                                      value: selectedSize,
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: Color(0xFFFCC25E),
                                      ),
                                      dropdownDecoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      onChanged: (String? newValue) {
                                        selectedSize = newValue!;
                                        _updateInfoValue.value =
                                            int.parse(newValue);
                                        //setState(() {});
                                        //_updateInfoValue.value = true;
                                      },
                                      items: allSizes.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(
                                            items + ' g',
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFFFCC25E)),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24.0,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      'Nutrition fact',
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
                                  Container(
                                    width: double.infinity,
                                    child: Text(
                                      currentDocs['Fact'],
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  DecoratedBox(
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 2.0,
                                            style: BorderStyle.solid,
                                            color: Color(0xFFFCC25E)),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      onChanged: (String? value) {
                                        selectedMeal = value ?? "";
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          duration: const Duration(seconds: 2),
                                          content: Text('Added the ingredient' +
                                              "'" +
                                              's calorie to your daily calorie intake.'),
                                        ));
                                        currentNutritionCal =
                                            (int.parse(currentDocs['Calorie']) *
                                                    int.parse(selectedSize) /
                                                    100)
                                                .round()
                                                .toString();
                                        if (value == 'Breakfast') {
                                          breakfast = (int.parse(breakfast) +
                                                  int.parse(
                                                      currentNutritionCal))
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
                                                    isEqualTo:
                                                        nutri_currentDate)
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
                                                    'Date': nutri_currentDate
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
                                                  int.parse(
                                                      currentNutritionCal))
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
                                                    isEqualTo:
                                                        nutri_currentDate)
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
                                                    'Date': nutri_currentDate
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
                                                  int.parse(
                                                      currentNutritionCal))
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
                                                    isEqualTo:
                                                        nutri_currentDate)
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
                                                    'Date': nutri_currentDate
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
                                                  int.parse(
                                                      currentNutritionCal))
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
                                                    isEqualTo:
                                                        nutri_currentDate)
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
                                                    'Date': nutri_currentDate
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
                          }),
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
