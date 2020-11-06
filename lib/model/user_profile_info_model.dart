// To parse this JSON data, do
//
//     final userProfileInfoModel = userProfileInfoModelFromJson(jsonString);

import 'dart:convert';

UserProfileInfoModel userProfileInfoModelFromJson(String str) => UserProfileInfoModel.fromJson(json.decode(str));

String userProfileInfoModelToJson(UserProfileInfoModel data) => json.encode(data.toJson());

class UserProfileInfoModel {
  UserProfileInfoModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory UserProfileInfoModel.fromJson(Map<String, dynamic> json) => UserProfileInfoModel(
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
    this.userId,
    this.userSlug,
    this.fname,
    this.lname,
    this.email,
    this.mobile,
    this.profilePic,
    this.emailHash,
    this.dob,
    this.gender,
    this.isMobileVerified,
  });

  String userId;
  String userSlug;
  String fname;
  String lname;
  String email;
  String mobile;
  String profilePic;
  String emailHash;
  DateTime dob;
  String gender;
  String isMobileVerified;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    userId: json["user_id"],
    userSlug: json["user_slug"],
    fname: json["fname"],
    lname: json["lname"],
    email: json["email"],
    mobile: json["mobile"],
    profilePic: json["profile_pic"],
    emailHash: json["email_hash"],
    dob: DateTime.parse(json["dob"]),
    gender: json["gender"],
    isMobileVerified: json["is_mobile_verified"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_slug": userSlug,
    "fname": fname,
    "lname": lname,
    "email": email,
    "mobile": mobile,
    "profile_pic": profilePic,
    "email_hash": emailHash,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "is_mobile_verified": isMobileVerified,
  };
}
