import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  /// login password eye ~ visibility
  bool _isPasswordVisible = true;

  bool get isPasswordVisible => _isPasswordVisible;

  set isPasswordVisible(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }

  /// password checking process loader visibility
  bool _isPasswordChecking = false;

  bool get isPasswordChecking => _isPasswordChecking;

  set isPasswordChecking(bool value) {
    _isPasswordChecking = value;
    notifyListeners();
  }
}
