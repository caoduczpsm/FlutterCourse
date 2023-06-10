import 'package:buoi_4_bai_1/buoi16/assignment/ProfileData.dart';

abstract class ProfileState{}

class InitialProfileState extends ProfileState{}

class LoadingProfileState extends ProfileState{}

class FailureProfileState extends ProfileState{
  final String errorMessage;
  FailureProfileState(this.errorMessage);
}

class SuccessLoadAllProfileState extends ProfileState{
  final List<ProfileData> listProfiles;
  SuccessLoadAllProfileState(this.listProfiles);
}

class SuccessSubmitProfileState extends ProfileState{
  final ProfileData profileData;
  SuccessSubmitProfileState(this.profileData);
}