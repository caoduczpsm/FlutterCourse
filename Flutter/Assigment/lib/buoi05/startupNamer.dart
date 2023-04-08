import 'package:buoi_4_bai_1/buoi05/startup_namer.dart';
import 'package:flutter/material.dart';

class StartupNamer extends StatelessWidget {
  const StartupNamer({super.key});
  
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Welcome to Flutter",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Welcome to Flutter"),
        ),
        body: const Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}