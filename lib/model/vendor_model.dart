import 'dart:convert';

VendorModel vendorModelFromJson(String str) =>
    VendorModel.fromJson(json.decode(str));

String vendorModelToJson(VendorModel data) => json.encode(data.toJson());

class VendorModel {
  VendorModel({
    this.status,
    this.message,
    this.count,
    this.response,
  });

  int status;
  String message;
  int count;
  List<Response> response;

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
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
    this.vendorId,
    this.vendorSlug,
    this.vendorName,
    this.companyName,
    this.companyLogo,
  });

  String vendorId;
  String vendorSlug;
  String vendorName;
  String companyName;
  String companyLogo;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        vendorId: json["vendor_id"],
        vendorSlug: json["vendor_slug"],
        vendorName: json["vendor_name"],
        companyName: json["company_name"],
        companyLogo: json["company_logo"],
      );

  Map<String, dynamic> toJson() => {
        "vendor_id": vendorId,
        "vendor_slug": vendorSlug,
        "vendor_name": vendorName,
        "company_name": companyName,
        "company_logo": companyLogo,
      };
}
