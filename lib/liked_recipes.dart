import 'package:flutter/material.dart';
import 'package:mealthy/reuse.dart';

class LikedRecipes extends StatefulWidget {
  const LikedRecipes({Key? key}) : super(key: key);

  @override
  _LikedRecipesState createState() => _LikedRecipesState();
}

class _LikedRecipesState extends State<LikedRecipes> {
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
              children: <Widget>[
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
