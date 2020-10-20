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

  /// get selected user address for edit
  static Future getCurrentAddressForEdit(
      String userId, String userAddressId) async {
    String url =
        "$kBaseURL/user/user_address/1595922619X5f1fd8bb5f332/MOB/$userId/$userAddressId";

    Map<String, String> header = {
//      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
//      "User-ID": "$userId",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(url, headers: header);
    dynamic data = jsonDecode(response.body);
    return data;
  }

  /// update user profile image...
  static Future updateUserProfileImage(String userId, String image) async {
    String url = "$kBaseURL/user/update_user_profile";
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
      "profile_img": "data:image/png;base64,$image",
    };

    http.Response response = await http.post(url,
        headers: header, body: body, encoding: Encoding.getByName('utf-8'));
    return jsonDecode(response.body);
  }

  /// api to change the user information of profile....
  static Future changeUserInformation(
    String userId,
    String fname,
    String lname,
    String dob,
    String gender,
    String email,
  ) async {
    String url = "$kBaseURL/user/update_user_detail";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simpelrestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map<String, String> body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "device_type": "MOB",
      "user_id": "$userId",
      "fname": "$fname",
      "lname": "$lname",
      "dob": "$dob",
      "gender": "$gender",
      "email": "$email",
    };

    http.Response response = await http.post(url,
        headers: header, body: body, encoding: Encoding.getByName('utf-8'));
    return jsonDecode(response.body);
  }

  /// api for change mobile number of user profile...
  static Future changeUserProfileMobilNumber(
      String userId, String mobileNumber) async {
    String url = "$kBaseURL/user/update_user_mobile_number";
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
      "mobile": "$mobileNumber",
    };
    http.Response respones = await http.post(url,
        headers: header, body: body, encoding: Encoding.getByName('utf-8'));
    return jsonDecode(respones.body);
  }

  /// api to remove userAddress
  static Future removeUserAddress(String userId, String userAddressId) async {
    String url = "$kBaseURL/user/delete_address_user";
    Map<String, String> header = {
      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    Map<String, String> body = {
      "client_key": "1595922619X5f1fd8bb5f332",
      "user_id": "$userId",
      "user_address_id": "$userAddressId",
      "device_type": "MOB",
    };

    http.Response response = await http.post(url,
        headers: header, body: body, encoding: Encoding.getByName('utf-8'));
    return jsonDecode(response.body);
  }
}
