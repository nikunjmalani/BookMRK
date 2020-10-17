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
  List<dynamic> variationsDetails;
  List<AdditionalSetDetail> additionalSetDetails;
  String productName;
  String author;
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
        variationsDetails:
            List<dynamic>.from(json["variations_details"].map((x) => x)),
        additionalSetDetails: List<AdditionalSetDetail>.from(
            json["additional_set_details"]
                .map((x) => AdditionalSetDetail.fromJson(x))),
        productName: json["product_name"],
        author: json["author"],
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
      );

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
            List<dynamic>.from(variationsDetails.map((x) => x)),
        "additional_set_details":
            List<dynamic>.from(additionalSetDetails.map((x) => x.toJson())),
        "product_name": productName,
        "author": author,
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
      };
}

class AdditionalSetDetail {
  AdditionalSetDetail({
    this.pasId,
    this.isMandatory,
    this.optionName,
    this.optionPrice,
    this.optionDiscount,
    this.optionSalePrice,
    this.optionProductDescription,
  });

  String pasId;
  String isMandatory;
  String optionName;
  String optionPrice;
  String optionDiscount;
  String optionSalePrice;
  String optionProductDescription;

  factory AdditionalSetDetail.fromJson(Map<String, dynamic> json) =>
      AdditionalSetDetail(
        pasId: json["pas_id"],
        isMandatory: json["is_mandatory"],
        optionName: json["option_name"],
        optionPrice: json["option_price"],
        optionDiscount: json["option_discount"],
        optionSalePrice: json["option_sale_price"],
        optionProductDescription: json["option_product_description"],
      );

  Map<String, dynamic> toJson() => {
        "pas_id": pasId,
        "is_mandatory": isMandatory,
        "option_name": optionName,
        "option_price": optionPrice,
        "option_discount": optionDiscount,
        "option_sale_price": optionSalePrice,
        "option_product_description": optionProductDescription,
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
