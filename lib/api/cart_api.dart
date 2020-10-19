import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class CartAPI {
  /// api for get cart details of the user ...
  static Future getCartData(String userId) async {
    String url =
        "$kBaseURL/purchase/cart_view/1595922619X5f1fd8bb5f332/MOB/$userId";

    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Auth-Key": "simplerestapi",
      "Client-Service": "frontend-client",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }

  /// api to remove product from cart...
  static Future removeCart(String userId, String cartId) async {
    String url = "$kBaseURL/purchase/remove_cart";

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
      "cart_id": "$cartId",
    };

    http.Response response = await http.post(url,
        headers: header, body: body, encoding: Encoding.getByName('utf-8'));
    return jsonDecode(response.body);
  }

  /// api to add product in the cart....
  static Future addProductToCart(
    String userId,
    String productId,
    int qty,
    String studentName,
    String studentRoll,
    String pvsmId,
    dynamic variationInfo,
  ) async {
    String url = "$kBaseURL/purchase/add_to_cart";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map<String, dynamic> body = {
      "client-key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "user_id": "$userId",
      "product_id": "$productId",
      "qty": "$qty",
      "student-name": "$studentName",
      "student-roll": "$studentRoll",
      "pvsm_id": "$pvsmId",
      "variations_info": jsonEncode("$variationInfo"),
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
