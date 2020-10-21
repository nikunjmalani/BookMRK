import 'dart:convert';

NoDataCartModel noDataCartModelFromJson(String str) =>
    NoDataCartModel.fromJson(json.decode(str));

String noDataCartModelToJson(NoDataCartModel data) =>
    json.encode(data.toJson());

class NoDataCartModel {
  NoDataCartModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<List<dynamic>> response;

  factory NoDataCartModel.fromJson(Map<String, dynamic> json) =>
      NoDataCartModel(
        status: json["status"],
        message: json["message"],
        count: json["count"],
        response: List<List<dynamic>>.from(
            json["response"].map((x) => List<dynamic>.from(x.map((x) => x)))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "count": count,
        "response": List<dynamic>.from(
            response.map((x) => List<dynamic>.from(x.map((x) => x)))),
      };
}
