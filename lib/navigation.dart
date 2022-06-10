import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mealthy/discovery.dart';
import 'package:mealthy/nutrition.dart';


class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;

  final List<Widget> _bottomBarScreens = <Widget>[
    const Discovery(),
    const Nutrition(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        child: _bottomBarScreens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavBar(
        onTap: _bottomNavIconOnTap,
        index: _selectedIndex,
      ),
    );
  }

  _bottomNavIconOnTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class BottomNavBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;

  BottomNavBar({Key? key, required this.onTap, required this.index})
      : super(key: key);

  final List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      activeIcon: ActiveNavBarIcon(
        icon: Icons.restaurant,
      ),
      icon: Icon(Icons.restaurant),
      label: 'Discovery',
      backgroundColor: Color(0xFFFFB300),
    ),
    const BottomNavigationBarItem(
      activeIcon: ActiveNavBarIcon(
        icon: MdiIcons.fridgeIndustrial,
      ),
      icon: Icon(MdiIcons.fridgeIndustrial),
      label: 'Pantry',
      backgroundColor: Color(0xFFFFB300),
    ),
    const BottomNavigationBarItem(
      activeIcon: ActiveNavBarIcon(
        icon: Icons.grid_view,
      ),
      icon: Icon(Icons.grid_view),
      label: 'Management',
      backgroundColor: Color(0xFFFFB300),
    ),
    const BottomNavigationBarItem(
      activeIcon: ActiveNavBarIcon(
        icon: Icons.spa_outlined,
      ),
      icon: Icon(Icons.spa_outlined),
      label: 'Nutrition',
      backgroundColor: Color(0xFFFFB300),
    ),
    const BottomNavigationBarItem(
      activeIcon: ActiveNavBarIcon(
        icon: Icons.person_outline,
      ),
      icon: Icon(Icons.person_outline),
      label: 'Profile',
      backgroundColor: Color(0xFFFFB300),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: items,
      unselectedItemColor: Colors.white,
      showUnselectedLabels: true,
      selectedItemColor: Colors.red,
      showSelectedLabels: false,
      currentIndex: index,
      onTap: onTap,
    );
  }
}

class ActiveNavBarIcon extends StatelessWidget {
  final IconData icon;
  const ActiveNavBarIcon({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(
          height: 1,
        ),
      ],
    );
  }
}

