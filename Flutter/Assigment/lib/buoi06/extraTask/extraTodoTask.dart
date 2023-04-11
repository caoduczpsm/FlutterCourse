import 'package:buoi_4_bai_1/buoi06/extraTask/Todo.dart';
import 'package:buoi_4_bai_1/buoi06/extraTask/TodoTaskDetail.dart';
import 'package:flutter/material.dart';

class ExtraTodoTask extends StatelessWidget{
  const ExtraTodoTask({super.key});

  @override
  Widget build(BuildContext context){

    List<Todo> todos = [];
    const biggerFont = TextStyle(fontSize: 18);
    for(int i = 0; i < 20; i++){
      Todo todo = Todo("Todo $i", "Description Todo $i");
      todos.add(todo);
    }

    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Extra Todo Task"),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  todos[index].title as String,
                  style: biggerFont,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TodoTaskDetail(),
                          settings: RouteSettings(arguments: todos[index])
                      )
                  );
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider();
            },
            itemCount: todos.length),
      )
    );
  }
}