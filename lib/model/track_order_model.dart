
import 'dart:convert';

TrackOrderModel trackOrderModelFromJson(String str) => TrackOrderModel.fromJson(json.decode(str));

String trackOrderModelToJson(TrackOrderModel data) => json.encode(data.toJson());

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

  factory TrackOrderModel.fromJson(Map<String, dynamic> json) => TrackOrderModel(
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
    this.omdId,
    this.orderConfirmed,
    this.orderConfirmedDate,
    this.isManual,
    this.orderPacked,
    this.orderPackedDate,
    this.trackingNumber,
    this.shippingInfo,
    this.shippingInfoDate,
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
    this.deliveryUserLatitudes,
    this.deliveryUserLongitude,
    this.isInvoiceMade,
    this.invoiceLink,
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
  String orderConfirmedDate;
  String isManual;
  String orderPacked;
  String orderPackedDate;
  String trackingNumber;
  String shippingInfo;
  String shippingInfoDate;
  String assignDeliveryUserId;
  String assignDeliveryUserName;
  String assignDeliveryUserMobileNo;
  String assignDeliveryUserDate;
  String orderPickup;
  String orderPickupDate;
  String inTransit;
  String inTransitDate;
  String expectedDateTime;
  String outOfDelivery;
  String outOfDeliveryDate;
  String deliveryDateTime;
  String userVerifyCode;
  String delivered;
  String deliveredDate;
  String deliveryUserLatitudes;
  String deliveryUserLongitude;
  String isInvoiceMade;
  String invoiceLink;
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
    orderConfirmedDate: json["order_confirmed_date"],
    isManual: json["is_manual"],
    orderPacked: json["order_packed"],
    orderPackedDate: json["order_packed_date"],
    trackingNumber: json["tracking_number"],
    shippingInfo: json["shipping_info"],
    shippingInfoDate: json["shipping_info_date"],
    assignDeliveryUserId: json["assign_delivery_user_id"],
    assignDeliveryUserName: json["assign_delivery_user_name"],
    assignDeliveryUserMobileNo: json["assign_delivery_user_mobile_no"],
    assignDeliveryUserDate: json["assign_delivery_user_date"],
    orderPickup: json["order_pickup"],
    orderPickupDate: json["order_pickup_date"],
    inTransit: json["in_transit"],
    inTransitDate: json["in_transit_date"],
    expectedDateTime: json["expected_date_time"],
    outOfDelivery: json["out_of_delivery"],
    outOfDeliveryDate: json["out_of_delivery_date"],
    deliveryDateTime: json["delivery_date_time"],
    userVerifyCode: json["user_verify_code"],
    delivered: json["delivered"],
    deliveredDate: json["delivered_date"],
    deliveryUserLatitudes: json["delivery_user_latitudes"],
    deliveryUserLongitude: json["delivery_user_longitude"],
    isInvoiceMade: json["is_invoice_made"],
    invoiceLink: json["invoice_link"],
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
    "order_confirmed_date": orderConfirmedDate,
    "is_manual": isManual,
    "order_packed": orderPacked,
    "order_packed_date": orderPackedDate,
    "tracking_number": trackingNumber,
    "shipping_info": shippingInfo,
    "shipping_info_date": shippingInfoDate,
    "assign_delivery_user_id": assignDeliveryUserId,
    "assign_delivery_user_name": assignDeliveryUserName,
    "assign_delivery_user_mobile_no": assignDeliveryUserMobileNo,
    "assign_delivery_user_date": assignDeliveryUserDate,
    "order_pickup": orderPickup,
    "order_pickup_date": orderPickupDate,
    "in_transit": inTransit,
    "in_transit_date": inTransitDate,
    "expected_date_time": expectedDateTime,
    "out_of_delivery": outOfDelivery,
    "out_of_delivery_date": outOfDeliveryDate,
    "delivery_date_time": deliveryDateTime,
    "user_verify_code": userVerifyCode,
    "delivered": delivered,
    "delivered_date": deliveredDate,
    "delivery_user_latitudes": deliveryUserLatitudes,
    "delivery_user_longitude": deliveryUserLongitude,
    "is_invoice_made": isInvoiceMade,
    "invoice_link": invoiceLink,
    "order_id": orderId,
    "order_no": orderNo,
    "user_id": userId,
    "user_name": userName,
    "payment_method": paymentMethod,
    "order_total_cost": orderTotalCost,
    "order_date_time": orderDateTime.toIso8601String(),
  };
}
