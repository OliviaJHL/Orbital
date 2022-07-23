import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mealthy/filter_stats.dart';

var db = FirebaseFirestore.instance;

//Search for recipe
String strSearch = '';

String nutriSearch = '';

List likedRecipe = [];

//Realted with recipes
Future<QuerySnapshot<Map<String, dynamic>>> myRecipes() async {
  var temp = await db.collection('Recipes');
  if (strSearch != '') {
    print(strSearch);
    return temp.where('Search', arrayContainsAny: [strSearch]).get();
  } else if (choosenCuisine.length != 0) {
    return temp.where('Cuisine', arrayContainsAny: choosenCuisine).get();
  }
  return temp.get();
}

String currentRecipe = '';

String currentRecipeCal = '';

//Get the detailed information about the selected recipe
Future<DocumentSnapshot<Map<String, dynamic>>> recipeName() async {
  return await db
      .collection('Recipes')
      .doc(currentRecipe)
      .collection('Recipe details')
      .doc('Details')
      .get();
}

//Related with nutrition
String currentNutrition = '';

String currentNutritionCal = '';

Future<QuerySnapshot<Map<String, dynamic>>> myNutrition() async {
  var temp = await db.collection('Nutrition');
  if (nutriSearch != '') {
    print(nutriSearch);
    return temp.where('Search', arrayContainsAny: [nutriSearch]).get();
  }
  return temp.get();
}

Future<DocumentSnapshot<Map<String, dynamic>>> nutritionName() async {
  return await db
      .collection('Nutrition')
      .doc(currentNutrition)
      .collection('Nutrition details')
      .doc('Details')
      .get();
}

//Liked recipes
Future<QuerySnapshot<Map<String, dynamic>>> likedRecipes() async {
  //return await db.collection('Recipes').where('Liked', isEqualTo: true).get();
  return await db
      .collection('Recipes')
      .where('Name', whereIn: likedRecipe)
      .get();
}

//Related with allergens, this part is connected with allergen warning in recipe details page
List<String> myTitle = [
  'Eggs',
  'Fish',
  'Milk',
  'Peanuts',
  'Shellfish',
  'Soya beans',
  'Tree nuts',
  'Wheat',
];

List<String> myImage = [
  'images/Eggs.png',
  'images/Fish.png',
  'images/Milk.png',
  'images/Peanuts.png',
  'images/Prawn.png',
  'images/Soya.png',
  'images/Nuts.png',
  'images/Wheat.png',
];

List<bool> myCheckAllergens = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];
