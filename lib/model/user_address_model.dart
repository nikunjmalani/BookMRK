import 'dart:convert';

UserAddressModel userAddressModelFromJson(String str) =>
    UserAddressModel.fromJson(json.decode(str));

String userAddressModelToJson(UserAddressModel data) =>
    json.encode(data.toJson());

class UserAddressModel {
  UserAddressModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory UserAddressModel.fromJson(Map<String, dynamic> json) =>
      UserAddressModel(
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
    this.userAddressId,
    this.userId,
    this.fname,
    this.mname,
    this.lname,
    this.email,
    this.mobile,
    this.country,
    this.state,
    this.city,
    this.address1,
    this.address2,
    this.pincode,
    this.isSelected,
  });

  String userAddressId;
  String userId;
  String fname;
  String mname;
  String lname;
  String email;
  String mobile;
  String country;
  String state;
  String city;
  String address1;
  String address2;
  String pincode;
  String isSelected;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        userAddressId: json["user_address_id"],
        userId: json["user_id"],
        fname: json["fname"],
        mname: json["mname"],
        lname: json["lname"],
        email: json["email"],
        mobile: json["mobile"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        address1: json["address1"],
        address2: json["address2"],
        pincode: json["pincode"],
        isSelected: json["is_selected"],
      );

  Map<String, dynamic> toJson() => {
        "user_address_id": userAddressId,
        "user_id": userId,
        "fname": fname,
        "mname": mname,
        "lname": lname,
        "email": email,
        "mobile": mobile,
        "country": country,
        "state": state,
        "city": city,
        "address1": address1,
        "address2": address2,
        "pincode": pincode,
        "is_selected": isSelected,
      };
}
