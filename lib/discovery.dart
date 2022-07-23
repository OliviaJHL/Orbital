import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealthy/recipe_nutrition_state.dart';
import 'package:mealthy/reuse.dart';
import 'package:mealthy/email.dart';

class Discovery extends StatefulWidget {
  const Discovery({Key? key}) : super(key: key);

  @override
  _DiscoveryState createState() => _DiscoveryState();
}

class _DiscoveryState extends State<Discovery> {
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
                  SizedBox(height: 12.0),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Discovery",
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
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              fillColor: Color(0xFFEEF5FF),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  borderSide: BorderSide.none),
                              hintText: 'Search',
                              prefixIcon: Container(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(Icons.search, size: 30),
                              )),
                          onSubmitted: (value) {
                            strSearch = value.toLowerCase();
                            mylikestate = <bool>[];
                            setState(() {});
                          },
                          onChanged: (value) {
                            if (value == '') {
                              strSearch = '';
                              mylikestate = <bool>[];
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Container(
                        height: 60.0,
                        width: 60.0,
                        decoration: BoxDecoration(
                            color: Color(0xFFFCC25E),
                            borderRadius: BorderRadius.circular(5.0)),
                        child: Theme(
                          data: ThemeData(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.filter_list,
                              color: Colors.white,
                            ),
                            iconSize: 30,
                            onPressed: () {
                              Navigator.pushNamed(context, '/Fitler')
                                  .then((value) {
                                setState(() {
                                  mylikestate = <bool>[];
                                });
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    future: myRecipes(),
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
                                      Navigator.pushNamed(context, '/Recipes');
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
                                                      padding: EdgeInsets.only(
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
                                                      /*allDocs[index]['Liked'] ==
                                                          false
                                                      ? Icon(
                                                          Icons.favorite_outline,
                                                          color:
                                                              Color(0xFFFCC25E),
                                                        )
                                                      : Icon(
                                                          Icons.favorite,
                                                          color:
                                                              Color(0xFFFCC25E),
                                                        ),*/
                                                      iconSize: 28.0,
                                                      onPressed: () {
                                                        if (mylikestate[
                                                            index]) {
                                                          likedRecipe.remove(
                                                              allDocs[index]
                                                                  ['Name']);
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
                                                        } else {
                                                          if (likedRecipe
                                                                  .length <
                                                              10) {
                                                            likedRecipe.add(
                                                                allDocs[index]
                                                                    ['Name']);
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
                                                                      .docs[0]
                                                                      .id)
                                                                  .update({
                                                                'likedRecipe':
                                                                    likedRecipe
                                                              });
                                                            });
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                              duration:
                                                                  const Duration(
                                                                      seconds:
                                                                          2),
                                                              content: Text(
                                                                  'You can only like up to 8 recipes'),
                                                            ));
                                                          }
                                                        }

                                                        /*db
                                                            .collection(
                                                                'Recipes')
                                                            .doc(allDocs[index]
                                                                ['Name'])
                                                            .update({
                                                          'Liked':
                                                              mylikestate[index]
                                                        });*/
                                                        (context as Element)
                                                            .markNeedsBuild();
                                                      },
                                                    );
                                                  },
                                                )

                                                /*IconButton(
                                                  padding: EdgeInsets.only(
                                                      top: 12.0, right: 12.0),
                                                  constraints: BoxConstraints(),
                                                  icon: Icon(
                                                    mylikestate[index]
                                                        ? Icons.favorite
                                                        : Icons.favorite_outline,
                                                    color: Color(0xFFFCC25E),
                                                  ),
                                                  /*allDocs[index]['Liked'] ==
                                                          false
                                                      ? Icon(
                                                          Icons.favorite_outline,
                                                          color:
                                                              Color(0xFFFCC25E),
                                                        )
                                                      : Icon(
                                                          Icons.favorite,
                                                          color:
                                                              Color(0xFFFCC25E),
                                                        ),*/
                                                  iconSize: 28.0,
                                                  onPressed: () {
                                                    db
                                                        .collection('Recipes')
                                                        .doc(allDocs[index]
                                                            ['Name'])
                                                        .update({
                                                      'Liked': !allDocs[index]
                                                          ['Liked']
                                                    });
                                                  },
                                                ),*/
                                                ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: showNetworkImg(
                                                  allDocs[index]['Image'], 1.0,
                                                  onWait: Image.asset(
                                                      'images/image_loader.gif'),
                                                  onError: const Icon(
                                                    Icons.not_interested,
                                                    color: Colors.grey,
                                                    size: 80.0,
                                                  )),
                                              /*child: FadeInImage.assetNetwork(
                                                  placeholder:
                                                      'images/image_loader.gif',
                                                  image: allDocs[index]
                                                      ['Image'],
                                                ),*/
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
                  SizedBox(
                    height: 24.0,
                  )
                ],
              ),
            ),
          )),
    );
  }
}
