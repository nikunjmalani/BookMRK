import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class LocationNameAPI {
  /// api for get country list....
  static Future getAllCountryName() async {
    String url = "$kBaseURL/app/get_countries/1595922619X5f1fd8bb5f332/MOB";

    Map<String, String> header = {
      "Content-Type": "application/x-form-urlencoded",
      "Auth-Hey": "simplerestapi",
      "Client-Service": "frontend-client",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }

  /// api to get state of selected country ...
  static Future getAllStateOfCountry(int countryId) async {
    String url =
        "$kBaseURL/app/get_states_by_country_id/1595922619X5f1fd8bb5f332/MOB/$countryId";

    Map<String, String> header = {
      "Content-Type": "application/x-form-urlencoded",
      "Auth-Hey": "simplerestapi",
      "Client-Service": "frontend-client",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }

  /// api to get city of selected state ...
  static Future getAllCityOfState(int stateId) async {
    String url =
        "$kBaseURL/app/get_city_by_state_id/1595922619X5f1fd8bb5f332/MOB/$stateId";

    Map<String, String> header = {
      "Content-Type": "application/x-form-urlencoded",
      "Auth-Hey": "simplerestapi",
      "Client-Service": "frontend-client",
    };

    http.Response response = await http.get(url, headers: header);
    return jsonDecode(response.body);
  }
}
