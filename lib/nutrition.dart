import 'package:flutter/material.dart';
import 'package:mealthy/recipe_nutrition_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealthy/reuse.dart';

class Nutrition extends StatefulWidget {
  const Nutrition({Key? key}) : super(key: key);

  @override
  _NutritionState createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
          width: double.infinity,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 12.0),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Nutrition",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color(0xFF143A62),
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        fillColor: Color(0xFFEEF5FF),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide.none),
                        hintText: 'Search',
                        prefixIcon: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.search,
                            size: 30,
                          ),
                        )),
                    onSubmitted: (value) {
                      nutriSearch = value.toLowerCase();
                      setState(() {});
                    },
                    onChanged: (value) {
                      if (value == '') {
                        nutriSearch = '';
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(height: 16.0),
                  FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    future: myNutrition(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        int docLength = snapshot.data!.docs.length;
                        var allDocs = snapshot.data!.docs;
                        if (docLength == 0) {
                          return Text(
                            'No result found, please try again',
                            style: TextStyle(
                              color: Color(0xFF4A4A4A),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        }
                        return Expanded(
                          child: RefreshIndicator(
                            color: Color(0xFFFCC25E),
                            onRefresh: () async {
                              setState(() {});
                            },
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 200,
                                      crossAxisSpacing: 12.0,
                                      mainAxisSpacing: 12.0,
                                      childAspectRatio: 1.0),
                              itemCount: docLength,
                              itemBuilder: (BuildContext context, index) {
                                return Card(
                                  child: GestureDetector(
                                    onTap: () {
                                      currentNutrition = allDocs[index]['Name'];
                                      print(currentNutrition);
                                      Navigator.pushNamed(
                                          context, '/Nutrition_detail');
                                    },
                                    child: Container(
                                      color: Color(0xFFEEF5FF),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: showNetworkImg(
                                                  allDocs[index]['Image'], 1.0,
                                                  onWait: Image.asset(
                                                      'images/image_loader.gif'),
                                                  onError: const Icon(
                                                    Icons.not_interested,
                                                    color: Colors.grey,
                                                    size: 80.0,
                                                  )),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 6.0,
                                                right: 6.0,
                                                bottom: 12.0),
                                            child: Text(
                                              allDocs[index]['Name'],
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Color(0xFF4A4A4A),
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        return Text('');
                      }
                    },
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
