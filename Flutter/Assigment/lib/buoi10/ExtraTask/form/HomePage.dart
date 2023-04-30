import 'package:buoi_4_bai_1/buoi10/ExtraTask/model/account.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){

    final data = ModalRoute.of(context)?.settings.arguments as Account;

    const biggerFont = TextStyle(fontSize: 18);

    return Scaffold(
      appBar: AppBar(
        title: Text(data.userName!, style: biggerFont,),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Center(
          child: Column(
            children: [
              Text(data.email!, style: biggerFont,),
              Text(data.gender == 1 ? "Male" : "Female", style: biggerFont,),
            ],
          ),
        ),
      )
    );
  }
}