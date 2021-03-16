// To parse this JSON data, do
//
//     final homePageModel = homePageModelFromJson(jsonString);

import 'dart:convert';

HomePageModel homePageModelFromJson(String str) => HomePageModel.fromJson(json.decode(str));

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
    this.homeBanner,
    this.category,
    this.product,
    this.school,
    this.vendor,
    this.publisher,
    this.responseClass,
    this.subject,
    this.maintenanceScreen,
    this.popupScreen,
    this.appScreen,
  });

  List<HomeBanner> homeBanner;
  List<Category> category;
  List<Product> product;
  List<School> school;
  List<Vendor> vendor;
  List<Publisher> publisher;
  List<Class> responseClass;
  List<Subject> subject;
  List<Screen> maintenanceScreen;
  List<PopupScreen> popupScreen;
  List<Screen> appScreen;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    homeBanner: List<HomeBanner>.from(json["home_banner"].map((x) => HomeBanner.fromJson(x))),
    category: List<Category>.from(json["category"].map((x) => Category.fromJson(x))),
    product: List<Product>.from(json["product"].map((x) => Product.fromJson(x))),
    school: List<School>.from(json["school"].map((x) => School.fromJson(x))),
    vendor: List<Vendor>.from(json["vendor"].map((x) => Vendor.fromJson(x))),
    publisher: List<Publisher>.from(json["publisher"].map((x) => Publisher.fromJson(x))),
    responseClass: List<Class>.from(json["class"].map((x) => Class.fromJson(x))),
    subject: List<Subject>.from(json["subject"].map((x) => Subject.fromJson(x))),
    maintenanceScreen: List<Screen>.from(json["maintenance_screen"].map((x) => Screen.fromJson(x))),
    popupScreen: List<PopupScreen>.from(json["popup_screen"].map((x) => PopupScreen.fromJson(x))),
    appScreen: List<Screen>.from(json["app_screen"].map((x) => Screen.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "home_banner": List<dynamic>.from(homeBanner.map((x) => x.toJson())),
    "category": List<dynamic>.from(category.map((x) => x.toJson())),
    "product": List<dynamic>.from(product.map((x) => x.toJson())),
    "school": List<dynamic>.from(school.map((x) => x.toJson())),
    "vendor": List<dynamic>.from(vendor.map((x) => x.toJson())),
    "publisher": List<dynamic>.from(publisher.map((x) => x.toJson())),
    "class": List<dynamic>.from(responseClass.map((x) => x.toJson())),
    "subject": List<dynamic>.from(subject.map((x) => x.toJson())),
    "maintenance_screen": List<dynamic>.from(maintenanceScreen.map((x) => x.toJson())),
    "popup_screen": List<dynamic>.from(popupScreen.map((x) => x.toJson())),
    "app_screen": List<dynamic>.from(appScreen.map((x) => x.toJson())),
  };
}

class Screen {
  Screen({
    this.show,
    this.message,
  });

  String show;
  String message;

