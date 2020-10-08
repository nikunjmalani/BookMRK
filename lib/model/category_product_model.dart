import 'dart:convert';

CategoryProductsModel categoryProductsModelFromJson(String str) =>
    CategoryProductsModel.fromJson(json.decode(str));

String categoryProductsModelToJson(CategoryProductsModel data) =>
    json.encode(data.toJson());

class CategoryProductsModel {
  CategoryProductsModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory CategoryProductsModel.fromJson(Map<String, dynamic> json) =>
      CategoryProductsModel(
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
    this.category,
    this.subCategory,
    this.product,
  });

  List<Category> category;
  List<Category> subCategory;
  List<Product> product;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        subCategory: List<Category>.from(
            json["sub_category"].map((x) => Category.fromJson(x))),
        product:
            List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "sub_category": List<dynamic>.from(subCategory.map((x) => x.toJson())),
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.categoryId,
    this.categoryImg,
    this.categoryName,
    this.allProductsCount,
  });

  String categoryId;
  String categoryImg;
  String categoryName;
  String allProductsCount;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        categoryImg: json["category_img"],
        categoryName: json["category_name"],
        allProductsCount: json["all_products_count"] == null
            ? null
            : json["all_products_count"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_img": categoryImg,
        "category_name": categoryName,
        "all_products_count":
            allProductsCount == null ? null : allProductsCount,
      };
}

class Product {
  Product({
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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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
