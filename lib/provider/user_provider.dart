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
}