  factory Screen.fromJson(Map<String, dynamic> json) => Screen(
    show: json["show"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "show": show,
    "message": message,
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

class PopupScreen {
  PopupScreen({
    this.show,
    this.title,
    this.message,
  });

  String show;
  String title;
  String message;

  factory PopupScreen.fromJson(Map<String, dynamic> json) => PopupScreen(
    show: json["show"],
    title: json["title"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "show": show,
    "title": title,
    "message": message,
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
    this.publisher,
    this.productClass,
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
    this.productShareLink,
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
  List<Publisher> publisher;
  List<Class> productClass;
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
  String productShareLink;

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
    author: List<dynamic>.from(json["author"].map((x) => x)),
    publisher: List<Publisher>.from(json["publisher"].map((x) => Publisher.fromJson(x))),
    productClass: List<Class>.from(json["class"].map((x) => Class.fromJson(x))),
    subject: List<Subject>.from(json["subject"].map((x) => Subject.fromJson(x))),
    language: json["language"],
    bookType: json["book_type"],
    productPrice: json["product_price"],
    productDiscount: json["product_discount"],
    productSalePrice: json["product_sale_price"],
    quantity: json["quantity"],
    vendorCompanyName: json["vendor_company_name"],
    productStockStatus: json["product_stock_status"],
    productInUserWishlist: json["product_in_user_wishlist"],
    productShareLink: json["product_share_link"],
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
    "author": List<dynamic>.from(author.map((x) => x)),
    "publisher": List<dynamic>.from(publisher.map((x) => x.toJson())),
    "class": List<dynamic>.from(productClass.map((x) => x.toJson())),
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
    "product_share_link": productShareLink,
  };
}

class Class {
  Class({
    this.classId,
    this.classSlug,
    this.className,
    this.classImg,
    this.filterType,
  });

  String classId;
  String classSlug;
  String className;
  String classImg;
  ClassFilterType filterType;

  factory Class.fromJson(Map<String, dynamic> json) => Class(
    classId: json["class_id"],
    classSlug: json["class_slug"],
    className: json["class_name"],
    classImg: json["class_img"],
    filterType: classFilterTypeValues.map[json["filter_type"]],
  );

  Map<String, dynamic> toJson() => {
    "class_id": classId,
    "class_slug": classSlug,
    "class_name": className,
    "class_img": classImg,
    "filter_type": classFilterTypeValues.reverse[filterType],
  };
}

enum ClassFilterType { CLASS }

final classFilterTypeValues = EnumValues({
  "class": ClassFilterType.CLASS
});

class Publisher {
  Publisher({
    this.publisherId,
    this.publisherSlug,
    this.publisherName,
    this.publisherImg,
    this.filterType,
  });

  String publisherId;
  String publisherSlug;
  String publisherName;
  String publisherImg;
  PublisherFilterType filterType;

  factory Publisher.fromJson(Map<String, dynamic> json) => Publisher(
    publisherId: json["publisher_id"],
    publisherSlug: json["publisher_slug"],
    publisherName: json["publisher_name"],
    publisherImg: json["publisher_img"],
    filterType: publisherFilterTypeValues.map[json["filter_type"]],
  );

  Map<String, dynamic> toJson() => {
    "publisher_id": publisherId,
    "publisher_slug": publisherSlug,
    "publisher_name": publisherName,
    "publisher_img": publisherImg,
    "filter_type": publisherFilterTypeValues.reverse[filterType],
  };
}

enum PublisherFilterType { PUBLISHER }

final publisherFilterTypeValues = EnumValues({
  "publisher": PublisherFilterType.PUBLISHER
});

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
  SubjectFilterType filterType;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    subjectId: json["subject_id"],
    subjectSlug: json["subject_slug"],
    subjectName: json["subject_name"],
    subjectImg: json["subject_img"],
    filterType: subjectFilterTypeValues.map[json["filter_type"]],
  );

  Map<String, dynamic> toJson() => {
    "subject_id": subjectId,
    "subject_slug": subjectSlug,
    "subject_name": subjectName,
    "subject_img": subjectImg,
    "filter_type": subjectFilterTypeValues.reverse[filterType],
  };
}

enum SubjectFilterType { SUBJECT }

final subjectFilterTypeValues = EnumValues({
  "subject": SubjectFilterType.SUBJECT
});

class School {
  School({
    this.schoolId,
    this.schoolSlug,
    this.schoolLogo,
    this.schoolName,
    this.board,
    this.isSchoolSecure,
    this.schoolBanners,
  });

  String schoolId;
  String schoolSlug;
  String schoolLogo;
  String schoolName;
  Board board;
  String isSchoolSecure;
  List<SchoolBanner> schoolBanners;

  factory School.fromJson(Map<String, dynamic> json) => School(
    schoolId: json["school_id"],
    schoolSlug: json["school_slug"],
    schoolLogo: json["school_logo"],
    schoolName: json["school_name"],
    board: boardValues.map[json["board"]],
    isSchoolSecure: json["is_school_secure"],
    schoolBanners: List<SchoolBanner>.from(json["school_banners"].map((x) => SchoolBanner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "school_id": schoolId,
    "school_slug": schoolSlug,
    "school_logo": schoolLogo,
    "school_name": schoolName,
    "board": boardValues.reverse[board],
    "is_school_secure": isSchoolSecure,
    "school_banners": List<dynamic>.from(schoolBanners.map((x) => x.toJson())),
  };
}

enum Board { ICSE, CBSE }

final boardValues = EnumValues({
  "CBSE": Board.CBSE,
  "ICSE": Board.ICSE
});

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
    this.vendorSlug,
    this.fname,
    this.lname,
    this.companyName,
    this.companyLogo,
  });

  String vendorId;
  String vendorSlug;
  String fname;
  String lname;
  String companyName;
  String companyLogo;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    vendorId: json["vendor_id"],
    vendorSlug: json["vendor_slug"],
    fname: json["fname"],
    lname: json["lname"],
    companyName: json["company_name"],
    companyLogo: json["company_logo"],
  );

  Map<String, dynamic> toJson() => {
    "vendor_id": vendorId,
    "vendor_slug": vendorSlug,
    "fname": fname,
    "lname": lname,
    "company_name": companyName,
    "company_logo": companyLogo,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
