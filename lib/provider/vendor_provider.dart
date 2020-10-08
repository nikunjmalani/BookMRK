import 'package:flutter/cupertino.dart';

class VendorProvider extends ChangeNotifier {
  String _selectedVendorName;

  String get selectedVendorName => _selectedVendorName;

  set selectedVendorName(String value) {
    _selectedVendorName = value;
    notifyListeners();
  }
}
