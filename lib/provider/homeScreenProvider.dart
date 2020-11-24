import 'package:bookmrk/api/cart_api.dart';
import 'package:bookmrk/api/notification_api.dart';
import 'package:bookmrk/constant/constant.dart';
import 'package:bookmrk/model/notification_model.dart';
import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier {
  /// bell icon...
  bool _blueBellIcon = false;

  bool get blueBellIcon => _blueBellIcon;

  set blueBellIcon(bool value) {
    _blueBellIcon = value;
    notifyListeners();
  }

  /// blur cart icon...
  bool _blueCartIcon = false;

  bool get blueCartIcon => _blueCartIcon;

  set blueCartIcon(bool value) {
    _blueCartIcon = value;
    notifyListeners();
  }

  /// bottom selected index...
  int _selectedBottomIndex = 0;

  int get selectedBottomIndex => _selectedBottomIndex;

  set selectedBottomIndex(int value) {
    _selectedBottomIndex = value;
    notifyListeners();
  }

  /// selected main screen...
  String _selectedString = "Home";

  String get selectedString => _selectedString;

  set selectedString(String value) {
    _selectedString = value;
    notifyListeners();
  }

  /// vendor school index...
  int _vendorSchoolIndex = 0;

  int get vendorSchoolIndex => _vendorSchoolIndex;

  set vendorSchoolIndex(int value) {
    _vendorSchoolIndex = value;
    notifyListeners();
  }

  /// current past order index...
  int _currentPastOrderIndex = 0;

  int get currentPastOrderIndex => _currentPastOrderIndex;

  set currentPastOrderIndex(int value) {
    _currentPastOrderIndex = value;
    notifyListeners();
  }

  /// selected product slug
  String _selectedProductSlug;

  String get selectedProductSlug => _selectedProductSlug;

  set selectedProductSlug(String value) {
    _selectedProductSlug = value;
    notifyListeners();
  }

  bool _confirmedFlag = true;
  bool get confirmedFlag => _confirmedFlag;
  set confirmedFlag(bool value) {
    _confirmedFlag = value;
    notifyListeners();
  }

  bool _packedFlag = true;
  bool get packedFlag => _packedFlag;
  set packedFlag(bool value) {
    _packedFlag = value;
    notifyListeners();
  }

  bool _pickupFlag = true;
  bool get pickupFlag => _pickupFlag;
  set pickupFlag(bool value) {
    _pickupFlag = value;
    notifyListeners();
  }

  bool _inTransistFlag = true;
  bool get inTransistFlag => _inTransistFlag;
  set inTransistFlag(bool value) {
    _inTransistFlag = value;
    notifyListeners();
  }

  bool _outForDeliveryFlag = false;
  bool get outForDeliveryFlag => _outForDeliveryFlag;
  set outForDeliveryFlag(bool value) {
    _outForDeliveryFlag = value;
    notifyListeners();
  }

  bool _deliveredFlag = false;
  bool get deliveredFlag => _deliveredFlag;
  set deliveredFlag(bool value) {
    _deliveredFlag = value;
    notifyListeners();
  }

  /// find product name ...
  String _findHomeScreenProduct = "asa";

  String get findHomeScreenProduct => _findHomeScreenProduct;

  set findHomeScreenProduct(String value) {
    _findHomeScreenProduct = value;
    notifyListeners();
  }

  /// total Number of notifications ....
  int _totalNewNotifications = 0;

  int get totalNewNotifications => _totalNewNotifications;

  set totalNewNotifications(int value) {
    _totalNewNotifications = value;
    notifyListeners();
  }

  /// total number of orders in cart....
  int _totalNumberOfOrdersInCart = 0;

  int get totalNumberOfOrdersInCart => _totalNumberOfOrdersInCart;

  set totalNumberOfOrdersInCart(int value) {
    _totalNumberOfOrdersInCart = value;
    notifyListeners();
  }

  getCartCount() async {
    int counter  = 0;
    int userId = prefs.read<int>('userId');
    dynamic response = await CartAPI.getCartData(userId.toString());
    if(response['status'] == 200){
      response['response'][0]['cart'].forEach((cart){
        counter += int.parse(cart['qty']);
      });
    }
    _totalNumberOfOrdersInCart = counter;
  }

  getNotification() async {
    int userId = prefs.read<int>('userId');
    dynamic response =
        await NotificationAPI.getAllNotification(userId.toString());
    NotificationModel _notificationModel = NotificationModel.fromJson(response);
    int totalNotification = 0;
    _notificationModel.response.forEach((notification) {
      if (notification.isSeen == "0") {
        totalNotification++;
      }
    });
    _totalNewNotifications = totalNotification;
    notifyListeners();
  }

  /// provider for check when show dialog open or not,,,
  bool _homeScreenMainPopupShow = true;

  bool get homeScreenMainPopupShow => _homeScreenMainPopupShow;

  set homeScreenMainPopupShow(bool value) {
    _homeScreenMainPopupShow = value;
    notifyListeners();
  }

  /// notification mark all as read in progress...
  bool _markAllAsReadNotification = false;

  bool get markAllAsReadNotification => _markAllAsReadNotification;

  set markAllAsReadNotification(bool value) {
    _markAllAsReadNotification = value;
    notifyListeners();
  }

  /// page controller.....
  PageController _pageController = PageController(initialPage: 0);

  PageController get pageController => _pageController;

  set pageController(PageController value) {
    _pageController = value;
    notifyListeners();
  }

  /// selected title name....
  String _selectedTitle = "";

  String get selectedTitle => _selectedTitle;

  set selectedTitle(String value) {
    _selectedTitle = value;
    notifyListeners();
  }

  /// when do not showing map..
  bool _showMapInTrackingPage = true;

  bool get showMapInTrackingPage => _showMapInTrackingPage;

  set showMapInTrackingPage(bool value) {
    _showMapInTrackingPage = value;
    notifyListeners();
  }
}
