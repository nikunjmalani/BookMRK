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
}
