import 'package:flutter/cupertino.dart';

class ProductOrderProvider extends ChangeNotifier {
  /// selected variation 2 index....
  int _selectedVariation2Index = 0;

  int get selectedVariation2Index => _selectedVariation2Index;

  set selectedVariation2Index(int value) {
    _selectedVariation2Index = value;
    notifyListeners();
  }

  /// selected variations 2 option name.....
  String _selectedVariation2Option;

  String get selectedVariation2Option => _selectedVariation2Option;

  set selectedVariation2Option(String value) {
    _selectedVariation2Option = value;
    notifyListeners();
  }

  void setVariation2Option(String value) {
    _selectedVariation2Option = value;
  }

  /// selected variation 2 name....
  String _selectedVariation2Name;

  String get selectedVariation2Name => _selectedVariation2Name;

  set selectedVariation2Name(String value) {
    _selectedVariation2Name = value;
    notifyListeners();
  }

  void setVariation2Name(String value) {
    _selectedVariation2Name = value;
  }

  /// selected variations 2 id...
  String _selectedVariation2Id;

  String get selectedVariation2Id => _selectedVariation2Id;

  set selectedVariation2Id(String value) {
    _selectedVariation2Id = value;
    notifyListeners();
  }

  void setVariation2Id(String value) {
    _selectedVariation2Id = value;
  }

  /// selected variation 2 image....
  String _selectedVariation2Img;

  String get selectedVariation2Img => _selectedVariation2Img;

  set selectedVariation2Img(String value) {
    _selectedVariation2Img = value;
    notifyListeners();
  }

  void setVariation2Img(String value) {
    _selectedVariation2Img = value;
  }

  /// selected variations 1 option name..
  String _selectedVariation1OptionName;

  String get selectedVariation1OptionName => _selectedVariation1OptionName;

  set selectedVariation1OptionName(String value) {
    _selectedVariation1OptionName = value;
    notifyListeners();
  }

  void setVariation1OptionName(String value) {
    _selectedVariation1OptionName = value;
  }

  /// selected variations 1 id....
  String _selectedVariations1Id;

  String get selectedVariations1Id => _selectedVariations1Id;

  set selectedVariations1Id(String value) {
    _selectedVariations1Id = value;
    notifyListeners();
  }

  void setVariation1Id(String value) {
    _selectedVariations1Id = value;
  }

  /// selected variation 1 image ...
  String _selectedVariation1Img;

  String get selectedVariation1Img => _selectedVariation1Img;

  set selectedVariation1Img(String value) {
    _selectedVariation1Img = value;
    notifyListeners();
  }

  void setVariation1Img(String value) {
    _selectedVariation1Img = value;
  }

  /// selected variation 1 name...
  String _selectedVariation1Name;

  String get selectedVariation1Name => _selectedVariation1Name;

  set selectedVariation1Name(String value) {
    _selectedVariation1Name = value;
    notifyListeners();
  }

  void setVariation1Name(String value) {
    _selectedVariation1Name = value;
  }

  /// product add to cart progress indicator...
  bool _isAddToCartInProgress = false;

  bool get isAddToCartInProgress => _isAddToCartInProgress;

  set isAddToCartInProgress(bool value) {
    _isAddToCartInProgress = value;
    notifyListeners();
  }

  /// product deleting from cart in progress...
  bool _isProductRemovingFromCartInProgress = false;

  bool get isProductRemovingFromCartInProgress =>
      _isProductRemovingFromCartInProgress;

  set isProductRemovingFromCartInProgress(bool value) {
    _isProductRemovingFromCartInProgress = value;
    notifyListeners();
  }
}
