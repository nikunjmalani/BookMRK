import 'dart:convert';

SchoolListModel schoolListModelFromJson(String str) =>
    SchoolListModel.fromJson(json.decode(str));

String schoolListModelToJson(SchoolListModel data) =>
    json.encode(data.toJson());

class SchoolListModel {
  SchoolListModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory SchoolListModel.fromJson(Map<String, dynamic> json) =>
      SchoolListModel(
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
    this.isSchoolSecure,
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
  String isSchoolSecure;
  String landmark;
  List<dynamic> schoolBanners;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
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
        isSchoolSecure: json["is_school_secure"],
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
