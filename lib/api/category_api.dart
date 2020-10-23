import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class CategoryAPI {
  /// api to list all the categories.
  static Future getAllCategoryList() async {
    String url =
        "$kBaseURL/categories/main_categories/1595922619X5f1fd8bb5f332/MOB/1";

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

  /// api to get all products from category..
  static Future getCategoryProducts(String categorySlug, String userId) async {
    String url =
        "$kBaseURL/categories/categories_by_subcategories_product/1595922619X5f1fd8bb5f332/MOB/$userId/$categorySlug";

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

  /// get list of category with subcategory ....
  static Future getListOfCategoryWithSubCategory(String userId) async {
    String url =
        "$kBaseURL//categories/main_categories_view_with_subcategory/1595922619X5f1fd8bb5f332/MOB/$userId";
    Map<String, String> header = {
//      "Authorization": "\$1\$aRkFpEz3\$qGGbgw/.xtfSv8rvK/j5y0",
      "Client-Service": "frontend-client",
      "Auth-Key": "simplerestapi",
      "Content-Type": "application/x-www-form-urlencoded",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }
}
