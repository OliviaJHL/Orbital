import 'package:flutter/material.dart';
import 'package:mealthy/reuse.dart';
import 'package:mealthy/manage_stats.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

Container displayDesign(String type, int calculate) {
  return Container(
    width: double.infinity,
    height: 100.0,
    color: Color(0xFFFCC25E),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          type,
          style: TextStyle(
            fontSize: 18.0,
            color: Color(0xFF143A62),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: <Widget>[
            Text(
              calculate.toString(),
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              ' Calories/per day',
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFF143A62),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Container displayResult(a, g, h, w, ac) {
  var ageInt = int.parse(a!);
  // ignore: unnecessary_type_check
  assert(ageInt is int);
  var heightDouble = double.parse(h!);
  // ignore: unnecessary_type_check
  assert(heightDouble is double);
  var weightDouble = double.parse(w!);
  // ignore: unnecessary_type_check
  assert(weightDouble is double);

  if (ac == 'Basal Metabolic Rate (BMR)') {
    if (g == 'Male') {
      double maleBMR = 10 * weightDouble + 6.25 * heightDouble - 5 * ageInt + 5;
      return displayDesign('Basal Metabolic Rate (BMR):', maleBMR.round());
    }
    if (g == 'Female') {
      double femaleBMR =
          10 * weightDouble + 6.25 * heightDouble - 5 * ageInt - 161;
      return displayDesign('Basal Metabolic Rate (BMR):', femaleBMR.round());
    }
  }
  return Container(
    child: Text('Error, please try again.'),
  );
}

class _ResultState extends State<Result> {
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
                    "Result",
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
                    "The results show a number of daily calorie estimates that can be used as a guideline for how many calories to consume each day to maintain, lose, or gain weight at a chosen rate.",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                displayResult(age, gender, height, weight, activity),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
