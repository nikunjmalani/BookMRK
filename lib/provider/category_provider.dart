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

  /// selected category list to filter....
  List _selectedFilterCategoryList = [];

  List get selectedFilterCategoryList => _selectedFilterCategoryList;

  set selectedFilterCategoryList(List value) {
    _selectedFilterCategoryList = value;
    notifyListeners();
  }

  void selectedFilterCategoryListAddSingle(String category) {
    _selectedFilterCategoryList.add(category);
    notifyListeners();
  }

  /// list of all category to filter...
  List _filterCategoryList = [];

  List get filterCategoryList => _filterCategoryList;

  set filterCategoryList(List value) {
    _filterCategoryList = value;
    notifyListeners();
  }

  void filterCategoryListAddSingle(dynamic value) {
    _filterCategoryList.add(value);
    notifyListeners();
  }
}
