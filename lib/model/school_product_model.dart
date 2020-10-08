import 'dart:convert';

SchoolProductsModel schoolProductsModelFromJson(String str) =>
    SchoolProductsModel.fromJson(json.decode(str));

String schoolProductsModelToJson(SchoolProductsModel data) =>
    json.encode(data.toJson());

class SchoolProductsModel {
  SchoolProductsModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory SchoolProductsModel.fromJson(Map<String, dynamic> json) =>
      SchoolProductsModel(
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
    this.school,
    this.schoolCat,
    this.schoolCatProduct,
    this.schoolAllProduct,
  });

  List<School> school;
  List<SchoolCat> schoolCat;
  List<dynamic> schoolCatProduct;
  List<SchoolAllProduct> schoolAllProduct;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        school:
            List<School>.from(json["school"].map((x) => School.fromJson(x))),
        schoolCat: List<SchoolCat>.from(
            json["school_cat"].map((x) => SchoolCat.fromJson(x))),
        schoolCatProduct:
            List<dynamic>.from(json["school_cat_product"].map((x) => x)),
        schoolAllProduct: List<SchoolAllProduct>.from(json["school_all_product"]
            .map((x) => SchoolAllProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "school": List<dynamic>.from(school.map((x) => x.toJson())),
        "school_cat": List<dynamic>.from(schoolCat.map((x) => x.toJson())),
        "school_cat_product":
            List<dynamic>.from(schoolCatProduct.map((x) => x)),
        "school_all_product":
            List<dynamic>.from(schoolAllProduct.map((x) => x.toJson())),
      };
}

class School {
  School({
    this.schoolId,
    this.schoolSlug,
    this.schoolLogo,
    this.schoolName,
    this.board,
    this.address,
    this.countries,
    this.state,
    this.city,
    this.pincode,
    this.landmark,
    this.schoolBanners,
  });

  String schoolId;
  String schoolSlug;
  String schoolLogo;
  String schoolName;
  String board;
  String address;
  String countries;
  String state;
  String city;
  String pincode;
  String landmark;
  List<dynamic> schoolBanners;

  factory School.fromJson(Map<String, dynamic> json) => School(
        schoolId: json["school_id"],
        schoolSlug: json["school_slug"],
        schoolLogo: json["school_logo"],
        schoolName: json["school_name"],
        board: json["board"],
        address: json["address"],
        countries: json["countries"],
        state: json["state"],
        city: json["city"],
        pincode: json["pincode"],
        landmark: json["landmark"],
        schoolBanners: List<dynamic>.from(json["school_banners"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "school_id": schoolId,
        "school_slug": schoolSlug,
        "school_logo": schoolLogo,
        "school_name": schoolName,
        "board": board,
        "address": address,
        "countries": countries,
        "state": state,
        "city": city,
        "pincode": pincode,
        "landmark": landmark,
        "school_banners": List<dynamic>.from(schoolBanners.map((x) => x)),
      };
}

class SchoolAllProduct {
  SchoolAllProduct({
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

  factory SchoolAllProduct.fromJson(Map<String, dynamic> json) =>
      SchoolAllProduct(
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

class SchoolCat {
  SchoolCat({
    this.categoryId,
    this.categoryImg,
    this.categoryName,
  });

  String categoryId;
  String categoryImg;
  String categoryName;

  factory SchoolCat.fromJson(Map<String, dynamic> json) => SchoolCat(
        categoryId: json["category_id"],
        categoryImg: json["category_img"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_img": categoryImg,
        "category_name": categoryName,
      };
}
