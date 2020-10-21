import 'dart:convert';

HomePageModel homePageModelFromJson(String str) =>
    HomePageModel.fromJson(json.decode(str));

String homePageModelToJson(HomePageModel data) => json.encode(data.toJson());

class HomePageModel {
  HomePageModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory HomePageModel.fromJson(Map<String, dynamic> json) => HomePageModel(
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
    this.homeBanner,
    this.category,
    this.product,
    this.school,
    this.vendor,
  });

  List<HomeBanner> homeBanner;
  List<Category> category;
  List<Product> product;
  List<School> school;
  List<Vendor> vendor;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        homeBanner: List<HomeBanner>.from(
            json["home_banner"].map((x) => HomeBanner.fromJson(x))),
        category: List<Category>.from(
            json["category"].map((x) => Category.fromJson(x))),
        product:
            List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
        school:
            List<School>.from(json["school"].map((x) => School.fromJson(x))),
        vendor:
            List<Vendor>.from(json["vendor"].map((x) => Vendor.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "home_banner": List<dynamic>.from(homeBanner.map((x) => x.toJson())),
        "category": List<dynamic>.from(category.map((x) => x.toJson())),
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
        "school": List<dynamic>.from(school.map((x) => x.toJson())),
        "vendor": List<dynamic>.from(vendor.map((x) => x.toJson())),
      };
}

class Category {
  Category({
    this.categoryId,
    this.catSlug,
    this.categoryImg,
    this.categoryName,
  });

  String categoryId;
  String catSlug;
  String categoryImg;
  String categoryName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["category_id"],
        catSlug: json["cat_slug"],
        categoryImg: json["category_img"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "cat_slug": catSlug,
        "category_img": categoryImg,
        "category_name": categoryName,
      };
}

class HomeBanner {
  HomeBanner({
    this.homeBannerId,
    this.img,
    this.text,
    this.link,
  });

  String homeBannerId;
  String img;
  String text;
  String link;

  factory HomeBanner.fromJson(Map<String, dynamic> json) => HomeBanner(
        homeBannerId: json["home_banner_id"],
        img: json["img"],
        text: json["text"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "home_banner_id": homeBannerId,
        "img": img,
        "text": text,
        "link": link,
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
    this.additionalSet,
    this.categoryName,
    this.productImg,
    this.productName,
    this.author,
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
  String author;
  String language;
  String bookType;
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
        additionalSet: json["additional_set"],
        categoryName: json["category_name"],
        productImg: json["Product_img"],
        productName: json["product_name"],
        author: json["author"],
        language: json["language"],
        bookType: json["book_type"],
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
        "additional_set": additionalSet,
        "category_name": categoryName,
        "Product_img": productImg,
        "product_name": productName,
        "author": author,
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

class School {
  School({
    this.schoolId,
    this.schoolLogo,
    this.schoolName,
    this.board,
    this.schoolBanners,
  });

  String schoolId;
  String schoolLogo;
  String schoolName;
  String board;
  List<SchoolBanner> schoolBanners;

  factory School.fromJson(Map<String, dynamic> json) => School(
        schoolId: json["school_id"],
        schoolLogo: json["school_logo"],
        schoolName: json["school_name"],
        board: json["board"],
        schoolBanners: List<SchoolBanner>.from(
            json["school_banners"].map((x) => SchoolBanner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "school_id": schoolId,
        "school_logo": schoolLogo,
        "school_name": schoolName,
        "board": board,
        "school_banners":
            List<dynamic>.from(schoolBanners.map((x) => x.toJson())),
      };
}

class SchoolBanner {
  SchoolBanner({
    this.schoolImg,
  });

  String schoolImg;

  factory SchoolBanner.fromJson(Map<String, dynamic> json) => SchoolBanner(
        schoolImg: json["school_img"],
      );

  Map<String, dynamic> toJson() => {
        "school_img": schoolImg,
      };
}

class Vendor {
  Vendor({
    this.vendorId,
    this.fname,
    this.lname,
    this.companyName,
    this.companyLogo,
  });

  String vendorId;
  String fname;
  String lname;
  String companyName;
  String companyLogo;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        vendorId: json["vendor_id"],
        fname: json["fname"],
        lname: json["lname"],
        companyName: json["company_name"],
        companyLogo: json["company_logo"],
      );

  Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
        "fname": fname,
        "lname": lname,
        "company_name": companyName,
        "company_logo": companyLogo,
      };
}
