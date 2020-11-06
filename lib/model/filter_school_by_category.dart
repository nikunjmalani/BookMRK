import 'dart:convert';

FilterSchoolByLocation filterSchoolByLocationFromJson(String str) => FilterSchoolByLocation.fromJson(json.decode(str));

String filterSchoolByLocationToJson(FilterSchoolByLocation data) => json.encode(data.toJson());

class FilterSchoolByLocation {
  FilterSchoolByLocation({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory FilterSchoolByLocation.fromJson(Map<String, dynamic> json) => FilterSchoolByLocation(
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
  List<SchoolBanner> schoolBanners;

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
    schoolBanners: List<SchoolBanner>.from(json["school_banners"].map((x) => SchoolBanner.fromJson(x))),
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
    "school_banners": List<dynamic>.from(schoolBanners.map((x) => x.toJson())),
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
