import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  /// register password & confirm password visibility
  bool _isRegisterPasswordVisible = true;

  bool get isRegisterPasswordVisible => _isRegisterPasswordVisible;

  set isRegisterPasswordVisible(bool value) {
    _isRegisterPasswordVisible = value;
    notifyListeners();
  }

  /// register Confirm password visibility..
  bool _isRegisterConfirmPasswordVisible = true;

  bool get isRegisterConfirmPasswordVisible =>
      _isRegisterConfirmPasswordVisible;

  set isRegisterConfirmPasswordVisible(bool value) {
    _isRegisterConfirmPasswordVisible = value;
    notifyListeners();
  }

  /// check for term & condition checked or not
  bool _isTermAndConditionAccepted = false;

  bool get isTermAndConditionAccepted => _isTermAndConditionAccepted;

  set isTermAndConditionAccepted(bool value) {
    _isTermAndConditionAccepted = value;
    notifyListeners();
  }

  /// select gender
  String _selectedGenderRegister = "Male";

  String get selectedGenderRegister => _selectedGenderRegister;

  set selectedGenderRegister(String value) {
    _selectedGenderRegister = value;
    notifyListeners();
  }

  /// register process indicator visibility
  bool _isRegisterInProcess = false;

  bool get isRegisterInProcess => _isRegisterInProcess;

  set isRegisterInProcess(bool value) {
    _isRegisterInProcess = value;
    notifyListeners();
  }

  /// store mobile verification provider.
  String _verificationMobileNumberForRegister;

  String get verificationMobileNumberForRegister =>
      _verificationMobileNumberForRegister;

  set verificationMobileNumberForRegister(String value) {
    _verificationMobileNumberForRegister = value;
    notifyListeners();
  }

  /// mobile number verification loader.
  bool _isMobileVerificationProcess = false;

  bool get isMobileVerificationProcess => _isMobileVerificationProcess;

  set isMobileVerificationProcess(bool value) {
    _isMobileVerificationProcess = value;
    notifyListeners();
  }

  /// mobile verification otp...
  String _mobileVerificationOTP;

  String get mobileVerificationOTP => _mobileVerificationOTP;

  set mobileVerificationOTP(String value) {
    _mobileVerificationOTP = value;
    notifyListeners();
  }

  /// OTP verification from register user page
  bool _isOTPVerificationPageFromRegisterUser = true;

  bool get isOTPVerificationPageFromRegisterUser =>
      _isOTPVerificationPageFromRegisterUser;

  set isOTPVerificationPageFromRegisterUser(bool value) {
    _isOTPVerificationPageFromRegisterUser = value;
    notifyListeners();
  }

  /// timer tick provider....
  int _timeRemainingInTimer = 0;

  int get timeRemainingInTimer => _timeRemainingInTimer;

  set timeRemainingInTimer(int value) {
    _timeRemainingInTimer = value;
    notifyListeners();
  }
}
