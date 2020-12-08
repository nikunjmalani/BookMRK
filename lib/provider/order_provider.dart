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

  /// expand view....
  List<bool> _orderTrackExpandList = [];

  List<bool> get orderTrackExpandList => _orderTrackExpandList;

  set orderTrackExpandList(List<bool> value) {
    _orderTrackExpandList = value;
    notifyListeners();
  }

  void orderTrackExpandListSingleUpdate(int index, bool value) {
    _orderTrackExpandList[index] = value;
    notifyListeners();
  }

  /// is address selected in cart ....
  bool _isAddressSelectedInCart = true;

  bool get isAddressSelectedInCart => _isAddressSelectedInCart;

  set isAddressSelectedInCart(bool value) {
    _isAddressSelectedInCart = value;
    notifyListeners();
  }

  set isAddressSelectedInCartInit(bool value) {
    _isAddressSelectedInCart = value;
  }
}
