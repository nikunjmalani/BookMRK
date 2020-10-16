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
}
