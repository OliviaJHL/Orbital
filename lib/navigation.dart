import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mealthy/Manage.dart';
import 'package:mealthy/discovery.dart';
import 'package:mealthy/nutrition.dart';
import 'package:mealthy/pantry.dart';
import 'package:mealthy/profile.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int currentIndex = 0;

  List<Widget> bottomBarScreens = <Widget>[
    const Discovery(),
    const Pantry(),
    const Manage(),
    const Nutrition(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: bottomBarScreens[currentIndex],
      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
            backgroundColor: Color(0xFFFCC25E),
            iconSize: 32.0,
            unselectedItemColor: Colors.white,
            selectedItemColor: Color(0xFFEC6543),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            onTap: (index) => setState(() => currentIndex = index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant),
                label: 'Discovery',
              ),
              BottomNavigationBarItem(
                icon: Icon(MdiIcons.fridgeIndustrial),
                label: 'Pantry',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_view),
                label: 'Manage',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.spa_outlined),
                label: 'Nutrition',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ]),
      ),
    );
  }
}
