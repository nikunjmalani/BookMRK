import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class UserAPI {
  /// api to get all the information of user.
  static Future getAllUserInformation(String userId) async {
    String url =
        "$kBaseURL/user/user_detail/1595922619X5f1fd8bb5f332/MOB/$userId";

    Map<String, String> header = {
//      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
//      "User-ID": "1",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(
      url,
      headers: header,
    );

    dynamic data = jsonDecode(response.body);
    return data;
  }

  /// api to get user address..
  static Future getUserAddress(String userId) async {
    String url =
        "$kBaseURL/user/user_all_address/1595922619X5f1fd8bb5f332/MOB/$userId";

    Map<String, String> header = {
//      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
//      "User-ID": "1",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(
      url,
      headers: header,
    );

    dynamic data = jsonDecode(response.body);
    return data;
  }

  /// change selected user address.
  static Future changeSelectedUserAddress(
      String userId, String userAddressId) async {
    String url = "$kBaseURL/user/update_selected_address_user";

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
      "user_id": "$userId",
      "user_address_id": "$userAddressId",
      "is_selected": "1"
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

  /// api to add new address of user ...
  static Future addNewUserAddress(
    String userId,
    String fName,
    String lName,
    String email,
    String mobile,
    String state,
    String city,
    String address1,
    String address2,
    String pincode,
    String country,
  ) async {
    String url = "$kBaseURL/user/add_address";

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
      "user_id": "$userId",
      "fname": "$fName",
      "lname": "$lName",
      "email": "$email",
      "mobile": "$mobile",
      "state": "$state",
      "city": "$city",
      "country": "$country",
      "address1": "$address1",
      "address2": "$address2",
      "pincode": "$pincode",
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

  /// api edit user profile ..
  static Future editUserAddress(
    String userId,
    String userAddressId,
    String fName,
    String lName,
    String email,
    String mobile,
    String state,
    String city,
    String address1,
    String address2,
    String pincode,
  ) async {
    String url = "$kBaseURL/user/update_address_user";

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
      "user_id": "$userId",
      "user_address_id": "$userAddressId",
      "fname": "$fName",
      "lname": "$lName",
      "email": "$email",
      "mobile": "$mobile",
      "state": "$state",
      "city": "$city",
      "address1": "$address1",
      "address2": "$address2",
      "pincode": "$pincode",
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