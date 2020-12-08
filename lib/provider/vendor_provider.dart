import 'package:flutter/cupertino.dart';

class VendorProvider extends ChangeNotifier {
  String _selectedVendorName;

  String get selectedVendorName => _selectedVendorName;

  set selectedVendorName(String value) {
    _selectedVendorName = value;
    notifyListeners();
  }

  /// vendorListToSearch
  List _vendorFilterList = [];

  List get vendorFilterList => _vendorFilterList;

  set vendorFilterList(List value) {
    _vendorFilterList = value;
    notifyListeners();
  }

  void vendorFilterListAddSingle(dynamic vendor) {
    _vendorFilterList.add(vendor);
    notifyListeners();
  }

  /// is VendorBar selected
  bool _isVendorBarSelected = false;
  bool get isVendorBarSelected => _isVendorBarSelected;
  set isVendorBarSelected(bool value) {
    _isVendorBarSelected = value;
    notifyListeners();
  }

  /// vendor custom scroll ...
  bool _isCustomScrollAtLimit = false;

  bool get isCustomScrollAtLimit => _isCustomScrollAtLimit;

  set isCustomScrollAtLimit(bool value) {
    _isCustomScrollAtLimit = value;
    notifyListeners();
  }

  set isCustomScrollAtLimitInit(bool value) {
    _isCustomScrollAtLimit = value;
  }

  /// scroll pixels...
  double _customScrollCurrentPixels = 0.0;

  double get customScrollCurrentPixels => _customScrollCurrentPixels;

  set customScrollCurrentPixels(double value) {
    _customScrollCurrentPixels = value;
    notifyListeners();
  }

  set customScrollCurrentPixelsInit(double value) {
    _customScrollCurrentPixels = value;
  }
}
