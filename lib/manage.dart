import 'package:flutter/material.dart';
import 'package:mealthy/reuse.dart';

class Manage extends StatefulWidget {
  const Manage({Key? key}) : super(key: key);

  @override
  _ManageState createState() => _ManageState();
}

Card myCard(BuildContext context, String pic, String title, String description,
    String buttonText, String redirectPage, double heightPre) {
  return Card(
    elevation: 0,
    margin: EdgeInsets.all(0.0),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        color: Color(0xFFFCC25E),
        width: 2,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(24)),
    ),
    child: Container(
      margin: EdgeInsets.all(28.0),
      height: MediaQuery.of(context).size.height * heightPre,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(pic),
          SizedBox(height: 6.0),
          Text(
            title,
            style: TextStyle(
                color: Color(0xFFFCC25E),
                fontSize: 22,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6.0),
          Text(
            description,
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 14,
            ),
          ),
          UIButton(context, buttonText, () {
            Navigator.pushNamed(context, redirectPage);
          })
        ],
      ),
    ),
  );
}

class _ManageState extends State<Manage> {
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
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Manage",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF143A62),
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                myCard(
                    context,
                    'images/Calorie_record.png',
                    'Calorie record',
                    'Record down your daily calorie intake.',
                    'Record',
                    '/Calorie_record',
                    0.38),
                SizedBox(
                  height: 24.0,
                ),
                myCard(
                    context,
                    'images/Calorie_calculator.png',
                    'Calorie calculator',
                    'The Calorie calculator can be used to estimate the number of calories a person needs to consume each day and provide simple guidelines for gaining or losing weight.',
                    'Try Now',
                    '/Calorie_calculator',
                    0.48),
                SizedBox(
                  height: 24.0,
                ),
                myCard(
                    context,
                    'images/Set_goal.png',
                    'Set goal',
                    'Set your daily calorie intake goal.',
                    'Set Goal',
                    '/Set_goal',
                    0.38),
                SizedBox(
                  height: 24.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
