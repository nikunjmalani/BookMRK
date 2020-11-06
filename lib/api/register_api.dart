import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class RegisterAPI {
  /// api to create new user...
  static Future registerNewUser(
      {String firstName,
      String lastName,
      String gender,
      String email,
      String mobile,
      String dob,
      String password,
      String confirmPassword}) async {
    String url = "$kBaseURL/user/create";

    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
//      "User-ID": "$userId",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map<String, dynamic> body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "fname": "$firstName",
      "lname": "$lastName",
      "gender": "$gender",
      "email": "$email",
      "mobile": "$mobile",
      "dob": "$dob",
      "password": "$password",
      "confirm_password": "$confirmPassword",
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

  /// api for verify mobile number while register.
  static Future verifyMobileNumber(String mobileNumber, String userId) async {
    String url = "$kBaseURL/Otp/validate/1";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "User-ID": "$userId",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "mobile": "$mobileNumber",
      "user_id": "$userId"
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

  /// API for check otp for mobile verification
  static Future verifyMobileWithOTP(
      String mobileNumber, String otp, String userId) async {
    String url = "$kBaseURL/otp/validate/0";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "User-ID": "$userId",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "mobile": "$mobileNumber",
      "user_id": "$userId",
      "otp": "$otp"
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
