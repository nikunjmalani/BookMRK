import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class ProductAPI {
  /// api to get all the information of the single product...
  static Future getProductDetails(String productSlug, String userId) async {
    String url =
        "$kBaseURL/product/detail/1595922619X5f1fd8bb5f332/MOB/$userId/$productSlug";
    Map<String, String> header = {
      "Content-Type": "application/x-www-form-urlencoded",
      "Auth-Key": "simplerestapi",
      "Client-Service": "frontend-client",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }
}
