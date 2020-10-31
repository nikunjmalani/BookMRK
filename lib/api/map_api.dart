import 'dart:convert';

import 'package:bookmrk/constant/constant.dart';
import 'package:http/http.dart' as http;

class MapAPI {
  /// api to get address from latitude and longtitude.......
  static Future getAddressFromLatLng(double lat, double lng) async {
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&sensor=true&key=$kMapKey";
    http.Response response = await http.get(url);
    return jsonDecode(response.body);
  }
}
