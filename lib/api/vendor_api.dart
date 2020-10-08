import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VendorAPI extends ChangeNotifier {
  /// api to get all vendors..
  static Future getAllVendors() async {
    String url = "$kBaseURL/app/all_vendor/1595922619X5f1fd8bb5f332/MOB/1";
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

  /// api to get information of single product from vendor..
  static Future getVendorProductInformation(String vendorSlug) async {
    String url =
        "$kBaseURL/app/single_vendor_all_product/1595922619X5f1fd8bb5f332/MOB/1/$vendorSlug";

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

  /// api to get school information of vendor
  static Future getSchoolInformation(String vendorSlug) async {
    String url =
        "$kBaseURL/app/single_vendor_all_school/1595922619X5f1fd8bb5f332/MOB/1/$vendorSlug";
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
