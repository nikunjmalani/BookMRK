import 'dart:convert';

StateModel stateModelFromJson(String str) =>
    StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  StateModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
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
    this.stateId,
    this.name,
    this.countryId,
  });

  String stateId;
  String name;
  String countryId;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        stateId: json["state_id"],
        name: json["name"],
        countryId: json["country_id"],
      );

  Map<String, dynamic> toJson() => {
        "state_id": stateId,
        "name": name,
        "country_id": countryId,
      };
}
