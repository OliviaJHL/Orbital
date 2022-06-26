import 'package:flutter/material.dart';

enum StyleTheme { light, dark }

final styleThemes = {
  StyleTheme.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.grey[700]),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.grey[700]),
  ),
  StyleTheme.dark: ThemeData(
    brightness: Brightness.dark,
  )
};
