import 'dart:convert';
import 'package:buoi_4_bai_1/buoi11/assignment/todo.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _HomePage(),
    );
  }

}

class _HomePage extends StatefulWidget {
  const _HomePage({super.key});

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  late Future<Todo> futureTodo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureTodo = fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      body: Center(
        child: FutureBuilder(
          future: futureTodo,
          builder: (context, snapshot) {
            if(snapshot.hasError) {
              return const Text("Retrieve Failed");
            } else if (snapshot.hasData) {
              final todo = snapshot.data as Todo;
              return Text(
                "${todo.title}",
                style: Theme.of(context).textTheme.headline3,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Future<Todo> fetchTodo() async {
    const url = "https://60db1a79801dcb0017290e61.mockapi.io/todos";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if(response.statusCode == 200) {
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Todo');
    }
  }
}