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

  bool _confirmedFlag = true;

  bool get confirmedFlag => _confirmedFlag;

  set confirmedFlag(bool value) {
    _confirmedFlag = value;
    notifyListeners();
  }

  bool _packedFlag = true;

  bool get packedFlag => _packedFlag;

  set packedFlag(bool value) {
    _packedFlag = value;
    notifyListeners();
  }

  bool _pickupFlag = true;

  bool get pickupFlag => _pickupFlag;

  set pickupFlag(bool value) {
    _pickupFlag = value;
    notifyListeners();
  }

  bool _inTransistFlag = true;

  bool get inTransistFlag => _inTransistFlag;

  set inTransistFlag(bool value) {
    _inTransistFlag = value;
    notifyListeners();
  }

  bool _outForDeliveryFlag = false;

  bool get outForDeliveryFlag => _outForDeliveryFlag;

  set outForDeliveryFlag(bool value) {
    _outForDeliveryFlag = value;
    notifyListeners();
  }

  bool _deliveredFlag = false;

  bool get deliveredFlag => _deliveredFlag;

  set deliveredFlag(bool value) {
    _deliveredFlag = value;
    notifyListeners();
  }
}
