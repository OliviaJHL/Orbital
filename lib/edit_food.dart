import 'package:flutter/material.dart';
import 'package:mealthy/reuse.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mealthy/pantry_stats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealthy/email.dart';

class editFood extends StatefulWidget {
  const editFood({Key? key}) : super(key: key);

  @override
  _editFoodState createState() => _editFoodState();
}

class _editFoodState extends State<editFood> {
  final List<String> allUnits = ['kg', 'pc', 'ml', 'others'];
  String selectedUnit = unit;

  final List<String> allCategories = [
    'Dairy',
    'Fruits',
    'Grains',
    'Proteins',
    'Vegetables',
  ];

  String selectedCategory = category;

  var db = FirebaseFirestore.instance;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _decideWhichDayToEnable(DateTime day) {
    if (day.isAfter(DateTime.now().subtract(Duration(days: 1)))) {
      return true;
    }
    return false;
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      selectableDayPredicate: _decideWhichDayToEnable,
      confirmText: 'Confirm',
      cancelText: 'Cancel',
      helpText: '',
      fieldLabelText: 'Enter date',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            colorScheme: ColorScheme.light(
              primary: Color(0xFFFCC25E),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Color(0xFFFCC25E),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

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
                    "Edit food",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF143A62),
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 18.0),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: foodName,
                        decoration: buildInputDecoration(''),
                        validator: (String? value) {
                          if (value == "") {
                            return 'Please key in the food name';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          foodName = value!;
                        },
                      ),
                      SizedBox(height: 12.0),
                      TextFormField(
                        initialValue: quantity,
                        decoration: buildInputDecoration(''),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        validator: (String? value) {
                          if (value == "") {
                            return 'Please key in the quantity';
                          }
                          var weightDouble = double.parse(value!);
                          // ignore: unnecessary_type_check
                          assert(weightDouble is double);
                          if (weightDouble <= 0) {
                            return 'Quantity must be larger then 0';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          quantity = value!;
                        },
                      ),
                      SizedBox(height: 12.0),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        isExpanded: true,
                        value: selectedUnit,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                        ),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedUnit = newValue!;
                          });
                        },
                        items: allUnits.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onSaved: (String? value) {
                          unit = value!;
                        },
                      ),
                      SizedBox(height: 12.0),
                      DropdownButtonFormField2(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        isExpanded: true,
                        value: selectedCategory,
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                        ),
                        dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCategory = newValue!;
                          });
                        },
                        items: allCategories.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onSaved: (String? value) {
                          category = value!;
                        },
                      ),
                      SizedBox(height: 12.0),
                      ListTile(
                        contentPadding: EdgeInsets.all(0.0),
                        title: Text(
                          'Expired date: ' +
                              "${selectedDate.toLocal()}".split(' ')[0],
                          style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF4A4A4A),
                              fontWeight: FontWeight.w600),
                        ),
                        trailing: Theme(
                          data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.calendar_month,
                              size: 24.0,
                              color: Color(0xFF4A4A4A),
                            ),
                            onPressed: () => _selectDate(context),
                          ),
                        ),
                      ),
                      UIButton(
                        context,
                        'Save',
                        () async {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            await db
                                .collection('Users')
                                .where('Email', isEqualTo: Email)
                                .get()
                                .then((value) async {
                              await db
                                  .collection('Users')
                                  .doc(value.docs[0].id)
                                  .collection('Pantry')
                                  .where('ID', isEqualTo: ID)
                                  .get()
                                  .then((ref) async {
                                await db
                                    .collection('Users')
                                    .doc(value.docs[0].id)
                                    .collection('Pantry')
                                    .doc(ref.docs[0].id)
                                    .update({
                                  'Name': foodName,
                                  'Quantity': quantity,
                                  'Unit': unit,
                                  'Category': category,
                                  'ExpDate':
                                      "${selectedDate.toLocal()}".split(' ')[0],
                                });
                              });
                            });
                            Navigator.pop(context);
                          }
                        },
                      ),
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
