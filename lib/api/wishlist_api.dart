import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class WishListAPI {
  /// api to get all products from wish list...
  static Future getWishListProducts(String userId) async {
    String url =
        "$kBaseURL/product/product_from_user_wishlist/1595922619X5f1fd8bb5f332/MOB/$userId";
    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Auth-Key": "simplerestapi",
      "Client-Service": "frontend-client",
    };
    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }

  /// api to add product in the wish list...
  static Future addProductInWishList(String userId, String productId) async {
    String url = "$kBaseURL/product/product_in_user_wishlist";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map<String, String> body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "user_id": "$userId",
      "product_id": "$productId",
      "status": "ADD"
    };

    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
      encoding: Encoding.getByName('utf-8'),
    );

    return jsonDecode(response.body);
  }

  /// api to remove product from the wish list...
  static Future removeProductFromWishList(
      String userId, String productId) async {
    String url = "$kBaseURL/product/product_in_user_wishlist";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map<String, String> body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "user_id": "$userId",
      "product_id": "$productId",
      "status": "REMOVE"
    };



    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
      encoding: Encoding.getByName('utf-8'),
    );

    return jsonDecode(response.body);
  }
}
