import 'dart:convert';

EditAddressInfoModel editAddressInfoModelFromJson(String str) =>
    EditAddressInfoModel.fromJson(json.decode(str));

String editAddressInfoModelToJson(EditAddressInfoModel data) =>
    json.encode(data.toJson());

class EditAddressInfoModel {
  EditAddressInfoModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory EditAddressInfoModel.fromJson(Map<String, dynamic> json) =>
      EditAddressInfoModel(
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
    this.countriesId,
    this.countries,
    this.stateId,
    this.state,
    this.cityId,
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
  String countriesId;
  String countries;
  String stateId;
  String state;
  String cityId;
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
        countriesId: json["countries_id"],
        countries: json["countries"],
        stateId: json["state_id"],
        state: json["state"],
        cityId: json["city_id"],
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
        "countries_id": countriesId,
        "countries": countries,
        "state_id": stateId,
        "state": state,
        "city_id": cityId,
        "city": city,
        "address1": address1,
        "address2": address2,
        "pincode": pincode,
        "is_selected": isSelected,
      };
}
