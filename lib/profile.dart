import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealthy/name.dart';
import 'package:mealthy/reuse.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFFFFFFF),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Welcome,",
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
                  child: Text(
                    Name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF143A62),
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 18.0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Text(
                    'Edit profile',
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
                        Navigator.pushNamed(context, '/Edit_profile').then((_) {
                          setState(() {});
                        });
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                Divider(
                  height: 6,
                  thickness: 1,
                  color: Color(0xFFC4C4C4),
                ),
                profileListtile(context, 'Liked recipes', '/Liked_recipes'),
                Divider(
                  height: 6,
                  thickness: 1,
                  color: Color(0xFFC4C4C4),
                ),
                SizedBox(height: 12.0),
                UIButton(context, 'Log out', () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
