import 'package:flutter/material.dart';
import 'package:mealthy/pantry_stats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealthy/email.dart';
import 'package:mealthy/reuse.dart';
import 'package:mealthy/loader.dart';

class Pantry extends StatefulWidget {
  const Pantry({Key? key}) : super(key: key);

  @override
  _PantryState createState() => _PantryState();
}

class _PantryState extends State<Pantry> with WidgetsBindingObserver {
  var db = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getIngrident() async {
    return await database
        .collection('Users')
        .where('Email', isEqualTo: Email)
        .get()
        .then((value) async {
      return await database
          .collection("Users")
          .doc(value.docs[0].id)
          .collection("Pantry")
          .orderBy('ExpDate', descending: true)
          .get()
          .then((value) => value);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // user returned to our app
      setState(() {});
    } else if (state == AppLifecycleState.inactive) {
      // app is inactive
    } else if (state == AppLifecycleState.paused) {
      // user quit our app temporally
    } else if (state == AppLifecycleState.detached) {
      // app suspended
    }
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
            child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
              future: getIngrident(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  checkFood(Email);
                  return Column(
                    children: [
                      SizedBox(
                        height: 12.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          "Pantry",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color(0xFF143A62),
                            fontSize: 36,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: myCheck == true
                            ? Column(
                                children: [
                                  SizedBox(height: 12.0),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          WidgetSpan(
                                            child: Icon(
                                              Icons.report_problem,
                                              size: 20,
                                              color: Color(0xFFDC0C15),
                                            ),
                                          ),
                                          TextSpan(
                                              text:
                                                  " Expired food detected in your pantry",
                                              style: TextStyle(
                                                color: Color(0xFFDC0C15),
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w600,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      ),
                      SizedBox(
                        height: 12.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, '/New_food').then((_) {
                              setState(() {});
                            });
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            size: 30.0,
                            color: Color(0xFFFCC25E),
                          ),
                          label: Text('Add new food',
                              style: TextStyle(
                                color: Color(0xFFFCC25E),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              )),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(0.0),
                            primary: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            for (var doc in snapshot.data.docs)
                              Column(
                                children: <Widget>[
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0.0),
                                    leading: DateTime.parse(doc['ExpDate'])
                                                .compareTo(DateTime.parse(
                                                    "${DateTime.now().toLocal()}"
                                                        .split(' ')[0])) >=
                                            0
                                        ? Image.asset('images/' +
                                            doc["Category"] +
                                            ".png")
                                        : Image.asset(
                                            'images/' +
                                                doc["Category"] +
                                                ".png",
                                            color: Colors.grey.withOpacity(0.8),
                                            colorBlendMode: BlendMode.srcATop,
                                          ),
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: Text(
                                        doc["Name"] +
                                            ': ' +
                                            doc["Quantity"] +
                                            ' ' +
                                            doc["Unit"],
                                        style: TextStyle(
                                          color: Color(0xFFF4A4A4A),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    subtitle: Text(
                                      'Exp: ' + doc["ExpDate"],
                                      style: TextStyle(
                                        color: Color(0xFFF4A4A4A),
                                      ),
                                    ),
                                    trailing: Theme(
                                      data: ThemeData(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                      ),
                                      child: Column(
                                        children: [
                                          DateTime.parse(doc['ExpDate'])
                                                  .isBefore(DateTime.parse(
                                                      "${DateTime.now().toLocal()}"
                                                          .split(' ')[0]))
                                              ? Icon(
                                                  Icons.not_interested,
                                                  color: Color(0xFFF4A4A4A),
                                                  size: 20.0,
                                                )
                                              : InkWell(
                                                  onTap: () {
                                                    foodName = doc['Name'];
                                                    quantity = doc['Quantity'];
                                                    unit = doc['Unit'];
                                                    category = doc['Category'];
                                                    selectedDate =
                                                        DateTime.parse(
                                                            doc['ExpDate']);
                                                    ID = doc['ID'];
                                                    Navigator.pushNamed(context,
                                                            '/Edit_food')
                                                        .then((_) {
                                                      setState(() {});
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: Color(0xFFF4A4A4A),
                                                  ),
                                                ),
                                          SizedBox(
                                            height: 8.0,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              await db
                                                  .collection('Users')
                                                  .where('Email',
                                                      isEqualTo: Email)
                                                  .get()
                                                  .then((value) async {
                                                await db
                                                    .collection('Users')
                                                    .doc(value.docs[0].id)
                                                    .collection('Pantry')
                                                    .where('ID',
                                                        isEqualTo: doc["ID"])
                                                    .get()
                                                    .then((ref) async {
                                                  await db
                                                      .collection('Users')
                                                      .doc(value.docs[0].id)
                                                      .collection('Pantry')
                                                      .doc(ref.docs[0].id)
                                                      .delete();
                                                  checkFood(Email);
                                                });
                                              });
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: Color(0xFFF4A4A4A),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 48,
                                    thickness: 1,
                                    color: Color(0xFFC4C4C4),
                                  )
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Loader();
                  /*return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          child: CircularProgressIndicator(
                            color: Color(0xFFFCC25E),
                            strokeWidth: 8.0,
                          ),
                          height: 80.0,
                          width: 80.0,
                        )
                      ],
                    ),
                  );*/
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
