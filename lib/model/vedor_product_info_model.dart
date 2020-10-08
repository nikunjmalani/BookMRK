import 'dart:convert';

VendorProductInfoModel vendorProductInfoModelFromJson(String str) =>
    VendorProductInfoModel.fromJson(json.decode(str));

String vendorProductInfoModelToJson(VendorProductInfoModel data) =>
    json.encode(data.toJson());

class VendorProductInfoModel {
  VendorProductInfoModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory VendorProductInfoModel.fromJson(Map<String, dynamic> json) =>
      VendorProductInfoModel(
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
    this.vendor,
    this.vendorProduct,
  });

  Vendor vendor;
  List<VendorProduct> vendorProduct;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        vendor: Vendor.fromJson(json["vendor"]),
        vendorProduct: List<VendorProduct>.from(
            json["vendor_product"].map((x) => VendorProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vendor": vendor.toJson(),
        "vendor_product":
            List<dynamic>.from(vendorProduct.map((x) => x.toJson())),
      };
}

class Vendor {
  Vendor({
    this.vendorId,
    this.vendorSlug,
    this.vendorName,
    this.companyName,
    this.companyLogo,
    this.allProductsCount,
    this.allSchoolCount,
  });

  String vendorId;
  String vendorSlug;
  String vendorName;
  String companyName;
  String companyLogo;
  String allProductsCount;
  String allSchoolCount;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        vendorId: json["vendor_id"],
        vendorSlug: json["vendor_slug"],
        vendorName: json["vendor_name"],
        companyName: json["company_name"],
        companyLogo: json["company_logo"],
        allProductsCount: json["all_products_count"],
        allSchoolCount: json["all_school_count"],
      );

  Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
        "vendor_slug": vendorSlug,
        "vendor_name": vendorName,
        "company_name": companyName,
        "company_logo": companyLogo,
        "all_products_count": allProductsCount,
        "all_school_count": allSchoolCount,
      };
}

class VendorProduct {
  VendorProduct({
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

  factory VendorProduct.fromJson(Map<String, dynamic> json) => VendorProduct(
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
