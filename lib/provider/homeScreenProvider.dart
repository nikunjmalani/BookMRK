import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier {
  String _selectedString = "Home";
  int _selectedBottomIndex = 0;
  bool _blueBellIcon = false;

  bool get blueBellIcon => _blueBellIcon;

  set blueBellIcon(bool value) {
    _blueBellIcon = value;
    notifyListeners();
  }

  bool _blueCartIcon = false;

  bool get blueCartIcon => _blueCartIcon;

  set blueCartIcon(bool value) {
    _blueCartIcon = value;
    notifyListeners();
  }

  int get selectedBottomIndex => _selectedBottomIndex;

  set selectedBottomIndex(int value) {
    _selectedBottomIndex = value;
    notifyListeners();
  }

  String get selectedString => _selectedString;

  set selectedString(String value) {
    _selectedString = value;
    notifyListeners();
  }

  int _vendorSchoolIndex = 0;

  int get vendorSchoolIndex => _vendorSchoolIndex;

  set vendorSchoolIndex(int value) {
    _vendorSchoolIndex = value;
    notifyListeners();
  }

  int _currentPastOrderIndex = 0;

  int get currentPastOrderIndex => _currentPastOrderIndex;

  set currentPastOrderIndex(int value) {
    _currentPastOrderIndex = value;
    notifyListeners();
  }
}
