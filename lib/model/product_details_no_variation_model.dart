import 'dart:convert';

ProductDetailsNoVariationModel productDetailsNoVariationModelFromJson(
        String str) =>
    ProductDetailsNoVariationModel.fromJson(json.decode(str));

String productDetailsNoVariationModelToJson(
        ProductDetailsNoVariationModel data) =>
    json.encode(data.toJson());

class ProductDetailsNoVariationModel {
  ProductDetailsNoVariationModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory ProductDetailsNoVariationModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailsNoVariationModel(
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
    this.howManyVariation,
    this.productName,
    this.quantity,
    this.productPrice,
    this.productDiscount,
    this.productSalePrice,
    this.productSpecification,
    this.productDescription,
    this.vendorCompanyName,
    this.productStockStatus,
    this.productImgs,
    this.productInUserWishlist,
  });

  String productId;
  String productSlug;
  String vendorSlug;
  String schoolSlug;
  String type;
  String productType;
  String variation;
  String howManyVariation;
  String productName;
  String quantity;
  String productPrice;
  String productDiscount;
  String productSalePrice;
  String productSpecification;
  String productDescription;
  String vendorCompanyName;
  String productStockStatus;
  List<ProductImg> productImgs;
  String productInUserWishlist;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        productId: json["product_id"],
        productSlug: json["product_slug"],
        vendorSlug: json["vendor_slug"],
        schoolSlug: json["school_slug"],
        type: json["type"],
        productType: json["product_type"],
        variation: json["variation"],
        howManyVariation: json["how_many_variation"],
        productName: json["product_name"],
        quantity: json["quantity"],
        productPrice: json["product_price"],
        productDiscount: json["product_discount"],
        productSalePrice: json["product_sale_price"],
        productSpecification: json["product_specification"],
        productDescription: json["product_description"],
        vendorCompanyName: json["vendor_company_name"],
        productStockStatus: json["product_stock_status"],
        productImgs: List<ProductImg>.from(
            json["product_imgs"].map((x) => ProductImg.fromJson(x))),
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
        "how_many_variation": howManyVariation,
        "product_name": productName,
        "quantity": quantity,
        "product_price": productPrice,
        "product_discount": productDiscount,
        "product_sale_price": productSalePrice,
        "product_specification": productSpecification,
        "product_description": productDescription,
        "vendor_company_name": vendorCompanyName,
        "product_stock_status": productStockStatus,
        "product_imgs": List<dynamic>.from(productImgs.map((x) => x.toJson())),
        "product_in_user_wishlist": productInUserWishlist,
      };
}

class ProductImg {
  ProductImg({
    this.productImg,
  });

  String productImg;

  factory ProductImg.fromJson(Map<String, dynamic> json) => ProductImg(
        productImg: json["product_img"],
      );

  Map<String, dynamic> toJson() => {
        "product_img": productImg,
      };
}
