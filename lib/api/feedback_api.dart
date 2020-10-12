import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class FeedBackAPI {
  /// api to give feed back...
  static Future giveFeedBack(String userId, String feedBack) async {
    String url = "$kBaseURL/app/user_submit_feedback";

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
      "feedback": "$feedBack",
      "feedback_img": ""
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
