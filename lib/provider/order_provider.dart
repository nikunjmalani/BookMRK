import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderProvider extends ChangeNotifier {
  /// store the orderId of the selected order from the history...
  String _orderId;

  String get orderId => _orderId;

  set orderId(String value) {
    _orderId = value;
    notifyListeners();
  }

  /// orderId to track order.....
  String _orderIdToTrack;

  String get orderIdToTrack => _orderIdToTrack;

  set orderIdToTrack(String value) {
    _orderIdToTrack = value;
    notifyListeners();
  }

  /// user address latlng to deliver ....
  LatLng _userDeliveryAddress;

  LatLng get userDeliveryAddress => _userDeliveryAddress;

  set userDeliveryAddress(LatLng value) {
    _userDeliveryAddress = value;
    notifyListeners();
  }
}
