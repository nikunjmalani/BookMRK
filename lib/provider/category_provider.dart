import 'package:flutter/cupertino.dart';

class CategoryProvider extends ChangeNotifier {
  /// selected category name...
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

  /// selected subCategory Name.....
  String _selectedSubCategory;

  String get selectedSubCategory => _selectedSubCategory;

  set selectedSubCategory(String value) {
    _selectedSubCategory = value;
    notifyListeners();
  }

  set selectedSubCategoryInit(String value) {
    _selectedSubCategory = value;
  }

  /// selected subcategory id....
  int _selectedSubCategoryId;

  int get selectedSubCategoryId => _selectedSubCategoryId;

  set selectedSubCategoryId(int value) {
    _selectedSubCategoryId = value;
    notifyListeners();
  }

  /// number of proudct...
  int _totalCategoryProduct = 0;

  int get totalCategoryProduct => _totalCategoryProduct;

  set totalCategoryProduct(int value) {
    _totalCategoryProduct = value;
    notifyListeners();
  }

  set totalCategoryProductInit(int value) {
    _totalCategoryProduct = value;
  }

  /// selected category name....
  String _selectedCategoryNameToShow;

  String get selectedCategoryNameToShow => _selectedCategoryNameToShow;

  set selectedCategoryNameToShow(String value) {
    _selectedCategoryNameToShow = value;
    notifyListeners();
  }

  set selectedCategoryNameToShowInit(String value) {
    _selectedCategoryNameToShow = value;
  }
}
