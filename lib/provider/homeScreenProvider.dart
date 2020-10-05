import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier {
  String _selectedString = "Home";

  String get selectedString => _selectedString;

  set selectedString(String value) {
    _selectedString = value;
    notifyListeners();
  }
}
