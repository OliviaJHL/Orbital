import 'dart:async';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  MainAppBar({Key? key}) : super(key: key);

  final double appBarHeight = 0.0;

  @override
  get preferredSize => Size.fromHeight(appBarHeight);

  @override
  Widget build(BuildContext context) {

    return AppBar(
      elevation: 0.0,
      iconTheme: const IconThemeData(
        color: Colors.grey,
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
    );
  }

//
}
