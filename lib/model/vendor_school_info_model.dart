import 'dart:convert';

VendorSchoolInfoModel vendorSchoolInfoModelFromJson(String str) =>
    VendorSchoolInfoModel.fromJson(json.decode(str));

String vendorSchoolInfoModelToJson(VendorSchoolInfoModel data) =>
    json.encode(data.toJson());

class VendorSchoolInfoModel {
  VendorSchoolInfoModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory VendorSchoolInfoModel.fromJson(Map<String, dynamic> json) =>
      VendorSchoolInfoModel(
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
    this.vendor,
    this.vendorSchool,
  });

  Vendor vendor;
  List<VendorSchool> vendorSchool;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        vendor: Vendor.fromJson(json["vendor"]),
        vendorSchool: List<VendorSchool>.from(
            json["vendor_school"].map((x) => VendorSchool.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vendor": vendor.toJson(),
        "vendor_school":
            List<dynamic>.from(vendorSchool.map((x) => x.toJson())),
      };
}

class Vendor {
  Vendor({
    this.vendorId,
    this.vendorSlug,
    this.vendorName,
    this.companyName,
    this.companyLogo,
    this.allProductsCount,
    this.allSchoolCount,
  });

  String vendorId;
  String vendorSlug;
  String vendorName;
  String companyName;
  String companyLogo;
  String allProductsCount;
  String allSchoolCount;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        vendorId: json["vendor_id"],
        vendorSlug: json["vendor_slug"],
        vendorName: json["vendor_name"],
        companyName: json["company_name"],
        companyLogo: json["company_logo"],
        allProductsCount: json["all_products_count"],
        allSchoolCount: json["all_school_count"],
      );

  Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
        "vendor_slug": vendorSlug,
        "vendor_name": vendorName,
        "company_name": companyName,
        "company_logo": companyLogo,
        "all_products_count": allProductsCount,
        "all_school_count": allSchoolCount,
      };
}

class VendorSchool {
  VendorSchool({
    this.vendorId,
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

  String vendorId;
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
  List<dynamic> schoolBanners;

  factory VendorSchool.fromJson(Map<String, dynamic> json) => VendorSchool(
        vendorId: json["vendor_id"],
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
        schoolBanners: List<dynamic>.from(json["school_banners"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
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
