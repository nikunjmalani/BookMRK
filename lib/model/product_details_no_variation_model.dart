// To parse this JSON data, do
//
//     final productDetailsNoVariationModel = productDetailsNoVariationModelFromJson(jsonString);

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
    this.additionalSet,
    this.variation,
    this.howManyVariation,
    this.variationsDetails,
    this.additionalSetDetails,
    this.productName,
    this.author,
    this.publisher,
    this.responseClass,
    this.subject,
    this.language,
    this.bookType,
    this.quantity,
    this.productPrice,
    this.productDiscount,
    this.productSalePrice,
    this.productAdditionalSetTotalPrice,
    this.productSpecification,
    this.productDescription,
    this.vendorCompanyName,
    this.productStockStatus,
    this.productImgs,
    this.productInUserWishlist,
    this.productShareLink,
  });

  String productId;
  String productSlug;
  String vendorSlug;
  String schoolSlug;
  String type;
  String productType;
  String additionalSet;
  String variation;
  String howManyVariation;
  List<VariationsDetail> variationsDetails;
  List<dynamic> additionalSetDetails;
  String productName;
  List<dynamic> author;
  List<dynamic> publisher;
  List<dynamic> responseClass;
  List<dynamic> subject;
  String language;
  String bookType;
  String quantity;
  String productPrice;
  String productDiscount;
  String productSalePrice;
  String productAdditionalSetTotalPrice;
  String productSpecification;
  String productDescription;
  String vendorCompanyName;
  String productStockStatus;
  List<ProductImg> productImgs;
  String productInUserWishlist;
  String productShareLink;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
      productId: json["product_id"],
      productSlug: json["product_slug"],
      vendorSlug: json["vendor_slug"],
      schoolSlug: json["school_slug"],
      type: json["type"],
      productType: json["product_type"],
      additionalSet: json["additional_set"],
      variation: json["variation"],
      howManyVariation: json["how_many_variation"],
      variationsDetails: List<VariationsDetail>.from(
          json["variations_details"].map((x) => VariationsDetail.fromJson(x))),
      additionalSetDetails:
          List<dynamic>.from(json["additional_set_details"].map((x) => x)),
      productName: json["product_name"],
      author: List<dynamic>.from(json["author"].map((x) => x)),
      publisher: List<dynamic>.from(json["publisher"].map((x) => x)),
      responseClass: List<dynamic>.from(json["class"].map((x) => x)),
      subject: List<dynamic>.from(json["subject"].map((x) => x)),
      language: json["language"],
      bookType: json["book_type"],
      quantity: json["quantity"],
      productPrice: json["product_price"],
      productDiscount: json["product_discount"],
      productSalePrice: json["product_sale_price"],
      productAdditionalSetTotalPrice:
          json["product_additional_set_total_price"],
      productSpecification: json["product_specification"],
      productDescription: json["product_description"],
      vendorCompanyName: json["vendor_company_name"],
      productStockStatus: json["product_stock_status"],
      productImgs: List<ProductImg>.from(
          json["product_imgs"].map((x) => ProductImg.fromJson(x))),
      productInUserWishlist: json["product_in_user_wishlist"],
      productShareLink: json["product_share_link"]);

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_slug": productSlug,
        "vendor_slug": vendorSlug,
        "school_slug": schoolSlug,
        "type": type,
        "product_type": productType,
        "additional_set": additionalSet,
        "variation": variation,
        "how_many_variation": howManyVariation,
        "variations_details":
            List<dynamic>.from(variationsDetails.map((x) => x.toJson())),
        "additional_set_details":
            List<dynamic>.from(additionalSetDetails.map((x) => x)),
        "product_name": productName,
        "author": List<dynamic>.from(author.map((x) => x)),
        "publisher": List<dynamic>.from(publisher.map((x) => x)),
        "class": List<dynamic>.from(responseClass.map((x) => x)),
        "subject": List<dynamic>.from(subject.map((x) => x)),
        "language": language,
        "book_type": bookType,
        "quantity": quantity,
        "product_price": productPrice,
        "product_discount": productDiscount,
        "product_sale_price": productSalePrice,
        "product_additional_set_total_price": productAdditionalSetTotalPrice,
        "product_specification": productSpecification,
        "product_description": productDescription,
        "vendor_company_name": vendorCompanyName,
        "product_stock_status": productStockStatus,
        "product_imgs": List<dynamic>.from(productImgs.map((x) => x.toJson())),
        "product_in_user_wishlist": productInUserWishlist,
        "product_share_link": productShareLink
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

class VariationsDetail {
  VariationsDetail({
    this.variationName,
    this.variationsDisplay,
    this.varValue,
  });

  String variationName;
  String variationsDisplay;
  List<VarValue> varValue;

  factory VariationsDetail.fromJson(Map<String, dynamic> json) =>
      VariationsDetail(
        variationName: json["variation_name"],
        variationsDisplay: json["variations_display"],
        varValue: List<VarValue>.from(
            json["var_value"].map((x) => VarValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "variation_name": variationName,
        "variations_display": variationsDisplay,
        "var_value": List<dynamic>.from(varValue.map((x) => x.toJson())),
      };
}

class VarValue {
  VarValue({
    this.variationName,
    this.variationsDataId,
    this.variationsOptionsName,
    this.productId,
    this.varImg,
  });

  String variationName;
  String variationsDataId;
  String variationsOptionsName;
  String productId;
  String varImg;

  factory VarValue.fromJson(Map<String, dynamic> json) => VarValue(
        variationName: json["variation_name"],
        variationsDataId: json["variations_data_id"],
        variationsOptionsName: json["variations_options_name"],
        productId: json["product_id"],
        varImg: json["var_img"],
      );

  Map<String, dynamic> toJson() => {
        "variation_name": variationName,
        "variations_data_id": variationsDataId,
        "variations_options_name": variationsOptionsName,
        "product_id": productId,
        "var_img": varImg,
      };
}
