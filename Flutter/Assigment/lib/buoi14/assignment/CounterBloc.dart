// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterState {}

class LoadingCounterState extends CounterState {}

class SuccessCounterState extends CounterState {
  int count = 0;
  SuccessCounterState(this.count);
}

class CounterEvent {}

class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}

class _CounterBloc extends Bloc<CounterEvent, CounterState> {
  int count = 0;

  _CounterBloc() : super(SuccessCounterState(0)) {
    on<CounterEvent>(((event, emit) {
      if (event is Increment) {
        _onIncrement(event, emit);
      } else {
        _onDecrement(event, emit);
      }
    }));
  }

  _onIncrement(CounterEvent event, Emitter<CounterState> emit) {
    emit(LoadingCounterState());
    count++;
    emit(SuccessCounterState(count));
  }

  _onDecrement(CounterEvent event, Emitter<CounterState> emit) {
    emit(LoadingCounterState());
    count--;
    emit(SuccessCounterState(count));
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
            BlocBuilder<_CounterBloc, CounterState>(builder: (context, state) {
              if (state is SuccessCounterState) {
                return Text(
                  '${state.count}',
                  style: Theme.of(context).textTheme.displayMedium,
                );
              } else {
                return const CircularProgressIndicator();
              }
            })
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      counterBloc.add(Increment());
                    },
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      counterBloc.add(Decrement());
                    },
                    tooltip: 'Decrement',
                    child: const Icon(Icons.exposure_minus_1),
                  ),
                ],
              ))
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
        child: const _CounterPage(
          title: " State Management using Bloc",
        ),
      ),
    );
  }
}
