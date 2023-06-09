
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app_api/logic/states/note_state.dart';

import '../repositories/note_repository.dart';

class NoteCubit extends Cubit<NoteState>{
  final NoteRepository _repository;

  NoteCubit(this._repository) : super(InitialNoteState());

  Future<void> getAllProfiles() async {
    emit(LoadingNoteState());
    try {
      var result = await _repository.getAllNotes();
      emit(SuccessLoadAllNoteState(result));
    } catch (e) {
      emit(FailureNoteState(e.toString()));
    }
  }
}