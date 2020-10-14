import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier {
  int _selectedCategoryId = 1;
  int get selectedCategoryId => _selectedCategoryId;
  set selectedCategoryId(int value) {
    _selectedCategoryId = value;
    notifyListeners();
  }

  /// selected category id...
  String _selectedCategoryName;
  String get selectedCategoryName => _selectedCategoryName;
  set selectedCategoryName(String value) {
    _selectedCategoryName = value;
    notifyListeners();
  }
}
