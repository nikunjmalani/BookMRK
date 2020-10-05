import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class LoginAPI {
  /// api for check user login ....
  static Future checkLogin({String email, String password}) async {
    String url = "$kBaseURL/login/login_check";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "User-ID": "1",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "email": "$email",
      "password": "$password",
    };

    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
      encoding: Encoding.getByName("utf-8"),
    );

    dynamic data = jsonDecode(response.body);
    if (data['status'] == 200) {
      return {
        "status": 200,
        "message": data['message'],
        "data": data['response']
      };
    } else {
      print(data);
      return {
        "status": data['status'],
        "message": data['message'],
        "data": data['response']
      };
    }
  }
}
