import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) =>
    CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) =>
    json.encode(data.toJson());

class CategoryListModel {
  CategoryListModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory CategoryListModel.fromJson(Map<String, dynamic> json) =>
      CategoryListModel(
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
    this.categoryImg,
    this.categoryName,
  });

  String categoryId;
  String categoryImg;
  String categoryName;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
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
