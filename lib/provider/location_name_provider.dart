import 'package:flutter/cupertino.dart';

class LocationProvider extends ChangeNotifier {
  /// selected country id...
  int _selectedCountryId;

  int get selectedCountryId => _selectedCountryId;

  set selectedCountryId(int value) {
    _selectedCountryId = value;
    notifyListeners();
  }

  set selectedCountryIdInit(int value) {
    _selectedCountryId = value;
  }

  /// selected country name ..
  String _selectedCountryName = "";

  String get selectedCountryName => _selectedCountryName;

  set selectedCountryName(String value) {
    _selectedCountryName = value;
    notifyListeners();
  }

  set selectedCountryNameInit(String value) {
    _selectedCountryName = value;
  }

  /// selected state id...
  int _selectedStateId;

  int get selectedStateId => _selectedStateId;

  set selectedStateId(int value) {
    _selectedStateId = value;
    notifyListeners();
  }

  set selectedStateIdInit(int value) {
    _selectedStateId = value;
  }

  /// selected state name...
  String _selectedStateName = "Select State";

  String get selectedStateName => _selectedStateName;

  set selectedStateName(String value) {
    _selectedStateName = value;
    notifyListeners();
  }

  set selectedStateNameInit(String value) {
    _selectedStateName = value;
  }

  /// selected city id...
  int _selectedCityId;

  int get selectedCityId => _selectedCityId;

  set selectedCityId(int value) {
    _selectedCityId = value;
    notifyListeners();
  }

  set selectedCityIdInit(int value) {
    _selectedCityId = value;
  }

  /// selected city name ...
  String _selectedCityName = "Select City";

  String get selectedCityName => _selectedCityName;

  set selectedCityName(String value) {
    _selectedCityName = value;
    notifyListeners();
  }

  set selectedCityNameInit(String value) {
    _selectedCityName = value;
  }

  /// true when any location sheet is open...
  bool _isLocationSheetOpen = false;

  bool get isLocationSheetOpen => _isLocationSheetOpen;

  set isLocationSheetOpen(bool value) {
    _isLocationSheetOpen = value;
    notifyListeners();
  }

  /// true when location selected from map...
  bool _isLocationSelectedFromMap = false;

  bool get isLocationSelectedFromMap => _isLocationSelectedFromMap;

  set isLocationSelectedFromMap(bool value) {
    _isLocationSelectedFromMap = value;
    notifyListeners();
  }

  set isLocationSelectedFromMapInit(bool value) {
    _isLocationSelectedFromMap = value;
  }
}
