import 'package:cloud_firestore/cloud_firestore.dart';

//Save variables that can be accessed across different pages under pantry
String foodName = '';
String quantity = '';
String unit = '';
String category = '';
String ID = '';

DateTime selectedDate = DateTime.now();

var database = FirebaseFirestore.instance;

bool myCheck = false;
