import 'package:buoi_4_bai_1/buoi05/profile.dart';
import 'package:buoi_4_bai_1/buoi05/startup_namer.dart';
import 'package:flutter/material.dart';

class ExtraTasks extends StatelessWidget {
  const ExtraTasks({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Profile",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: const Center(
          child: Profile(),
        ),
      ),
    );
  }

}

