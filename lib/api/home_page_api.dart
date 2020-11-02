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
}
