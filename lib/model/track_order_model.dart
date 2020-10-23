import 'dart:convert';

TrackOrderModel trackOrderModelFromJson(String str) =>
    TrackOrderModel.fromJson(json.decode(str));

String trackOrderModelToJson(TrackOrderModel data) =>
    json.encode(data.toJson());

class TrackOrderModel {
  TrackOrderModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory TrackOrderModel.fromJson(Map<String, dynamic> json) =>
      TrackOrderModel(
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
    this.omdId,
    this.orderConfirmed,
    this.orderConfirmedDate,
    this.isManual,
    this.orderPacked,
    this.orderPackedDate,
    this.trackingNumber,
    this.shippingInfo,
    this.assignDeliveryUserId,
    this.assignDeliveryUserName,
    this.assignDeliveryUserMobileNo,
    this.assignDeliveryUserDate,
    this.orderPickup,
    this.orderPickupDate,
    this.inTransit,
    this.inTransitDate,
    this.expectedDateTime,
    this.outOfDelivery,
    this.outOfDeliveryDate,
    this.deliveryDateTime,
    this.userVerifyCode,
    this.delivered,
    this.deliveredDate,
    this.orderId,
    this.orderNo,
    this.userId,
    this.userName,
    this.paymentMethod,
    this.orderTotalCost,
    this.orderDateTime,
  });

  String omdId;
  String orderConfirmed;
  DateTime orderConfirmedDate;
  String isManual;
  String orderPacked;
  DateTime orderPackedDate;
  String trackingNumber;
  String shippingInfo;
  String assignDeliveryUserId;
  String assignDeliveryUserName;
  String assignDeliveryUserMobileNo;
  DateTime assignDeliveryUserDate;
  String orderPickup;
  DateTime orderPickupDate;
  String inTransit;
  DateTime inTransitDate;
  DateTime expectedDateTime;
  String outOfDelivery;
  DateTime outOfDeliveryDate;
  DateTime deliveryDateTime;
  String userVerifyCode;
  String delivered;
  String deliveredDate;
  String orderId;
  String orderNo;
  String userId;
  String userName;
  String paymentMethod;
  String orderTotalCost;
  DateTime orderDateTime;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        omdId: json["omd_id"],
        orderConfirmed: json["order_confirmed"],
        orderConfirmedDate: DateTime.parse(json["order_confirmed_date"]),
        isManual: json["is_manual"],
        orderPacked: json["order_packed"],
        orderPackedDate: DateTime.parse(json["order_packed_date"]),
        trackingNumber: json["tracking_number"],
        shippingInfo: json["shipping_info"],
        assignDeliveryUserId: json["assign_delivery_user_id"],
        assignDeliveryUserName: json["assign_delivery_user_name"],
        assignDeliveryUserMobileNo: json["assign_delivery_user_mobile_no"],
        assignDeliveryUserDate:
            DateTime.parse(json["assign_delivery_user_date"]),
        orderPickup: json["order_pickup"],
        orderPickupDate: DateTime.parse(json["order_pickup_date"]),
        inTransit: json["in_transit"],
        inTransitDate: DateTime.parse(json["in_transit_date"]),
        expectedDateTime: DateTime.parse(json["expected_date_time"]),
        outOfDelivery: json["out_of_delivery"],
        outOfDeliveryDate: DateTime.parse(json["out_of_delivery_date"]),
        deliveryDateTime: DateTime.parse(json["delivery_date_time"]),
        userVerifyCode: json["user_verify_code"],
        delivered: json["delivered"],
        deliveredDate: json["delivered_date"],
        orderId: json["order_id"],
        orderNo: json["order_no"],
        userId: json["user_id"],
        userName: json["user_name"],
        paymentMethod: json["payment_method"],
        orderTotalCost: json["order_total_cost"],
        orderDateTime: DateTime.parse(json["order_date_time"]),
      );

  Map<String, dynamic> toJson() => {
        "omd_id": omdId,
        "order_confirmed": orderConfirmed,
        "order_confirmed_date": orderConfirmedDate.toIso8601String(),
        "is_manual": isManual,
        "order_packed": orderPacked,
        "order_packed_date": orderPackedDate.toIso8601String(),
        "tracking_number": trackingNumber,
        "shipping_info": shippingInfo,
        "assign_delivery_user_id": assignDeliveryUserId,
        "assign_delivery_user_name": assignDeliveryUserName,
        "assign_delivery_user_mobile_no": assignDeliveryUserMobileNo,
        "assign_delivery_user_date": assignDeliveryUserDate.toIso8601String(),
        "order_pickup": orderPickup,
        "order_pickup_date": orderPickupDate.toIso8601String(),
        "in_transit": inTransit,
        "in_transit_date": inTransitDate.toIso8601String(),
        "expected_date_time": expectedDateTime.toIso8601String(),
        "out_of_delivery": outOfDelivery,
        "out_of_delivery_date": outOfDeliveryDate.toIso8601String(),
        "delivery_date_time": deliveryDateTime.toIso8601String(),
        "user_verify_code": userVerifyCode,
        "delivered": delivered,
        "delivered_date": deliveredDate,
        "order_id": orderId,
        "order_no": orderNo,
        "user_id": userId,
        "user_name": userName,
        "payment_method": paymentMethod,
        "order_total_cost": orderTotalCost,
        "order_date_time": orderDateTime.toIso8601String(),
      };
}
