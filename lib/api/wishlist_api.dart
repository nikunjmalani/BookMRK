import 'package:bookmrk/constant/constant.dart';

class WishListAPI {
  /// api to get all products from wish list...
  static Future getWishListProducts(String userId) async {
    String url =
        "$kBaseURL/product/product_from_user_wishlist/1595922619X5f1fd8bb5f332/MOB/$userId";
  }
}
