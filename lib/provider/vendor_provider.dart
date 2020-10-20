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
}
