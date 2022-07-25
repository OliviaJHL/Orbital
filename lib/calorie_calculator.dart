import 'package:flutter/material.dart';
import 'package:mealthy/reuse.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mealthy/manage_stats.dart';

class calorieCalculator extends StatefulWidget {
  const calorieCalculator({Key? key}) : super(key: key);
  @override
  _calorieCalculatorState createState() => _calorieCalculatorState();
}

class _calorieCalculatorState extends State<calorieCalculator> {
  final List<String> allGender = ['Male', 'Female'];
  String selectedGender = 'Male';

  final List<String> allActivities = [
    'Basal Metabolic Rate (BMR)',
    'Light: exercise 1-3 times a week',
    'Moderate: exercise 4-5 times a week',
    'Active: daily exercise or intense exercise 3-4 times a week',
    'Intense: intense exercise 6-7 times a week'
  ];
  String selectedActivies = 'Basal Metabolic Rate (BMR)';

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
                      "Calorie calculator",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF143A62),
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(height: 18.0),
                  Expanded(
                    child: ListView(
                      children: [
                        Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                decoration:
                                    buildInputDecoration('Age (ages 15 - 80)'),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                validator: (String? value) {
                                  if (value == "") {
                                    return 'Please key in your age';
                                  }
                                  var ageInt = int.parse(value!);
                                  // ignore: unnecessary_type_check
                                  assert(ageInt is int);
                                  if (ageInt < 15) {
                                    return 'Age must be at least 15';
                                  }
                                  if (ageInt > 80) {
                                    return 'Age must be at most 80';
                                  }
                                  return null;
                                },
                                onSaved: (String? value) {
                                  age = value!;
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
                                value: selectedGender,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedGender = newValue!;
                                  });
                                },
                                items: allGender.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onSaved: (String? value) {
                                  gender = value!;
                                },
                              ),
                              SizedBox(height: 12.0),
                              TextFormField(
                                decoration:
                                    buildInputDecoration('Height (in cm)'),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]')),
                                ],
                                validator: (String? value) {
                                  if (value == "") {
                                    return 'Please key in your height';
                                  }
                                  var heightDouble = double.parse(value!);
                                  // ignore: unnecessary_type_check
                                  assert(heightDouble is double);
                                  if (heightDouble <= 0) {
                                    return 'Height must be larger then 0 cm';
                                  }
                                  if (heightDouble > 500) {
                                    return 'Height must be smaller then 500 cm';
                                  }
                                  return null;
                                },
                                onSaved: (String? value) {
                                  height = value!;
                                },
                              ),
                              SizedBox(height: 12.0),
                              TextFormField(
                                decoration:
                                    buildInputDecoration('Weight (in kg)'),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.]')),
                                ],
                                validator: (String? value) {
                                  if (value == "") {
                                    return 'Please key in your weight';
                                  }
                                  var weightDouble = double.parse(value!);
                                  // ignore: unnecessary_type_check
                                  assert(weightDouble is double);
                                  if (weightDouble <= 0) {
                                    return 'Weight must be larger then 0 kg';
                                  }
                                  if (weightDouble > 10000) {
                                    return 'Weight must be less than 10000 kg';
                                  }
                                  return null;
                                },
                                onSaved: (String? value) {
                                  weight = value!;
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
                                value: selectedActivies,
                                icon: const Icon(
                                  Icons.keyboard_arrow_down,
                                ),
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedActivies = newValue!;
                                  });
                                },
                                items: allActivities.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(
                                      items,
                                      overflow: TextOverflow.fade,
                                    ),
                                  );
                                }).toList(),
                                onSaved: (String? value) {
                                  activity = value!;
                                },
                              ),
                              SizedBox(height: 12.0),
                              UIButton(
                                context,
                                'Calculate',
                                () async {
                                  if (_formkey.currentState!.validate()) {
                                    _formkey.currentState!.save();
                                    Navigator.pushNamed(context, '/Result');
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
