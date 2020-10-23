import 'package:flutter/cupertino.dart';

class SchoolProvider extends ChangeNotifier {
  String _selectedSchoolSlug;

  String get selectedSchoolSlug => _selectedSchoolSlug;

  set selectedSchoolSlug(String value) {
    _selectedSchoolSlug = value;
    notifyListeners();
  }

  /// total Schools list....
  List _schoolsToFilter = [];

  List get schoolsToFilter => _schoolsToFilter;

  set schoolsToFilter(List value) {
    _schoolsToFilter = value;
    notifyListeners();
  }

  void schoolsToFilterAddSingleSchool(dynamic school) {
    _schoolsToFilter.add(school);
    notifyListeners();
  }

  /// when search school
  bool _isSearchSchoolTabSelected = false;

  bool get isSearchSchoolTabSelected => _isSearchSchoolTabSelected;

  set isSearchSchoolTabSelected(bool value) {
    _isSearchSchoolTabSelected = value;
    notifyListeners();
  }

  /// selected type in school info page....
  String _selectedSchoolProductType = "All";

  String get selectedSchoolProductType => _selectedSchoolProductType;

  set selectedSchoolProductType(String value) {
    _selectedSchoolProductType = value;
    notifyListeners();
  }

  /// selected subcategory id in the school info page...
  String _selectedSubCategoryId;

  String get selectedSubCategoryId => _selectedSubCategoryId;

  set selectedSubCategoryId(String value) {
    _selectedSubCategoryId = value;
    notifyListeners();
  }

  /// fetching data from subcategory in progress....
  bool _fetchingDataFromSubcategoryInProgress = false;

  bool get fetchingDataFromSubcategoryInProgress =>
      _fetchingDataFromSubcategoryInProgress;

  set fetchingDataFromSubcategoryInProgress(bool value) {
    _fetchingDataFromSubcategoryInProgress = value;
    notifyListeners();
  }
}
