// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class VolumeState {}

class LoadingVolumeState extends VolumeState {}

class SuccessVolumeState extends VolumeState {
  int volume = 0;
  SuccessVolumeState(this.volume);
}

abstract class VolumeEvent {}

class VolumeUp extends VolumeEvent {}

class VolumeDown extends VolumeEvent {}

class VolumeMute extends VolumeEvent {}

class _VolumeBloc extends Bloc<VolumeEvent, VolumeState> {
  int volume = 0;
  int tempVolume = 0;
  _VolumeBloc() : super(SuccessVolumeState(0)) {
    on<VolumeEvent>(((event, emit) {
      if (event is VolumeUp) {
        _onVolumeUp(event, emit);
      } else if (event is VolumeDown){
        _onVolumeDown(event, emit);
      } else {
        _onVolumeMute(event, emit);
      }
    }));
  }

  _onVolumeUp(VolumeEvent event, Emitter<VolumeState> emit) {
    emit(LoadingVolumeState());
    if(volume < 100) {
      volume += 5;
      tempVolume = volume;
    }
    emit(SuccessVolumeState(volume));
  }

  _onVolumeDown(VolumeEvent event, Emitter<VolumeState> emit) {
    emit(LoadingVolumeState());
    if(volume != 0) {
      volume -= 5;
      tempVolume = volume;
    }
    emit(SuccessVolumeState(volume));
  }

  _onVolumeMute(VolumeEvent event, Emitter<VolumeState> emit) {
    emit(LoadingVolumeState());
    if(volume != 0) {
      volume = 0;
    } else {
      volume = tempVolume;
    }
    emit(SuccessVolumeState(volume));
  }
}

class _VolumeControllerPage extends StatelessWidget {
  final String title;

  const _VolumeControllerPage({required this.title});

  @override
  Widget build(BuildContext context) {
    final volumeControllerBloc =
        BlocProvider.of<_VolumeBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<_VolumeBloc, VolumeState>(builder: (context, state) {
              if (state is SuccessVolumeState) {
                return Text(
                  'Current volume value is: ${state.volume}',
                  style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 25),
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
      home: BlocProvider<_VolumeBloc>(
        create: (context) => _VolumeBloc(),
        child: const _VolumeControllerPage(
          title: " Volume State Management using Bloc",
        ),
      ),
    );
  }
}
