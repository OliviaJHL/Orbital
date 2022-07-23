import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

//Save variables that can be accessed across different pages under manage
//For calorie calculator
String age = '';
String gender = '';
String height = '';
String weight = '';
String activity = '';

//For set goal
String goal = '';

//For calculator
String breakfast = '0';
String lunch = '0';
String dinner = '0';
String others = '0';

//For record history
var myDoc = null;

//Serving size

//Check if is the first time entry
/*Future<bool> isFirstEnter() async {
  final prefs = SharedPreferences.getInstance();
  var temp = await prefs;
  timeBase =
      temp.getString('items') ?? "${DateTime.now().toLocal()}".split(' ')[0];
  print(timeBase);
  if ("${DateTime.now().toLocal()}".split(' ')[0] != timeBase) {
    timeBase = "${DateTime.now().toLocal()}".split(' ')[0];
    temp.setString('items', timeBase);
    return true;
  } else {
    return false;
  }
}*/
Future<bool> isFirstEnter() async {
  SharedPreferences temp = await SharedPreferences.getInstance();
  String timeBase = temp.getString('items') ?? '';
  String today = "${DateTime.now().toLocal()}".split(' ')[0];
  //add(const Duration(days: 1))
  print(timeBase);
  if (today != timeBase) {
    timeBase = today;
    print(timeBase);
    temp.setString('items', timeBase);
    return true;
  } else {
    return false;
  }
}
