import 'dart:convert';

WishListModel wishListModelFromJson(String str) =>
    WishListModel.fromJson(json.decode(str));

String wishListModelToJson(WishListModel data) => json.encode(data.toJson());

class WishListModel {
  WishListModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
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
    this.productId,
    this.productSlug,
    this.vendorSlug,
    this.schoolSlug,
    this.type,
    this.productType,
    this.variation,
    this.categoryName,
    this.productImg,
    this.productName,
    this.productPrice,
    this.productDiscount,
    this.productSalePrice,
    this.quantity,
    this.vendorCompanyName,
    this.productStockStatus,
    this.productInUserWishlist,
  });

  String productId;
  String productSlug;
  String vendorSlug;
  String schoolSlug;
  String type;
  String productType;
  String variation;
  String categoryName;
  String productImg;
  String productName;
  String productPrice;
  String productDiscount;
  String productSalePrice;
  String quantity;
  String vendorCompanyName;
  String productStockStatus;
  String productInUserWishlist;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        productId: json["product_id"],
        productSlug: json["product_slug"],
        vendorSlug: json["vendor_slug"],
        schoolSlug: json["school_slug"],
        type: json["type"],
        productType: json["product_type"],
        variation: json["variation"],
        categoryName: json["category_name"],
        productImg: json["Product_img"],
        productName: json["product_name"],
        productPrice: json["product_price"],
        productDiscount: json["product_discount"],
        productSalePrice: json["product_sale_price"],
        quantity: json["quantity"],
        vendorCompanyName: json["vendor_company_name"],
        productStockStatus: json["product_stock_status"],
        productInUserWishlist: json["product_in_user_wishlist"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_slug": productSlug,
        "vendor_slug": vendorSlug,
        "school_slug": schoolSlug,
        "type": type,
        "product_type": productType,
        "variation": variation,
        "category_name": categoryName,
        "Product_img": productImg,
        "product_name": productName,
        "product_price": productPrice,
        "product_discount": productDiscount,
        "product_sale_price": productSalePrice,
        "quantity": quantity,
        "vendor_company_name": vendorCompanyName,
        "product_stock_status": productStockStatus,
        "product_in_user_wishlist": productInUserWishlist,
      };
}
