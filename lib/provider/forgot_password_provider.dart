import 'package:flutter/material.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  /// forgot password mobile number checking indicator.
  bool _isMobileNumberCheckingForgotPassword = false;

  bool get isMobileNumberCheckingForgotPassword =>
      _isMobileNumberCheckingForgotPassword;

  set isMobileNumberCheckingForgotPassword(bool value) {
    _isMobileNumberCheckingForgotPassword = value;
    notifyListeners();
  }

  /// store OTP to check
  String _forgotPasswordOTP;

  String get forgotPasswordOTP => _forgotPasswordOTP;

  set forgotPasswordOTP(String value) {
    _forgotPasswordOTP = value;
    notifyListeners();
  }

  /// store mobile number for verify otp
  String _forgotPasswordMobile;

  String get forgotPasswordMobile => _forgotPasswordMobile;

  set forgotPasswordMobile(String value) {
    _forgotPasswordMobile = value;
    notifyListeners();
  }

  /// verification in progress indicator visibility.
  bool _isOTPVerificationInProgress = false;

  bool get isOTPVerificationInProgress => _isOTPVerificationInProgress;

  set isOTPVerificationInProgress(bool value) {
    _isOTPVerificationInProgress = value;
    notifyListeners();
  }

  /// forgot password from which page ...
  String _forgotPasswordFromPage;

  String get forgotPasswordFromPage => _forgotPasswordFromPage;

  set forgotPasswordFromPage(String value) {
    _forgotPasswordFromPage = value;
    notifyListeners();
  }
}
