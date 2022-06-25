import 'package:flutter/material.dart';
import 'package:mealthy/manage_stats.dart';
import 'package:mealthy/reuse.dart';
import 'package:mealthy/email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class calorieRecord extends StatefulWidget {
  const calorieRecord({Key? key}) : super(key: key);

  @override
  _calorieRecordState createState() => _calorieRecordState();
}

class _calorieRecordState extends State<calorieRecord> {
  var db = FirebaseFirestore.instance;

  ListTile myMeal(BuildContext context, mealIcon, String mealName, String meal,
      String redirectPage) {
    return ListTile(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFFFCC25E), width: 2),
        borderRadius: BorderRadius.circular(5.0),
      ),
      contentPadding: EdgeInsets.only(left: 12.0, right: 6.0),
      leading: Icon(
        mealIcon,
        size: 30.0,
        color: Color(0xFFFCC25E),
      ),
      title: Transform.translate(
        offset: Offset(-12, 0),
        child: Text(mealName + meal + ' cal',
            style: TextStyle(
                color: Color(0xFFFCC25E),
                fontSize: 18.0,
                fontWeight: FontWeight.w600)),
      ),
      trailing: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            size: 30.0,
            color: Color(0xFFFCC25E),
          ),
          onPressed: () {
            Navigator.pushNamed(context, redirectPage).then((_) {
              setState(() {});
            });
            ;
          },
        ),
      ),
    );
  }

  Container totalAndGoal(
      String title, String info, String unit, Color stateColor) {
    return Container(
      height: 60.0,
      width: double.infinity,
      decoration: BoxDecoration(
          color: stateColor,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Align(
        alignment: Alignment.center,
        child: Text(title + info + unit,
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFFFFFFF),
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
                      "Calorie record",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF143A62),
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () async {
                        await db
                            .collection('Users')
                            .where('Email', isEqualTo: Email)
                            .get()
                            .then((value) async {
                          await db
                              .collection("Users")
                              .doc(value.docs[0].id)
                              .collection("Calorie record")
                              .orderBy('Date', descending: true)
                              .get()
                              .then((value) => myDoc = value);
                        });
                        Navigator.pushNamed(context, '/Record_history');
                      },
                      child: Text(
                        'View record history',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Color(0xFFFCC25E),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.all(0.0),
                        primary: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.0),
                  myMeal(context, Icons.breakfast_dining, 'Breakfast: ',
                      breakfast, '/Breakfast'),
                  SizedBox(height: 12.0),
                  myMeal(
                      context, Icons.lunch_dining, 'Lunch: ', lunch, '/Lunch'),
                  SizedBox(height: 12.0),
                  myMeal(context, Icons.dinner_dining, 'Dinner: ', dinner,
                      '/Dinner'),
                  SizedBox(height: 12.0),
                  myMeal(context, Icons.free_breakfast, 'Others: ', others,
                      '/Others'),
                  SizedBox(height: 12.0),
                  Column(
                    children: [
                      totalAndGoal(
                          'Total intake: ',
                          (int.parse(breakfast) +
                                  int.parse(lunch) +
                                  int.parse(dinner) +
                                  int.parse(others))
                              .toString(),
                          " cal",
                          (goal != '' &&
                                  (int.parse(breakfast) +
                                          int.parse(lunch) +
                                          int.parse(dinner) +
                                          int.parse(others)) >
                                      int.parse(goal))
                              ? Color(0xFFDC0C15)
                              : Color(0xFFFCC25E)),
                      SizedBox(height: 12.0),
                      goal != ''
                          ? Column(
                              children: [
                                totalAndGoal('My goal: ', goal, ' cal',
                                    Color(0xFFFCC25E)),
                                SizedBox(height: 12.0),
                                (int.parse(breakfast) +
                                            int.parse(lunch) +
                                            int.parse(dinner) +
                                            int.parse(others)) >
                                        int.parse(goal)
                                    ? RichText(
                                        text: TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Icon(
                                                Icons.report_problem,
                                                size: 22,
                                                color: Color(0xFFDC0C15),
                                              ),
                                            ),
                                            TextSpan(
                                                text:
                                                    " You have already exceed your calorie goal today!",
                                                style: TextStyle(
                                                  color: Color(0xFFDC0C15),
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ],
                                        ),
                                      )
                                    : Text(''),
                              ],
                            )
                          : Container(
                              child: Text(''),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
