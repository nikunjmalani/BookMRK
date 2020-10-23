import 'dart:convert';

EmptyDataModel emptyDataModelFromJson(String str) =>
    EmptyDataModel.fromJson(json.decode(str));

String emptyDataModelToJson(EmptyDataModel data) => json.encode(data.toJson());

class EmptyDataModel {
  EmptyDataModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<dynamic> response;

  factory EmptyDataModel.fromJson(Map<String, dynamic> json) => EmptyDataModel(
        status: json["status"],
        message: json["message"],
        count: json["count"],
        response: List<dynamic>.from(json["response"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "count": count,
        "response": List<dynamic>.from(response.map((x) => x)),
      };
}
