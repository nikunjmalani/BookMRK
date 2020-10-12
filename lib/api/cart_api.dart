import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class CartAPI {
  /// api for get cart details of the user ...
  static Future getCartData(String userId) async {
    String url = "$kBaseURL/purchase/cart_view/1595922619X5f1fd8bb5f332/MOB/1";

    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Auth-Key": "simplerestapi",
      "Client-Service": "frontend-client",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }
}
