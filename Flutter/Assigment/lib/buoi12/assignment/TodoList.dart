import 'dart:convert';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../../buoi11/assignment/todo.dart';
import 'AddTodoPage.dart';

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData.dark(),
      home: const _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget{
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  late Future<List<Todo>> futureTodos;

  @override
  void initState() {
    super.initState();
    futureTodos = fetchTodos();
  }

  List<Todo> parseTodos(String response){
    final parsed = jsonDecode(response).cast<Map<String, dynamic>>();
    return parsed.map<Todo>((json) => Todo.fromJson(json)).toList();
  }

  Future<List<Todo>> fetchTodos() async {
    const url = "https://60db1a79801dcb0017290e61.mockapi.io/todos";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if(response.statusCode == 200) {
      return parseTodos(response.body);
    } else {
      throw Exception("Failed to load Todo");
    }
  }

  Future<void> _refreshTodos() async {
    final result = fetchTodos();
    setState(() {
      futureTodos = result;
    });
  }

  Future<void> navigateToAddPage(Todo? todo) async {
    final route = MaterialPageRoute(
        builder: (context) => AddTodoPage(
          todo: todo,
        )
    );

    await Navigator.push(context, route);
    _refreshTodos();
  }

  Future<void> deleteById(String id) async {
    final url = "https://60db1a79801dcb0017290e61.mockapi.io/todos/${id}";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    if(response.statusCode == 200){
      _refreshTodos();
      showMessage("Deletion Success");
    } else {
      showMessage("Deletion Failed");
    }
  }

  void showMessage(String message){
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo List"),
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: _refreshTodos,
          child: FutureBuilder(
            future: futureTodos,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Retrieve Failed ${snapshot.error}");
              } else if (snapshot.hasData) {
                final List<Todo> todos = snapshot.data!;
                return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) => Card(
                    child: (ListTile(
                      leading: CircleAvatar(child: Text("${index + 1}")),
                      title: Text("${todos[index].title}"),
                      subtitle: Text("${todos[index].description}"),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () =>
                                    navigateToAddPage(todos[index]),
                                icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () =>
                                  deleteById(todos[index].id!),
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    )),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () => navigateToAddPage(null),
          label: const Text("Add Todo"),
      ),
    );
  }

}