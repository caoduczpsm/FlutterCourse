
import 'package:buoi_4_bai_1/buoi04/pavlovaRecipe.dart';
import 'package:buoi_4_bai_1/buoi05/profile.dart';
import 'package:buoi_4_bai_1/buoi07/assignment/FavoriteApp.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget{
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>{

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    FavoriteApp(),
    PavlovaRecipe(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Pavlova Recipe',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}