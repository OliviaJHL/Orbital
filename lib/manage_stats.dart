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
