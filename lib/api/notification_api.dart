import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class NotificationAPI {
  static Future getAllNotification(String userId) async {
    String url =
        "$kBaseURL/app/all_notification/1595922619X5f1fd8bb5f332/MOB/$userId";

    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }


  /// notification read....
  static Future notificationRead(String userId, String notificationId) async {
    String url =
        "$kBaseURL/app/notification_seen/1595922619X5f1fd8bb5f332/MOB/$userId/$notificationId";


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
