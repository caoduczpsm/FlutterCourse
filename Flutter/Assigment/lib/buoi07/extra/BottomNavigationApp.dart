import 'package:buoi_4_bai_1/buoi07/assignment/FavoriteWidget.dart';
import 'package:buoi_4_bai_1/buoi07/extra/BottomNavigation.dart';
import 'package:flutter/material.dart';

class BottomNavigationApp extends StatelessWidget{
  const BottomNavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter layout demo",
      home: buildHomePage(),
    );
  }

  Widget buildHomePage(){
    return const Scaffold(
      body: BottomNavigation(),
    );
  }
}