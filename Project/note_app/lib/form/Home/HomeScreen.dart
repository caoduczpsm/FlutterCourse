
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: _MyHomeScreen());
  }
}

class _MyHomeScreen extends StatefulWidget {
  const _MyHomeScreen({Key? key}) : super(key: key);

  @override
  State<_MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<_MyHomeScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: const Text("Category Home"),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}