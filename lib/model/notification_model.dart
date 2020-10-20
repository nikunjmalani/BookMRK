import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
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
    this.notificationId,
    this.userId,
    this.orderNo,
    this.msg,
    this.datetime,
    this.isSeen,
  });

  String notificationId;
  String userId;
  String orderNo;
  String msg;
  String datetime;
  String isSeen;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        notificationId: json["notification_id"],
        userId: json["user_id"],
        orderNo: json["order_no"],
        msg: json["msg"],
        datetime: json["datetime"],
        isSeen: json["is_seen"],
      );

  Map<String, dynamic> toJson() => {
        "notification_id": notificationId,
        "user_id": userId,
        "order_no": orderNo,
        "msg": msg,
        "datetime": datetime,
        "is_seen": isSeen,
      };
}
