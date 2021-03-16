import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class SchoolAPI {
  /// api to list all the school details.
  static Future getAllSchoolList() async {
    String url = "$kBaseURL/app/all_school/1595922619X5f1fd8bb5f332/MOB/1";

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

  static Future getSchoolAccess({String schoolSlug,String code}) async {
    int userId = prefs.read<int>('userId');
    String url = "$kBaseURL/app/verify_secure_school/1595922619X5f1fd8bb5f332/MOB/$userId/$schoolSlug/$code";

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

  static Future getSchoolProductDetails(
      String schoolSlug, String userId) async {
    String url =
        "$kBaseURL/app/single_school/1595922619X5f1fd8bb5f332/MOB/$userId/$schoolSlug";

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

  /// api to fetch products of selected sub category in school info page...
  static Future getSubcategoryProductsOfSchool(
      String userId, String schoolSlug, String subcategoryId) async {
    String url =
        "$kBaseURL/app/single_school_categories_product/1595922619X5f1fd8bb5f332/MOB/$userId/$schoolSlug/$subcategoryId";
    Map<String, String> header = {
//      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
//      "User-ID": "1",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }

  /// find school by location .....
  static Future findSchoolByLocation(String userId, String countryId,
      String stateId, String cityId, String pincode) async {
    String url =
        "$kBaseURL/app/find_school_by_location/1595922619X5f1fd8bb5f332/MOB/$userId/$countryId/$stateId/$cityId/$pincode";
    Map<String, String> header = {
//      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
//      "User-ID": "1",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }
}
