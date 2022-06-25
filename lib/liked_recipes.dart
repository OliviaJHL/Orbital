import 'package:flutter/material.dart';

class LikedRecipes extends StatefulWidget {
  const LikedRecipes({Key? key}) : super(key: key);

  @override
  _LikedRecipesState createState() => _LikedRecipesState();
}

class _LikedRecipesState extends State<LikedRecipes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        'Liked recipes',
        style: TextStyle(fontSize: 50.0),
      ),
    );
  }
}
