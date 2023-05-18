import 'package:flutter/cupertino.dart';

class MyChangeNotifier extends ChangeNotifier {
  late int field1;
  late String field2;

  void changeState() {
    field2 = 'New value';
    notifyListeners();
  }
}