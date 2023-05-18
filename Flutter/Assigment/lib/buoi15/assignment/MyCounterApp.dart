
import 'package:buoi_4_bai_1/buoi15/assignment/CounterCubit.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class MyCounterApp extends StatelessWidget {
  const MyCounterApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: _CounterPage(),
      ),
    );
  }

}

class _CounterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App using Cubit'),
      ),
      body: BlocBuilder<CounterCubit, int>(
        builder: (context, state) => Center(
          child: Text(
            '$state',
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.add),
              onPressed: () => context.read<CounterCubit>().increase()
          ),
          const SizedBox(height: 10,),
          FloatingActionButton(
              child: const Icon(Icons.remove),
              onPressed: () => context.read<CounterCubit>().decrease()
          ),
        ],
      ),
    );
  }


}