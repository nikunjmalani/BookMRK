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
}
