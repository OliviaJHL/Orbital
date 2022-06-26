import 'package:mealthy/homepage.dart';
import 'package:mealthy/navigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mealthy/breakfast.dart';
import 'package:mealthy/calorie_calculator.dart';
import 'package:mealthy/Temp.dart';
import 'package:mealthy/allergens.dart';
import 'package:mealthy/calorie_record.dart';
import 'package:mealthy/change_username.dart';
import 'package:mealthy/dinner.dart';
import 'package:mealthy/edit_food.dart';
import 'package:mealthy/edit_profile.dart';
import 'package:mealthy/forget_password_screen.dart';
import 'package:mealthy/liked_recipes.dart';
import 'package:mealthy/login_screen.dart';
import 'package:mealthy/lunch.dart';
import 'package:mealthy/new_food.dart';
import 'package:mealthy/others.dart';
import 'package:mealthy/record_history.dart';
import 'package:mealthy/result.dart';
import 'package:mealthy/set_goal.dart';
import 'package:mealthy/signup_screen.dart';
import 'package:mealthy/verification_sign_up.dart';
import 'navigation.dart';

import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mealthy/ui/styles/themes.dart';
import 'package:get/get.dart';


import 'package:mealthy/blocs/item_filter/item_filter_bloc.dart';
import 'package:mealthy/blocs/search_bloc/search_bloc.dart';
import 'package:mealthy/blocs/item_list/item_list_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp ();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<ItemFilterBloc>(
            create: (context) => ItemFilterBloc(),
          ),
          BlocProvider<ItemListBloc>(
            create: (context) => ItemListBloc(),
          ),
          BlocProvider<SearchBloc>(
            create: (context) => SearchBloc(),
          ),
        ],
        child: GetMaterialApp(
          theme: styleThemes[StyleTheme.light],
          title: 'MealThy',
          debugShowCheckedModeBanner: false,
          initialRoute: '/Login',// '/Navigation',
             routes: {
               '/Verification_sign_up': (context) => const VerificationPage_sign_up(),
               '/Login': (context) => const LoginPage(),
               '/ForgotPassword': (context) => const ForgetpasswordPage(),
               '/SignUp': (context) => const SignupPage(),
               '/Navigation': (context) => const Navigation(),
               '/Allergens_fromVeri': (context) => const allergensPage(
                 page: '/Verification_sign_up',
               ),
               '/Allergens_fromProfile': (context) => const allergensPage(
                 page: '/Edit_profile',
               ),
               '/Temp': (context) => const Temp(),
               '/Calorie_calculator': (context) => const calorieCalculator(),
               '/Result': (context) => const Result(),
               '/Set_goal': (context) => const setGoal(),
               '/Calorie_record': (context) => const calorieRecord(),
               '/Breakfast': (context) => const Breakfast(),
               '/Lunch': (context) => const Lunch(),
               '/Dinner': (context) => const Dinner(),
               '/Others': (context) => const Others(),
               '/New_food': (context) => const newFood(),
               '/Record_history': (context) => const RecordHistroy(),
               '/Edit_profile': (context) => const EditProfile(),
               '/Liked_recipes': (context) => const LikedRecipes(),
               '/Change_name': (context) => const ChangeName(), '/Edit_food': (context) => const editFood(),
            },
        ));
  }
}
