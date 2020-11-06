import 'dart:convert';

SearchProductModel searchProductModelFromJson(String str) => SearchProductModel.fromJson(json.decode(str));

String searchProductModelToJson(SearchProductModel data) => json.encode(data.toJson());

class SearchProductModel {
  SearchProductModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory SearchProductModel.fromJson(Map<String, dynamic> json) => SearchProductModel(
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
    this.productId,
    this.productSlug,
    this.vendorSlug,
    this.schoolSlug,
    this.type,
    this.productType,
    this.variation,
    this.additionalSet,
    this.categoryName,
    this.productImg,
    this.productName,
    this.author,
    this.publisher,
    this.responseClass,
    this.subject,
    this.language,
    this.bookType,
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
  String additionalSet;
  String categoryName;
  String productImg;
  String productName;
  List<dynamic> author;
  List<dynamic> publisher;
  List<dynamic> responseClass;
  List<Subject> subject;
  String language;
  String bookType;
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
    schoolSlug:json["school_slug"],
    type: json["type"],
    productType: json["product_type"],
    variation: json["variation"],
    additionalSet: json["additional_set"],
    categoryName: json["category_name"],
    productImg: json["Product_img"],
    productName: json["product_name"],
    author: List<dynamic>.from(json["author"].map((x) => x)),
    publisher: List<dynamic>.from(json["publisher"].map((x) => x)),
    responseClass: List<dynamic>.from(json["class"].map((x) => x)),
    subject: List<Subject>.from(json["subject"].map((x) => Subject.fromJson(x))),
    language:json["language"],
    bookType: json["book_type"],
    productPrice: json["product_price"],
    productDiscount: json["product_discount"],
    productSalePrice: json["product_sale_price"],
    quantity: json["quantity"],
    vendorCompanyName:json["vendor_company_name"],
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
    "variation":variation,
    "additional_set": additionalSet,
    "category_name": categoryName,
    "Product_img": productImg,
    "product_name": productName,
    "author": List<dynamic>.from(author.map((x) => x)),
    "publisher": List<dynamic>.from(publisher.map((x) => x)),
    "class": List<dynamic>.from(responseClass.map((x) => x)),
    "subject": List<dynamic>.from(subject.map((x) => x.toJson())),
    "language": language,
    "book_type": bookType,
    "product_price": productPrice,
    "product_discount": productDiscount,
    "product_sale_price": productSalePrice,
    "quantity": quantity,
    "vendor_company_name": vendorCompanyName,
    "product_stock_status": productStockStatus,
    "product_in_user_wishlist": productInUserWishlist,
  };
}


class Subject {
  Subject({
    this.subjectId,
    this.subjectSlug,
    this.subjectName,
    this.subjectImg,
    this.filterType,
  });

  String subjectId;
  String subjectSlug;
  String subjectName;
  String subjectImg;
  String filterType;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    subjectId: json["subject_id"],
    subjectSlug: json["subject_slug"],
    subjectName: json["subject_name"],
    subjectImg: json["subject_img"],
    filterType: json["filter_type"],
  );

  Map<String, dynamic> toJson() => {
    "subject_id": subjectId,
    "subject_slug": subjectSlug,
    "subject_name":subjectName,
    "subject_img": subjectImg,
    "filter_type": filterType,
  };
}