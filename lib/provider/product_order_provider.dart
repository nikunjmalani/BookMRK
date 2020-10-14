import 'package:flutter/cupertino.dart';

class ProductOrderProvider extends ChangeNotifier {
  /// selected variations 2..
  String _selectedVariation2Option;

  String get selectedVariation2Option => _selectedVariation2Option;

  set selectedVariation2Option(String value) {
    _selectedVariation2Option = value;
    notifyListeners();
  }

  /// selected variations 1..
  String _selectedVariation1Name;

  String get selectedVariation1Name => _selectedVariation1Name;

  set selectedVariation1Name(String value) {
    _selectedVariation1Name = value;
    notifyListeners();
  }
}
