// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_management_system_api/logic/states/drawer_state.dart';
import 'package:note_management_system_api/ultilities/Constant.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';
import '../../forms/category_status_priority/category_screen.dart';
import '../../forms/category_status_priority/priority_screen.dart';
import '../../forms/category_status_priority/status_screen.dart';
import '../../forms/dashboard_page/item.dart';
import '../../forms/edit_profile_change_password/change_password_screen.dart';
import '../../forms/edit_profile_change_password/edit_profile_screen.dart';
import '../../forms/note/note_screen.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerState(index: 0));

  final List<Widget> pages = [
    const Center(child: HomeScreen()),
    const Center(child: NoteScreen()),
    const Center(child: CategoryScreen()),
    const Center(child: PriorityScreen()),
    const Center(child: StatusScreen()),
    const Center(child: EditProfileScreen()),
    const Center(child: ChangePasswordScreen()),
  ];

  late bool switchStatus;

  final List<String> titlesEN = [
    "Note Management System",
    "Note Screen",
    "Category Screen",
    "Priority Screen",
    "Status Screen",
    "Edit Profile Screen",
    "Change Password Screen",
  ];

  final List<String> titlesVI = [
    "Trang chủ",
    "Ghi chú",
    "Danh mục",
    "Độ ưu tiên",
    "Trạng thái",
    "Thay đổi thông tin",
    "Đổi mật khẩu",
  ];

  Widget? currentPage = const HomeScreen();
  String? currentTitle = "";
  late SharedPreferences preferences;

  Future<void> selectIndex(int index) async {
    emit(DrawerState(index: index, switchStatus: state.switchStatus));
    if (preferences.getString(Constant.KEY_LANGUAGE) ==
        Constant.KEY_VIETNAMESE) {
      currentTitle = titlesVI[index];
    } else {
      currentTitle = titlesEN[index];
    }
    currentPage = pages[index];
  }

  Future<void> onSwitchListener(bool isOn) async {
    switchStatus = isOn;
    preferences = await SharedPreferences.getInstance();
    if (isOn) {
      emit(DrawerState(index: state.index, switchStatus: isOn));
      preferences.remove(Constant.KEY_LANGUAGE);
      preferences.setString(Constant.KEY_LANGUAGE, Constant.KEY_VIETNAMESE);
    } else {
      emit(DrawerState(index: state.index, switchStatus: isOn));
      preferences.remove(Constant.KEY_LANGUAGE);
      preferences.setString(Constant.KEY_LANGUAGE, Constant.KEY_ENGLISH);
    }
  }

  Future<SharedPreferences> initSharePreference() async {
    preferences = await SharedPreferences.getInstance();
    if(preferences.getString(Constant.KEY_LANGUAGE) == Constant.KEY_VIETNAMESE) {
      currentTitle = titlesVI[0];
    } else {
      currentTitle = titlesEN[0];
    }
    return preferences;
  }

  bool initLanguage(SharedPreferences preferences) {
    if(preferences.getString(Constant.KEY_LANGUAGE) == Constant.KEY_VIETNAMESE) {
      return true;
    } else {
      return false;
    }
  }

  String? getEmail(SharedPreferences preferences) {
    return preferences.getString(Constant.KEY_EMAIL);
  }

  String? getFirstName(SharedPreferences preferences) {
    return preferences.getString(Constant.KEY_FIRST_NAME);
  }

  String? getLastName(SharedPreferences preferences) {
    return preferences.getString(Constant.KEY_LAST_NAME);
  }

  bool getIsGmail(SharedPreferences preferences) {
    return preferences.getBool(Constant.KEY_IS_GMAIL)!;
  }

  String getFullName(SharedPreferences preferences) {
    String? firstName = preferences.getString(Constant.KEY_FIRST_NAME);
    String? lastName = preferences.getString(Constant.KEY_LAST_NAME);
    if (firstName!.contains(RegExp(r'[a-zA-Z]')) && lastName!.contains(RegExp(r'[a-zA-Z]'))) {
      return "$lastName $firstName";
    } else {
      return "Group 1";
    }
  }

  String getPassword(SharedPreferences preferences) {
    return preferences.getString(Constant.KEY_PASSWORD)!;
  }

  bool getSwitchStatus() {
    return switchStatus;
  }

  String? getCurrentTitle() {
    return currentTitle;
  }

  Widget? getCurrentPages() {
    return currentPage;
  }
}
