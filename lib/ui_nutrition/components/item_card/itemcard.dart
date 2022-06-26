import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealthy/ui_nutrition/screens/detailsscreen/nutrition_screen.dart';

class Itemcard extends StatefulWidget {
  final String docId;
  late Map<String, dynamic> data;
  final Future<QuerySnapshot<Map<String, dynamic>>> details;


  Itemcard({
    Key? key,
    required this.docId,
    required this.data,
    required this.details})
      : super(key: key);

  @override
  State<Itemcard> createState() => _ItemcardState();
}

class _ItemcardState extends State<Itemcard> {
  @override
  Widget build(BuildContext context) {
    //_setLike() {
      FirebaseFirestore.instance
          .collection('nutrition')
          .doc(widget.docId)
          .set(widget.data);
    //}

    return GestureDetector(
      onTap: () => Get.to(() => NutritionScreen(
        docId: widget.docId,
        data: widget.data,
        details: widget.details,
      )),

      child: Card(
          color: Color(0xFFF2F6FC),
          elevation: 4,
          child: SizedBox(
            width: 200,
            height: 300,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Expanded(child: Image.network(widget.data['image'])),

                  Padding(
                    padding: const EdgeInsets.symmetric(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.data['name'],
                            style: const TextStyle(
                              color: Color(0xFF4A4A4A),
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,),
                          ),
                        ],),
                      ],
                    ),
                  ),

                ]),
          )),
    );
  }
}
