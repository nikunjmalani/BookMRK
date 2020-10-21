import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  /// store the orderId of the selected order from the history...
  String _orderId;
  String get orderId => _orderId;
  set orderId(String value) {
    _orderId = value;
    notifyListeners();
  }
}
