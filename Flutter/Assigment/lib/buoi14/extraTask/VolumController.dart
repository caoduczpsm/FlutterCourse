// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class VolumeEvent {}

class VolumeUp extends VolumeEvent {}

class VolumeDown extends VolumeEvent {}

class VolumeMute extends VolumeEvent {}

class _VolumeControllerBloc extends Bloc<VolumeEvent, int> {
  int tempVolumeMute = 0;
  _VolumeControllerBloc() : super(0) {
    on<VolumeUp>(((event, emit) =>
        state < 100 ? {emit(state + 5), tempVolumeMute = state} : emit(state)));
    on<VolumeDown>(((event, emit) =>
        state > 0 ? {emit(state - 5), tempVolumeMute = state} : emit(state)));
    on<VolumeMute>(
        ((event, emit) => state == 0 ? emit(tempVolumeMute) : emit(0)));
  }
}

class _VolumeControllerPage extends StatelessWidget {
  final String title;

  const _VolumeControllerPage({required this.title});

  @override
  Widget build(BuildContext context) {
    final volumeControllerBloc =
        BlocProvider.of<_VolumeControllerBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<_VolumeControllerBloc, int>(builder: (context, volume) {
              return Text(
                'Current volume value is $volume',
                style: const TextStyle(
                    fontSize: 30, fontWeight: FontWeight.normal),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      volumeControllerBloc.add(VolumeUp());
                    },
                    tooltip: 'VolumeUp',
                    child: const Icon(Icons.volume_up),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      volumeControllerBloc.add(VolumeDown());
                    },
                    tooltip: 'VolumeDown',
                    child: const Icon(Icons.volume_down),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      volumeControllerBloc.add(VolumeMute());
                    },
                    tooltip: 'VolumeMute',
                    child: const Icon(Icons.volume_mute),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

class VolumeStateManagement extends StatelessWidget {
  const VolumeStateManagement({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<_VolumeControllerBloc>(
        create: (context) => _VolumeControllerBloc(),
        child: const _VolumeControllerPage(
          title: " Volume State Management using Bloc",
        ),
      ),
    );
  }
}
