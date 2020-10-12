import 'dart:convert';

CityModel cityModelFromJson(String str) => CityModel.fromJson(json.decode(str));

String cityModelToJson(CityModel data) => json.encode(data.toJson());

class CityModel {
  CityModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        status: json["status"],
        message: json["message"],
        count: json["count"],
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
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
    this.cityId,
    this.name,
    this.stateId,
  });

  String cityId;
  String name;
  String stateId;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        cityId: json["city_id"],
        name: json["name"],
        stateId: json["state_id"],
      );

  Map<String, dynamic> toJson() => {
        "city_id": cityId,
        "name": name,
        "state_id": stateId,
      };
}
