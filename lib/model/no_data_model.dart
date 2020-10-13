import 'dart:convert';

NoDataOrderModel noDataOrderModelFromJson(String str) =>
    NoDataOrderModel.fromJson(json.decode(str));

String noDataOrderModelToJson(NoDataOrderModel data) =>
    json.encode(data.toJson());

class NoDataOrderModel {
  NoDataOrderModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<dynamic> response;

  factory NoDataOrderModel.fromJson(Map<String, dynamic> json) =>
      NoDataOrderModel(
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
