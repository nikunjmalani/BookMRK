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
}
