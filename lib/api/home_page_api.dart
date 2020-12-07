import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class HomePageApi {
  /// api to show all the details of home page.
  static Future getHomePageDetails() async {
    String url = "$kBaseURL/home/homepage/1595922619X5f1fd8bb5f332/MOB/1";

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

  /// api to update application information......
  static Future updateApplicationInfo(
    String userId,
    String deviceId,
    String osInfo,
    String modelName,
    String appVersion,
    dynamic moreInfo,
  ) async {
    String url = "$kBaseURL/login/update_app_info";


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
      "device_id": "$deviceId",
      "os_info": "$osInfo",
      "model_name": "$modelName",
      "app_version": "$appVersion",
      "more_app_info": "${jsonEncode(moreInfo)}",
    };

    http.Response response = await http.post(url, headers: header, body: body);
    return jsonDecode(response.body);
  }
}
