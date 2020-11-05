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

  /// school grade category selected index ...
  int _selectedSchoolCategoryIndex = 0;

  int get selectedSchoolCategoryIndex => _selectedSchoolCategoryIndex;

  set selectedSchoolCategoryIndex(int value) {
    _selectedSchoolCategoryIndex = value;
    notifyListeners();
  }

  /// search school by location selected....
  bool _isFindSchoolByLocationSelected = false;

  bool get isFindSchoolByLocationSelected => _isFindSchoolByLocationSelected;

  set isFindSchoolByLocationSelected(bool value) {
    _isFindSchoolByLocationSelected = value;
    notifyListeners();
  }

  /// selected school country index...
  int _selectedCountryIndexForSchool = 0;

  int get selectedCountryIndexForSchool => _selectedCountryIndexForSchool;

  set selectedCountryIndexForSchool(int value) {
    _selectedCountryIndexForSchool = value;
    notifyListeners();
  }

  /// selected school country id ....
  int _selectedCountryIdForSchool;

  int get selectedCountryIdForSchool => _selectedCountryIdForSchool;

  set selectedCountryIdForSchool(int value) {
    _selectedCountryIdForSchool = value;
    notifyListeners();
  }

  /// selected school state index...
  int _selectedStateIndexForSchool = 0;

  int get selectedStateIndexForSchool => _selectedStateIndexForSchool;

  set selectedStateIndexForSchool(int value) {
    _selectedStateIndexForSchool = value;
    notifyListeners();
  }


  /// selected school state id .....
  int _selectedStateIdForSchool;

  int get selectedStateIdForSchool => _selectedStateIdForSchool;

  set selectedStateIdForSchool(int value) {
    _selectedStateIdForSchool = value;
    notifyListeners();
  }

  /// selected school city index....
  int _selectedCityIndexForSchool = 0;

  int get selectedCityIndexForSchool => _selectedCityIndexForSchool;

  set selectedCityIndexForSchool(int value) {
    _selectedCityIndexForSchool = value;
    notifyListeners();
  }

  /// selected school city id....
  int _selectedCityIdForSchool;

  int get selectedCityIdForSchool => _selectedCityIdForSchool;

  set selectedCityIdForSchool(int value) {
    _selectedCityIdForSchool = value;
    notifyListeners();
  }

  /// selected school pincode .....
  String _selectedPinCodeForSchool;

  String get selectedPinCodeForSchool => _selectedPinCodeForSchool;

  set selectedPinCodeForSchool(String value) {
    _selectedPinCodeForSchool = value;
    notifyListeners();
  }
}
