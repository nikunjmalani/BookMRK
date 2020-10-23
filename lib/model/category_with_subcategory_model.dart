import 'dart:convert';

CategoryWithSubcategoryListModel categoryWithSubcategoryListModelFromJson(
        String str) =>
    CategoryWithSubcategoryListModel.fromJson(json.decode(str));

String categoryWithSubcategoryListModelToJson(
        CategoryWithSubcategoryListModel data) =>
    json.encode(data.toJson());

class CategoryWithSubcategoryListModel {
  CategoryWithSubcategoryListModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory CategoryWithSubcategoryListModel.fromJson(
          Map<String, dynamic> json) =>
      CategoryWithSubcategoryListModel(
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
    this.categoryId,
    this.catSlug,
    this.categoryName,
    this.categoryImg,
    this.subCategoryCount,
    this.subCategory,
  });

  String categoryId;
  String catSlug;
  String categoryName;
  String categoryImg;
  int subCategoryCount;
  List<SubCategory> subCategory;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        categoryId: json["category_id"],
        catSlug: json["cat_slug"],
        categoryName: json["category_name"],
        categoryImg: json["category_img"],
        subCategoryCount: json["sub_category_count"],
        subCategory: List<SubCategory>.from(
            json["sub_category"].map((x) => SubCategory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "cat_slug": catSlug,
        "category_name": categoryName,
        "category_img": categoryImg,
        "sub_category_count": subCategoryCount,
        "sub_category": List<dynamic>.from(subCategory.map((x) => x.toJson())),
      };
}

class SubCategory {
  SubCategory({
    this.categoryId,
    this.catSlug,
    this.categoryName,
    this.categoryImg,
  });

  String categoryId;
  String catSlug;
  String categoryName;
  String categoryImg;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        categoryId: json["category_id"],
        catSlug: json["cat_slug"],
        categoryName: json["category_name"],
        categoryImg: json["category_img"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "cat_slug": catSlug,
        "category_name": categoryName,
        "category_img": categoryImg,
      };
}
