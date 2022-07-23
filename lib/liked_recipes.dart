import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealthy/recipe_nutrition_state.dart';
import 'package:mealthy/reuse.dart';
import 'package:mealthy/email.dart';

class LikedRecipes extends StatefulWidget {
  const LikedRecipes({Key? key}) : super(key: key);
  @override
  State<LikedRecipes> createState() => _LikedRecipesState();
}

class _LikedRecipesState extends State<LikedRecipes> {
  late List<bool> mylikestate = <bool>[];

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
                  children: [
                    backToPrevious(context),
                    SizedBox(
                      height: 12.0,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        "Liked recipes",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color(0xFF143A62),
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      future: likedRecipes(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          int docLength = snapshot.data!.docs.length;
                          var allDocs = snapshot.data!.docs;
                          /*for (var doc in allDocs)
                            mylikestate.add(doc['Liked']);*/
                          for (var doc in allDocs)
                            mylikestate.add(likedRecipe.contains(doc['Name']));
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
                                        childAspectRatio: 0.8),
                                itemCount: docLength,
                                itemBuilder: (BuildContext context, index) {
                                  return Card(
                                    child: GestureDetector(
                                      onTap: () {
                                        currentRecipe = allDocs[index]['Name'];
                                        print(currentRecipe);
                                        Navigator.pushNamed(
                                            context, '/Recipes');
                                      },
                                      child: Container(
                                        color: Color(0xFFEEF5FF),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Theme(
                                              data: ThemeData(
                                                splashColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                hoverColor: Colors.transparent,
                                              ),
                                              child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Builder(
                                                    builder: (context) {
                                                      return IconButton(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 12.0,
                                                                right: 12.0),
                                                        constraints:
                                                            BoxConstraints(),
                                                        icon: Icon(
                                                          mylikestate[index]
                                                              ? Icons.favorite
                                                              : Icons
                                                                  .favorite_outline,
                                                          color:
                                                              Color(0xFFFCC25E),
                                                        ),
                                                        iconSize: 28.0,
                                                        onPressed: () {
                                                          if (mylikestate[
                                                              index]) {
                                                            likedRecipe.remove(
                                                                allDocs[index]
                                                                    ['Name']);
                                                          } else {
                                                            likedRecipe.add(
                                                                allDocs[index]
                                                                    ['Name']);
                                                          }
                                                          mylikestate[index] =
                                                              !mylikestate[
                                                                  index];
                                                          db
                                                              .collection(
                                                                  'Users')
                                                              .where('Email',
                                                                  isEqualTo:
                                                                      Email)
                                                              .get()
                                                              .then((value) {
                                                            db
                                                                .collection(
                                                                    'Users')
                                                                .doc(value
                                                                    .docs[0].id)
                                                                .update({
                                                              'likedRecipe':
                                                                  likedRecipe
                                                            });
                                                          });
                                                          /*mylikestate[index] =
                                                              !mylikestate[
                                                                  index];
                                                          db
                                                              .collection(
                                                                  'Recipes')
                                                              .doc(
                                                                  allDocs[index]
                                                                      ['Name'])
                                                              .update({
                                                            'Liked':
                                                                mylikestate[
                                                                    index]
                                                          });*/
                                                          (context as Element)
                                                              .markNeedsBuild();
                                                        },
                                                      );
                                                    },
                                                  )),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: showNetworkImg(
                                                    allDocs[index]['Image'],
                                                    1.0,
                                                    onWait: Image.asset(
                                                        'images/image_loader.gif'),
                                                    onError: const Icon(
                                                      Icons.not_interested,
                                                      color: Colors.grey,
                                                      size: 80.0,
                                                    )),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 12.0,
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
                  ],
                )),
          )),
    );
  }
}
