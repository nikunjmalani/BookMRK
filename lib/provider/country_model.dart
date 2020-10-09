import 'dart:convert';

CountryModel countryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  CountryModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
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
    this.countryId,
    this.name,
    this.sortname,
  });

  String countryId;
  String name;
  String sortname;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        countryId: json["country_id"],
        name: json["name"],
        sortname: json["sortname"],
      );

  Map<String, dynamic> toJson() => {
        "country_id": countryId,
        "name": name,
        "sortname": sortname,
      };
}
