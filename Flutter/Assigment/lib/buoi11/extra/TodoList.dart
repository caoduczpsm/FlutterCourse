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
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  late Future<Todo> futureTodo;
  late Future<List<Todo>> todoList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todoList = fetchTodo();
  }

  List<Todo> parseTodos(String response) {
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
    return parsed.map<Todo>((json) => Todo.fromJson(json)).toList();
  }

  Future<List<Todo>> fetchTodo() async {
    const url = "https://60db1a79801dcb0017290e61.mockapi.io/todos";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return parseTodos(response.body);
    } else {
      throw Exception('Failed to load Todo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      body: Center(
        child: FutureBuilder(
          future: todoList,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Retrieve Failed");
            } else if (snapshot.hasData) {
              final todos = snapshot.data as List<Todo>;
              return Container(
                margin: const EdgeInsets.only(top: 10),
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: SizedBox(
                            child: Center(
                          child: Card(
                            elevation: 2,
                            shadowColor: Colors.grey,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            margin: EdgeInsets.zero,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.blueAccent,
                                    child: Text("${todos[index].id}"),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${todos[index].title}",
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                        Text(
                                          "${todos[index].description}",
                                          style: const TextStyle(
                                              fontSize: 18, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        Container(height: 0, color: Colors.grey),
                    itemCount: todos.length),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
