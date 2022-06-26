import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NutritionScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  final String docId;
  final Future<QuerySnapshot<Map<String, dynamic>>> details;

  const NutritionScreen(
      {Key? key,
      required this.data,
      required this.docId,
      required this.details})
      : super(key: key);
  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  String _dropdownValue = '+ Add to my meal';
  String dropdownValue = '100 g';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF8C8C8C),
            size: 30.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      body: FutureBuilder<QuerySnapshot>(
        future: widget.details,
        builder: (context, snapshot) {
          Map<String, dynamic>? detailData = snapshot.data?.docs[0].data() as Map<String, dynamic>?;
          return snapshot.connectionState == ConnectionState.done ?
          Padding(
            padding: EdgeInsets.all(50),
            child: ListView(
              children: <Widget>[

                 Container(
                    child: Image.network(
                      widget.data['image'],
                      height: MediaQuery
                          .of(context)
                          .size
                          .width * 0.5,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.5,
                    ),
                  ),

                Text(
                  widget.data['name'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 28,
                      color: Color(0xFF4A4A4A),
                      fontWeight: FontWeight.w600),
                ),

                SizedBox(
                  height: 15.0,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      color: Colors.transparent,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFCC25E),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0))),
                          child: new Center(
                            child: new Text(
                              detailData?['calories'],
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white),
                              textAlign: TextAlign.center,),
                          )),
                    ),

                    SizedBox(
                      height: 5.0,
                    ),

                    Container(
                      height: 70.0,
                      width: 70.0,
                      color: Colors.transparent,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFCC25E),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0))),
                          child: new Center(
                            child: new Text(
                              detailData?['protein'],
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white),
                              textAlign: TextAlign.center,),
                          )),
                    ),

                    SizedBox(
                      height: 5.0,
                    ),

                    Container(
                      height: 70.0,
                      width: 70.0,
                      color: Colors.transparent,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFCC25E),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0))),
                          child: new Center(
                            child: new Text(
                              detailData?['sugar'],
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white),
                              textAlign: TextAlign.center,),
                          )),
                    ),

                    SizedBox(
                      height: 5.0,
                    ),

                    Container(
                      height: 70.0,
                      width: 70.0,
                      color: Colors.transparent,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFCC25E),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0))),
                          child: new Center(
                            child: new Text(
                              detailData?['fat'],
                              style: TextStyle(
                                  fontSize: 18, color: Colors.white),
                              textAlign: TextAlign.center,),
                          )),
                    ),
                  ],
                ),

                SizedBox(
                  height: 30.0,
                ),
                Container(width: double.infinity,
                  child: Text(
                    "Serving",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF4A4A4A),
                        fontWeight: FontWeight.w600),
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),
                Container(
                  //padding: EdgeInsets.symmetric(vertical: 5, horizontal: 135),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.transparent,
                      border: Border.all(
                          color: Color(0xFFFCC25E),
                          style: BorderStyle.solid,
                          width: 2
                      )),
                  padding: EdgeInsets.only(left: 10.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(
                        Icons.expand_more_outlined,
                        color: Color(0xFFFCC25E),
                        size: 25.0,
                      ),
                      //elevation: 16,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFFFCC25E),
                        fontWeight: FontWeight.w600,
                      ),
                      isExpanded: true,

                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },

                      items: <String>['100 g', '200 g', '300 g']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),

                SizedBox(
                  child: Text(
                    'Nutrition fact',
                    //textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF4A4A4A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),

                Container(
                  child: Text(
                    detailData?['nutritionfact'],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),

                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Colors.transparent,
                      border: Border.all(
                          color: Color(0xFFFCC25E),
                          style: BorderStyle.solid,
                          width: 2
                      )),
                  padding: EdgeInsets.only(left: 10.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _dropdownValue,

                      icon: const Icon(
                        Icons.expand_more_outlined,
                        color: Color(0xFFFCC25E),
                      ),

                      //elevation: 10,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Color(0xFFFCC25E),
                        fontWeight: FontWeight.w600,
                      ),
                      isExpanded: true,

                      onChanged: (String? newValue) {
                        setState(() {
                          _dropdownValue = newValue!;
                        });
                      },

                      items: <String>[
                        '+ Add to my meal',
                        'Breakfast',
                        'Lunch',
                        'Dinner',
                        'Other'
                      ]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),



                  ],
                ),
          ): Center(child: CircularProgressIndicator());
        }),
    );
  }
}
