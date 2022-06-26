import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mealthy/ui/components/item_card/item_card.dart';



class LikedRecipes extends StatefulWidget {
  const LikedRecipes({Key? key}) : super(key: key);
  @override
  State<LikedRecipes> createState() => _LikedRecipesState();
}

class _LikedRecipesState extends State<LikedRecipes> {
  Future<void> _onRefresh() async {}

  CollectionReference<Map<String, dynamic>> future =
  FirebaseFirestore.instance.collection('recipes');


  @override
  Widget build(BuildContext context) {
    final recipes = FirebaseFirestore.instance.collection('recipes').where('like', isEqualTo: true);
    return FutureBuilder<QuerySnapshot>(
        future: recipes.get(),
        builder: (context, snapshot) {
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
              body: Stack(children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Liked recipes',
                      style: TextStyle(
                          color: Color(0xFF143A62),
                          fontWeight: FontWeight.w900,
                          fontSize: 36,
                      )),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 100),//140
                    child: RefreshIndicator(
                        onRefresh: () => _onRefresh(),
                        child: GridView.count(
                            primary: false,
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, bottom: 30),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,

                            //future.where('like', isEqualTo: true).
                            children: snapshot.data?.docs.map((document) {
                              Map<String, dynamic> data = document.data()!
                              as Map<String, dynamic>;
                              //if (data['like'] == 'true') {
                                return ItemCard(
                                    docId: data[
                                      'id' //'id'
                                    ], data: data, details: future.doc(data['id']).collection('detail').get());
                              //} else {
                                //return
                              //}
                            }).toList()??
                                []))),


              ]));
        });
  }
}


