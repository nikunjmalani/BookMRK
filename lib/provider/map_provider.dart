import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider extends ChangeNotifier {
  /// store the lat and lng of selected are...
  LatLng _selectedLatLng = LatLng(21.214603285574814, 72.88839161396027);

  LatLng get selectedLatLng => _selectedLatLng;

  set selectedLatLng(LatLng value) {
    _selectedLatLng = value;
    notifyListeners();
  }

  /// selected latlong for address add....
  LatLng _addressSelectedLatLng = LatLng(0.0, 0.0);

  LatLng get addressSelectedLatLng => _addressSelectedLatLng;

  set addressSelectedLatLng(LatLng value) {
    _addressSelectedLatLng = value;
    notifyListeners();
  }

  /// converted address from latlong for address line 1..
  String _addressLine1FromLatLng;

  String get addressLine1FromLatLng => _addressLine1FromLatLng;

  set addressLine1FromLatLng(String value) {
    _addressLine1FromLatLng = value;
    notifyListeners();
  }

  /// is lat long selected or not...
  bool _isLatLngSelected = false;

  bool get isLatLngSelected => _isLatLngSelected;

  set isLatLngSelected(bool value) {
    _isLatLngSelected = value;
    notifyListeners();
  }
}
