import 'dart:convert';

OrderHistoryModel orderHistoryModelFromJson(String str) =>
    OrderHistoryModel.fromJson(json.decode(str));

String orderHistoryModelToJson(OrderHistoryModel data) =>
    json.encode(data.toJson());

class OrderHistoryModel {
  OrderHistoryModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryModel(
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
    this.orderNo,
    this.userId,
    this.paymentMethod,
    this.orderTotalCost,
    this.orderDateTime,
    this.orderCompleted,
    this.orderStatus,
    this.orderData,
  });

  String orderNo;
  String userId;
  String paymentMethod;
  String orderTotalCost;
  DateTime orderDateTime;
  String orderCompleted;
  String orderStatus;
  List<OrderDatum> orderData;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        orderNo: json["order_no"],
        userId: json["user_id"],
        paymentMethod: json["payment_method"],
        orderTotalCost: json["order_total_cost"],
        orderDateTime: DateTime.parse(json["order_date_time"]),
        orderCompleted: json["order_completed"],
        orderStatus: json["order_status"],
        orderData: List<OrderDatum>.from(
            json["order_data"].map((x) => OrderDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "order_no": orderNo,
        "user_id": userId,
        "payment_method": paymentMethod,
        "order_total_cost": orderTotalCost,
        "order_date_time": orderDateTime.toIso8601String(),
        "order_completed": orderCompleted,
        "order_status": orderStatus,
        "order_data": List<dynamic>.from(orderData.map((x) => x.toJson())),
      };
}

class OrderDatum {
  OrderDatum({
    this.subOrderNo,
    this.orderConfirmed,
    this.orderConfirmedDate,
    this.isManual,
    this.orderPacked,
    this.orderPackedDate,
    this.delivered,
    this.deliveredDate,
    this.orderDetail,
  });

  String subOrderNo;
  String orderConfirmed;
  String orderConfirmedDate;
  String isManual;
  String orderPacked;
  String orderPackedDate;
  String delivered;
  String deliveredDate;
  List<OrderDetail> orderDetail;

  factory OrderDatum.fromJson(Map<String, dynamic> json) => OrderDatum(
        subOrderNo: json["sub_order_no"],
        orderConfirmed: json["order_confirmed"],
        orderConfirmedDate: json["order_confirmed_date"],
        isManual: json["is_manual"],
        orderPacked: json["order_packed"],
        orderPackedDate: json["order_packed_date"],
        delivered: json["delivered"],
        deliveredDate: json["delivered_date"],
        orderDetail: List<OrderDetail>.from(
            json["order_detail"].map((x) => OrderDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sub_order_no": subOrderNo,
        "order_confirmed": orderConfirmed,
        "order_confirmed_date": orderConfirmedDate,
        "is_manual": isManual,
        "order_packed": orderPacked,
        "order_packed_date": orderPackedDate,
        "delivered": delivered,
        "delivered_date": deliveredDate,
        "order_detail": List<dynamic>.from(orderDetail.map((x) => x.toJson())),
      };
}

class OrderDetail {
  OrderDetail({
    this.productId,
    this.productSlug,
    this.productName,
  });

  String productId;
  String productSlug;
  String productName;

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
        productId: json["product_id"],
        productSlug: json["product_slug"],
        productName: json["product_name"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_slug": productSlug,
        "product_name": productName,
      };
}
