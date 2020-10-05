import 'package:flutter/material.dart';

class ResetPasswordProvider extends ChangeNotifier {
  /// password reset in progress indicator.
  bool _isPasswordResetInProcess = false;

  bool get isPasswordResetInProcess => _isPasswordResetInProcess;

  set isPasswordResetInProcess(bool value) {
    _isPasswordResetInProcess = value;
    notifyListeners();
  }

  /// password visibility.
  bool _isResetPasswordVisible = false;

  bool get isResetPasswordVisible => _isResetPasswordVisible;

  set isResetPasswordVisible(bool value) {
    _isResetPasswordVisible = value;
    notifyListeners();
  }
}
