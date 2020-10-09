import 'dart:convert';

CartDetailsModel cartDetailsModelFromJson(String str) =>
    CartDetailsModel.fromJson(json.decode(str));

String cartDetailsModelToJson(CartDetailsModel data) =>
    json.encode(data.toJson());

class CartDetailsModel {
  CartDetailsModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory CartDetailsModel.fromJson(Map<String, dynamic> json) =>
      CartDetailsModel(
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
    this.cart,
    this.cartInfo,
  });

  List<Cart> cart;
  List<CartInfo> cartInfo;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
        cartInfo: List<CartInfo>.from(
            json["cart_info"].map((x) => CartInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
        "cart_info": List<dynamic>.from(cartInfo.map((x) => x.toJson())),
      };
}

class Cart {
  Cart({
    this.cartId,
    this.variationType,
    this.productId,
    this.productName,
    this.productSlug,
    this.productImg,
    this.productPrice,
    this.qty,
    this.productDiscount,
    this.productSalePrice,
    this.productPriceWithoutTax,
    this.productGst,
    this.productGstQtyTotal,
    this.productFinalTotal,
    this.productSavingTotal,
    this.studentName,
    this.studentRoll,
    this.pvsmId,
    this.variationsOptionsName,
    this.productStockStatus,
  });

  String cartId;
  String variationType;
  String productId;
  String productName;
  String productSlug;
  String productImg;
  String productPrice;
  String qty;
  String productDiscount;
  String productSalePrice;
  String productPriceWithoutTax;
  String productGst;
  String productGstQtyTotal;
  String productFinalTotal;
  String productSavingTotal;
  String studentName;
  String studentRoll;
  String pvsmId;
  String variationsOptionsName;
  String productStockStatus;

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        cartId: json["cart_id"],
        variationType: json["variation_type"],
        productId: json["product_id"],
        productName: json["product_name"],
        productSlug: json["product_slug"],
        productImg: json["product_img"],
        productPrice: json["product_price"],
        qty: json["qty"],
        productDiscount: json["product_discount"],
        productSalePrice: json["product_sale_price"],
        productPriceWithoutTax: json["product_price_without_tax"],
        productGst: json["product_gst"],
        productGstQtyTotal: json["product_gst_qty_total"],
        productFinalTotal: json["product_final_total"],
        productSavingTotal: json["product_saving_total"],
        studentName: json["student_name"],
        studentRoll: json["student_roll"],
        pvsmId: json["pvsm_id"],
        variationsOptionsName: json["variations_options_name"],
        productStockStatus: json["product_stock_status"],
      );

  Map<String, dynamic> toJson() => {
        "cart_id": cartId,
        "variation_type": variationType,
        "product_id": productId,
        "product_name": productName,
        "product_slug": productSlug,
        "product_img": productImg,
        "product_price": productPrice,
        "qty": qty,
        "product_discount": productDiscount,
        "product_sale_price": productSalePrice,
        "product_price_without_tax": productPriceWithoutTax,
        "product_gst": productGst,
        "product_gst_qty_total": productGstQtyTotal,
        "product_final_total": productFinalTotal,
        "product_saving_total": productSavingTotal,
        "student_name": studentName,
        "student_roll": studentRoll,
        "pvsm_id": pvsmId,
        "variations_options_name": variationsOptionsName,
        "product_stock_status": productStockStatus,
      };
}

class CartInfo {
  CartInfo({
    this.finalPrice,
    this.finalTaxPrice,
    this.finalDeliveryPrice,
    this.finalTotalPrice,
    this.hideCheckoutButton,
    this.userAddressSelected,
  });

  String finalPrice;
  String finalTaxPrice;
  String finalDeliveryPrice;
  String finalTotalPrice;
  String hideCheckoutButton;
  String userAddressSelected;

  factory CartInfo.fromJson(Map<String, dynamic> json) => CartInfo(
        finalPrice: json["final_price"],
        finalTaxPrice: json["final_tax_price"],
        finalDeliveryPrice: json["final_delivery_price"],
        finalTotalPrice: json["final_total_price"],
        hideCheckoutButton: json["hide_checkout_button"],
        userAddressSelected: json["user_address_selected"],
      );

  Map<String, dynamic> toJson() => {
        "final_price": finalPrice,
        "final_tax_price": finalTaxPrice,
        "final_delivery_price": finalDeliveryPrice,
        "final_total_price": finalTotalPrice,
        "hide_checkout_button": hideCheckoutButton,
        "user_address_selected": userAddressSelected,
      };
}
