import 'package:flutter/material.dart';

import 'package:vita/Screen/Main.dart';

class BottomNavigationBars extends StatefulWidget {
  @override
  _BottomNavigationBarsState createState() => _BottomNavigationBarsState();
}

class _BottomNavigationBarsState extends State<BottomNavigationBars> {

  void _onItemTapped(int index) {
    MainScreenState? parentState = context.findAncestorStateOfType<MainScreenState>();
    if (parentState == null) return ;
    parentState.setState(() {
      parentState.selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    MainScreenState? parentState = context.findAncestorStateOfType<MainScreenState>();

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Medicine',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Chatting',
        ),
      ],
      currentIndex: parentState == null ? 0 : parentState.selectedIndex,
      selectedItemColor: Colors.blue,
      onTap: _onItemTapped,
    );
  }
}
