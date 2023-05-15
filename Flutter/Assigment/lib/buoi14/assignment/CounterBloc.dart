// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class CounterEvent {}

class Increment extends CounterEvent {}

class _CounterBloc extends Bloc<CounterEvent, int> {
  _CounterBloc() : super(0) {
    on<Increment>(((event, emit) => emit(state + 1)));
  }
}

class _CounterPage extends StatelessWidget {
  final String title;

  const _CounterPage({required this.title});

  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<_CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<_CounterBloc, int>(builder: (context, count) {
              return Text(
                '$count',
                style: Theme.of(context).textTheme.headline1,
              );
            })
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: FloatingActionButton(
              onPressed: () {
                counterBloc.add(Increment());
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}

class StateManagement extends StatelessWidget {
  const StateManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<_CounterBloc>(
        create: (context) => _CounterBloc(),
        child: const _CounterPage(title: "State Management using Bloc",),
      ),
    );
  }

}
