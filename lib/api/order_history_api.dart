import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class OrderHistoryAPI {
  /// get order details ...
  static Future getOrderHistoryDetails(String userId, String status) async {
    String url =
        "$kBaseURL/purchase/purchase_history/1595922619X5f1fd8bb5f332/MOB/$status/$userId";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }

  /// get order details from the order id ....
  static Future getOrderDetailsFromOrderId(
      String orderId, String userId) async {
    String url =
        "$kBaseURL/purchase/purchase_history_by_order_no/1595922619X5f1fd8bb5f332/MOB/$userId/$orderId";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }
}
