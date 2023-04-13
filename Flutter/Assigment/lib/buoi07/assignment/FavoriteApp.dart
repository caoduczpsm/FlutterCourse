
import 'package:buoi_4_bai_1/buoi07/assignment/FavoriteWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoriteApp extends StatelessWidget{
  const FavoriteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter layout demo",
      home: buildHomePage(),
    );
  }

  Widget buildHomePage(){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite App"),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: const FavoriteWidget(),
      ),
    );
  }

}