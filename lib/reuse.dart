import 'package:flutter/material.dart';
import 'package:mealthy/manage_stats.dart';
import 'package:mealthy/email.dart';
import 'package:mealthy/name.dart';
import 'package:mealthy/pantry_stats.dart';
import 'package:mealthy/recipe_nutrition_state.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

InputDecoration buildInputDecoration(String hinttext) {
  return InputDecoration(
    hintText: hinttext,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5.0),
      borderSide: BorderSide(color: Color(0xFFC4C4C4), width: 1),
    ),
  );
}

Container backToPrevious(BuildContext context) {
  return Container(
    width: double.infinity,
    child: IconButton(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        alignment: Alignment.centerLeft,
        icon: const Icon(Icons.arrow_back_ios),
        iconSize: 36.0,
        color: Color(0xFF8C8C8C),
        onPressed: () {
          Navigator.pop(context);
        }),
  );
}

Container UIButton(BuildContext context, String title, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 60,
    margin: const EdgeInsets.fromLTRB(0, 12, 0, 12),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return Color(0xFFFCC25E);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)))),
      child: Text(
        title,
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.0),
      ),
    ),
  );
}

ListTile profileListtile(
    BuildContext context, String title, String redirectPage) {
  return ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Text(
      title,
      style: TextStyle(
          color: Color(0xFF4A4A4A),
          fontSize: 18.0,
          fontWeight: FontWeight.w600),
    ),
    trailing: Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: IconButton(
        padding: EdgeInsets.all(0.0),
        alignment: Alignment.centerRight,
        onPressed: () {
          Navigator.pushNamed(context, redirectPage);
        },
        icon: Icon(Icons.arrow_forward_ios),
      ),
    ),
  );
}

void checkFood(String? email) async {
  Email = email!;
  await db
      .collection('Users')
      .where('Email', isEqualTo: Email)
      .get()
      .then((value) async {
    await db
        .collection('Users')
        .doc(value.docs[0].id)
        .collection('Pantry')
        .get()
        .then((ref) {
      if (ref.docs.isNotEmpty) {
        for (var doc in ref.docs) {
          if (DateTime.parse(doc['ExpDate']).isBefore(
              DateTime.parse("${DateTime.now().toLocal()}".split(' ')[0]))) {
            myCheck = true;
            break;
          } else {
            myCheck = false;
          }
        }
      } else {
        myCheck = false;
      }
    });
  });
}

String myInitial(String? email, BuildContext context, String redirectedPage) {
  Email = email!;

  //Get calorie
  db.collection('Users').where('Email', isEqualTo: Email).get().then((value) {
    db
        .collection('Users')
        .doc(value.docs[0].id)
        .collection('Calorie record')
        .where('Date', isEqualTo: "${DateTime.now().toLocal()}".split(' ')[0])
        .get()
        .then(
      (ref) {
        if (ref.docs.isNotEmpty) {
          db
              .collection('Users')
              .doc(value.docs[0].id)
              .collection('Calorie record')
              .doc(ref.docs[0].id)
              .get()
              .then(
            (value) {
              breakfast = value['Breakfast'];
              lunch = value['Lunch'];
              dinner = value['Dinner'];
              others = value['Others'];
            },
          );
        } else {
          breakfast = '0';
          lunch = '0';
          dinner = '0';
          others = '0';
        }
      },
    );
  });

  //Get name
  db.collection('Users').where('Email', isEqualTo: Email).get().then((value) {
    db.collection('Users').doc(value.docs[0].id).get().then((value) {
      Name = value['Name'];
    });
  });

  //Get goal
  db.collection('Users').where('Email', isEqualTo: Email).get().then((value) {
    db.collection('Users').doc(value.docs[0].id).get().then((value) {
      goal = value['Set goal'];
    });
  });

  //Set up like
  db.collection('Users').where('Email', isEqualTo: Email).get().then((value) {
    db.collection('Users').doc(value.docs[0].id).get().then((value) {
      likedRecipe = [];
      likedRecipe.addAll(value['likedRecipe']);
      print(likedRecipe);
    });
  });

  //Get allergens
  db.collection('Users').where('Email', isEqualTo: Email).get().then((value) {
    db.collection('Users').doc(value.docs[0].id).get().then((value) {
      myCheckAllergens[0] = value['Allergens']['Eggs'];
      myCheckAllergens[1] = value['Allergens']['Fish'];
      myCheckAllergens[2] = value['Allergens']['Milk'];
      myCheckAllergens[3] = value['Allergens']['Peanuts'];
      myCheckAllergens[4] = value['Allergens']['Shellfish'];
      myCheckAllergens[5] = value['Allergens']['Soya beans'];
      myCheckAllergens[6] = value['Allergens']['Tree nuts'];
      myCheckAllergens[7] = value['Allergens']['Wheat'];
    });
  });

  //Refresh
  return redirectedPage;
}

Future<Widget> getNetworkImg(String imgUrl, double scaleSize,
    {Widget onError = const Icon(Icons.error)}) async {
  try {
    http.Response response = await http
        .get(Uri.parse(imgUrl), headers: {"Accept": "application/json"});
    if (response.statusCode == 200) {
      return Image.memory(
        response.bodyBytes,
        scale: scaleSize,
      );
    } else {
      return onError;
    }
  } catch (e) {
    return onError;
  }
}

Widget showNetworkImg(String imgUrl, double imageScale,
    {Widget onWait = const CircularProgressIndicator(),
    Widget onError = const Icon(Icons.error)}) {
  return FutureBuilder<Widget>(
    future: getNetworkImg(imgUrl, imageScale, onError: onError),
    builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
      if (snapshot.connectionState != ConnectionState.done) {
        return onWait;
      } else if (snapshot.hasError || !snapshot.hasData) {
        return onError;
      } else {
        return snapshot.data!;
      }
    },
  );
}
