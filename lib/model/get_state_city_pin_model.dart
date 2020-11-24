// To parse this JSON data, do
//
//     final getStateCityPinModel = getStateCityPinModelFromJson(jsonString);

import 'dart:convert';

GetStateCityPinModel getStateCityPinModelFromJson(String str) => GetStateCityPinModel.fromJson(json.decode(str));

String getStateCityPinModelToJson(GetStateCityPinModel data) => json.encode(data.toJson());

class GetStateCityPinModel {
  GetStateCityPinModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory GetStateCityPinModel.fromJson(Map<String, dynamic> json) => GetStateCityPinModel(
    status: json["status"],
    message: json["message"],
    count: json["count"],
    response: List<Response>.from(json["response"].map((x) => Response.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "count": count,
    "response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class Response {
  Response({
    this.country,
    this.state,
    this.city,
    this.pincode,
    this.street,
    this.countryCode,
    this.formattedAddress,
    this.countryId,
    this.stateId,
    this.cityId,
  });

  String country;
  String state;
  String city;
  String pincode;
  String street;
  String countryCode;
  String formattedAddress;
  String countryId;
  String stateId;
  String cityId;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    country: json["country"],
    state: json["state"],
    city: json["city"],
    pincode: json["pincode"],
    street: json["street"],
    countryCode: json["country_code"],
    formattedAddress: json["formatted_address"],
    countryId: json["country_id"],
    stateId: json["state_id"],
    cityId: json["city_id"],
  );

  Map<String, dynamic> toJson() => {
    "country": country,
    "state": state,
    "city": city,
    "pincode": pincode,
    "street": street,
    "country_code": countryCode,
    "formatted_address": formattedAddress,
    "country_id": countryId,
    "state_id": stateId,
    "city_id": cityId,
  };
}
