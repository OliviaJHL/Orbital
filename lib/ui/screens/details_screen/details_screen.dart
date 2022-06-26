import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  final String docId;
  final Future<QuerySnapshot<Map<String, dynamic>>> details;

  const DetailsScreen(
      {Key? key,
      required this.data,
      required this.docId,
      required this.details})
      : super(key: key);
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String _dropdownValue = '+ Add to my meal';

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
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                widget.data['like'] = !widget.data['like'];
                setState(() {});
                FirebaseFirestore.instance
                    .collection('recipes')
                    .doc(widget.docId)
                    .set(widget.data);
              },
              child: widget.data['like']
                  ? const Icon(
                Icons.favorite_sharp,
                color: Color(0xFFFCC25E),
                size: 30.0,
              )
                  : const Icon(
                Icons.favorite_border,
                color: Color(0xFFFCC25E),
                size: 30.0,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () {
                print('Click share button');
              },
              child: Icon(
                Icons.share,
                color: Color(0xFFFCC25E),
                size: 30.0,
              ),
            ),
          ),
        ],
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
                  children: [
                    Icon(
                      Icons.timer_outlined,
                      color: Color(0xFFFCC25E),
                      size: 30.0,
                    ),

                    Text(
                      detailData?['time'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A4A4A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Icon(
                      Icons.person_outline,
                      color: Color(0xFFFCC25E),
                      size: 30.0,
                    ),

                    Text(
                      detailData?['serving'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A4A4A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Icon(
                      Icons.check_box_outline_blank,
                      color: Color(0xFFFCC25E),
                      size: 30.0,
                    ),

                    Text(
                      detailData?['calories'],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A4A4A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 30.0,
                ),

                Expanded(
                      child: SizedBox(
                                child: Text(
                                  detailData?['description'],
                                  //textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF4A4A4A),
                                  ),
                                ),
                      ),
                    ),

                SizedBox(
                  height: 15.0,
                ),

                SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.7,
                    child: Text(
                      'Ingredients',
                      //textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color(0xFF4A4A4A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ),

                SizedBox(
                  height: 5.0,
                ),

                SizedBox(
                    child: Text(
                      detailData?['Ingredients'][0],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF4A4A4A),
                      ),
                    ),
                  ),

                SizedBox(
                  height: 5.0,
                ),

                Container(
                  child: Text(
                    detailData?['Ingredients'][1],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                ),

                SizedBox(
                  height: 5.0,
                ),

                Container(
                  child: Text(
                    detailData?['Ingredients'][2],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                ),

                SizedBox(
                  height: 15.0,
                ),

                SizedBox(
                  child: Text(
                    'Preperation',
                    //textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF4A4A4A),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                SizedBox(
                  height: 5.0,
                ),

                Container(
                  child: Text(
                    detailData?['Preperation'][0],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                ),

                SizedBox(
                  height: 5.0,
                ),

                Container(
                  child: Text(
                    detailData?['Preperation'][1],
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10.0,
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
