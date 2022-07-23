import 'package:flutter/material.dart';
import 'package:mealthy/manage_stats.dart';
import 'package:mealthy/reuse.dart';

class RecordHistroy extends StatefulWidget {
  const RecordHistroy({Key? key}) : super(key: key);

  @override
  _RecordHistroyState createState() => _RecordHistroyState();
}

class _RecordHistroyState extends State<RecordHistroy> {
  Container myMeal(
      BuildContext context, mealIcon, String mealName, String meal) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF4A4A4A), width: 2),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 12.0, right: 6.0),
        leading: Icon(
          mealIcon,
          size: 30.0,
          color: Color(0xFF4A4A4A),
        ),
        title: Transform.translate(
          offset: Offset(-12, 0),
          child: Text(mealName + meal + ' cal',
              style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  /*      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFF4A4A4A), width: 2),
        borderRadius: BorderRadius.circular(5.0),
      ),*/

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
              children: <Widget>[
                backToPrevious(context),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Record history",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF143A62),
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      for (var doc in myDoc.docs)
                        Column(
                          children: [
                            SizedBox(
                              height: 24.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Date: " + doc["Date"],
                                style: TextStyle(
                                  color: Color(0xFF4A4A4A),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                            SizedBox(height: 12.0),
                            myMeal(
                              context,
                              Icons.breakfast_dining,
                              'Breakfast: ',
                              doc["Breakfast"],
                            ),
                            SizedBox(height: 12.0),
                            myMeal(
                              context,
                              Icons.lunch_dining,
                              'Lunch: ',
                              doc["Lunch"],
                            ),
                            SizedBox(height: 12.0),
                            myMeal(
                              context,
                              Icons.dinner_dining,
                              'Dinner: ',
                              doc["Dinner"],
                            ),
                            SizedBox(height: 12.0),
                            myMeal(
                              context,
                              Icons.free_breakfast,
                              'Others: ',
                              doc["Others"],
                            ),
                          ],
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
