import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  /// add New address in user address visibility ..
  bool _isAddAddressInProcess = false;

  bool get isAddAddressInProcess => _isAddAddressInProcess;

  set isAddAddressInProcess(bool value) {
    _isAddAddressInProcess = value;
    notifyListeners();
  }

  /// user address edit in progress ...
  bool _userAddressEditInProgress = false;

  bool get userAddressEditInProgress => _userAddressEditInProgress;

  set userAddressEditInProgress(bool value) {
    _userAddressEditInProgress = value;
    notifyListeners();
  }

  /// selected userAddressId
  String _selectedUserAddressId;

  String get selectedUserAddressId => _selectedUserAddressId;

  set selectedUserAddressId(String value) {
    _selectedUserAddressId = value;
    notifyListeners();
  }

  /// changing default address in progress
  bool _changeAddressInProgress = false;

  bool get changeAddressInProgress => _changeAddressInProgress;

  set changeAddressInProgress(bool value) {
    _changeAddressInProgress = value;
    notifyListeners();
  }

  /// user mobile number to send otp...
  String _mobileNumberToSendOtp;

  String get mobileNumberToSendOtp => _mobileNumberToSendOtp;

  set mobileNumberToSendOtp(String value) {
    _mobileNumberToSendOtp = value;
    notifyListeners();
  }

  /// feedback in process ...
  bool _feedbackInProgress = false;

  bool get feedbackInProgress => _feedbackInProgress;

  set feedbackInProgress(bool value) {
    _feedbackInProgress = value;
    notifyListeners();
  }

  /// profile update in progress ...
  bool _isProfileUpdateInProgress = false;
  bool get isProfileUpdateInProgress => _isProfileUpdateInProgress;
  set isProfileUpdateInProgress(bool value) {
    _isProfileUpdateInProgress = value;
    notifyListeners();
  }

  /// mobile number change otp from profile page ...
  dynamic _otpForMobileChange;
  dynamic get otpForMobileChange => _otpForMobileChange;
  set otpForMobileChange(dynamic value) {
    _otpForMobileChange = value;
    notifyListeners();
  }

  /// otp sending progress ...
  bool _isOtpSendingInProgress = false;
  bool get isOtpSendingInProgress => _isOtpSendingInProgress;
  set isOtpSendingInProgress(bool value) {
    _isOtpSendingInProgress = value;
    notifyListeners();
  }

  /// otp verifying in progress ....
  bool _isOtpVerifyingInProgress = false;
  bool get isOtpVerifyingInProgress => _isOtpVerifyingInProgress;
  set isOtpVerifyingInProgress(bool value) {
    _isOtpVerifyingInProgress = value;
    notifyListeners();
  }

  /// mobile number to change ...
  String _mobileNumberToChange;
  String get mobileNumberToChange => _mobileNumberToChange;
  set mobileNumberToChange(String value) {
    _mobileNumberToChange = value;
    notifyListeners();
  }
}
