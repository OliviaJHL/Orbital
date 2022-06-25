import 'package:flutter/material.dart';
import 'package:mealthy/reuse.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                backToPrevious(context),
                SizedBox(
                  height: 12.0,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    "Edit profile",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color(0xFF143A62),
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 18.0),
                profileListtile(context, 'Change username', '/Change_name'),
                Divider(
                  height: 6,
                  thickness: 1,
                  color: Color(0xFFC4C4C4),
                ),
                profileListtile(
                    context, 'Change my allergens', '/Allergens_fromProfile'),
                Divider(
                  height: 6,
                  thickness: 1,
                  color: Color(0xFFC4C4C4),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
