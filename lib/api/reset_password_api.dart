import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class ResetPasswordAPI {
  /// API to reset the password
  static Future resetPassword(String otp, String mobileNumber, String password,
      String confirmPassword) async {
    String url = "$kBaseURL/login/reset_password";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
//      "User-ID": "1",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "mobile": "$mobileNumber",
      "otp": "$otp",
      "password": "$password",
      "confirm_password": "$confirmPassword"
    };

    http.Response response = await http.post(
      url,
      headers: header,
      body: body,
      encoding: Encoding.getByName("utf-8"),
    );

    dynamic data = jsonDecode(response.body);
    return data;
  }
}
