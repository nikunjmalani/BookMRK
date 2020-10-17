import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class SearchAPI {
  /// api to search products...
  static Future searchProductHomePage(String productName, String userId) async {
    String url =
        "$kBaseURL/product/find/1595922619X5f1fd8bb5f332/MOB/$userId/$productName";

    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Auth-Key": "simplerestapi",
      "client-Service": "frontend-client"
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }
}
