import 'package:buoi_4_bai_1/buoi16/assignment/ProfileData.dart';
import 'package:buoi_4_bai_1/buoi16/assignment/profile_responsitory.dart';
import 'package:buoi_4_bai_1/buoi16/assignment/profile_state.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState>{
  final ProfileRepository _repository;

  ProfileCubit(this._repository) : super(InitialProfileState());

  Future<void> getAllProfiles() async {
    emit(LoadingProfileState());
    try {
      var result = await _repository.getAllProfiles();
      emit(SuccessLoadAllProfileState(result));
    } catch (e) {
      emit(FailureProfileState(e.toString()));
    }
  }

  Future<void> createProfile(ProfileData profileData) async {
    emit(LoadingProfileState());
    try {
      var result = await _repository.createProfile(profileData);
      emit(SuccessSubmitProfileState(result));
    } catch (e) {
      emit(FailureProfileState(e.toString()));
    }
  }

  Future<void> updateProfile(ProfileData profileData) async {
    emit(LoadingProfileState());
    try {
      var result = await _repository.updateProfile(profileData);
      emit(SuccessSubmitProfileState(result));
    } catch (e) {
      emit(FailureProfileState(e.toString()));
    }
  }

  Future<void> deleteProfile(String id) async {
    emit(LoadingProfileState());
    try {
      var result = await _repository.deleteById(id);
      emit(SuccessSubmitProfileState(result));
    } catch (e) {
      emit(FailureProfileState(e.toString()));
    }
  }

}