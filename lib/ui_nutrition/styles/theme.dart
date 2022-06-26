import 'package:flutter/material.dart';

enum StyleTheme { light, dark }

final styleThemes = {
  StyleTheme.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.grey[500]),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.grey[500]),
  ),
  StyleTheme.dark: ThemeData(
    brightness: Brightness.dark,
  )
};
