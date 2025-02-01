// To parse this JSON data, do
//
//     final pricingModel = pricingModelFromJson(jsonString);

import 'dart:convert';

PricingApiModel pricingModelFromJson(String str) =>
    PricingApiModel.fromJson(json.decode(str));

String pricingModelToJson(PricingApiModel data) => json.encode(data.toJson());

class PricingApiModel {
  List<Datum>? data;

  PricingApiModel({
    this.data,
  });

  factory PricingApiModel.fromJson(Map<String, dynamic> json) =>
      PricingApiModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? pCode;
  String? pDescription;
  String? pAmount;
  String? pDuration;
  String? pkgName;
  String? comboOffer;
  String? alertMsg;
  String? couponCode;
  int? srNo;
  String? pTotaAmount;

  Datum({
    this.pCode,
    this.pDescription,
    this.pAmount,
    this.pDuration,
    this.pkgName,
    this.comboOffer,
    this.alertMsg,
    this.couponCode,
    this.srNo,
    this.pTotaAmount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        pCode: json["PCode"],
        pDescription: json["PDescription"],
        pAmount: json["PAmount"],
        pDuration: json["PDuration"],
        pkgName: json["PKGName"],
        comboOffer: json["ComboOffer"],
        alertMsg: json["AlertMsg"],
        couponCode: json["CouponCode"],
        srNo: json["SrNo"],
        pTotaAmount: json["PTotaAmount"],
      );

  Map<String, dynamic> toJson() => {
        "PCode": pCode,
        "PDescription": pDescription,
        "PAmount": pAmount,
        "PDuration": pDuration,
        "PKGName": pkgName,
        "ComboOffer": comboOffer,
        "AlertMsg": alertMsg,
        "CouponCode": couponCode,
        "SrNo": srNo,
        "PTotaAmount": pTotaAmount,
      };
}
