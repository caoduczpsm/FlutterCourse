import 'package:buoi_4_bai_1/buoi06/extraTask/Todo.dart';
import 'package:flutter/material.dart';

class TodoTaskDetail extends StatelessWidget{
  const TodoTaskDetail({super.key});

  @override
  Widget build(BuildContext context){

    final data = ModalRoute.of(context)?.settings.arguments as Todo;

    const biggerFont = TextStyle(fontSize: 18);

    return Scaffold(
          appBar: AppBar(
            title: Text(data.title!, style: biggerFont,),
          ),
          body: Text(data.description!, style: biggerFont,),
    );
  }
}