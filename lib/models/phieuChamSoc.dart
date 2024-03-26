// To parse this JSON data, do
//
//     final phieuChamSoc = phieuChamSocFromJson(jsonString);

import 'dart:convert';

PhieuChamSoc phieuChamSocFromJson(String str) =>
    PhieuChamSoc.fromJson(json.decode(str));

String phieuChamSocToJson(PhieuChamSoc data) => json.encode(data.toJson());

class PhieuChamSoc {
  bool success;
  List<PhieuChamSocData> data;
  String message;

  PhieuChamSoc({
    required this.success,
    required this.data,
    required this.message,
  });

  factory PhieuChamSoc.fromJson(Map<String, dynamic> json) => PhieuChamSoc(
        success: json["success"],
        data: List<PhieuChamSocData>.from(
            json["data"].map((x) => PhieuChamSocData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class PhieuChamSocData {
  String maphieu;
  DateTime ngaylap;
  dynamic nguoilap;
  dynamic chandoan;
  dynamic dienbien;
  dynamic ylenh;
  dynamic soluongChuky;
  dynamic soluongDaky;

  PhieuChamSocData({
    required this.maphieu,
    required this.ngaylap,
    required this.nguoilap,
    required this.chandoan,
    required this.dienbien,
    required this.ylenh,
    required this.soluongChuky,
    required this.soluongDaky,
  });

  factory PhieuChamSocData.fromJson(Map<String, dynamic> json) =>
      PhieuChamSocData(
        maphieu: json["maphieu"],
        ngaylap: DateTime.parse(json["ngaylap"]),
        nguoilap: json["nguoilap"],
        chandoan: json["chandoan"],
        dienbien: json["dienbien"],
        ylenh: json["ylenh"],
        soluongChuky: json["soluong_chuky"],
        soluongDaky: json["soluong_daky"],
      );

  Map<String, dynamic> toJson() => {
        "maphieu": maphieu,
        "ngaylap": ngaylap.toIso8601String(),
        "nguoilap": nguoilap,
        "chandoan": chandoan,
        "dienbien": dienbien,
        "ylenh": ylenh,
        "soluong_chuky": soluongChuky,
        "soluong_daky": soluongDaky,
      };
}

class LuuPhieuChamSoc {
  String mahs;
  String mabn;
  String manhapvien;
  String manamvien;
  String makhoa;
  String maphong;
  dynamic chandoanicd;
  dynamic chandoan;
  dynamic maphieu;
  DateTime ngaylap;
  dynamic dienbien;
  dynamic ylenh;

  LuuPhieuChamSoc({
    required this.mahs,
    required this.mabn,
    required this.manhapvien,
    required this.manamvien,
    required this.makhoa,
    required this.maphong,
    required this.chandoanicd,
    required this.chandoan,
    required this.maphieu,
    required this.ngaylap,
    required this.dienbien,
    required this.ylenh,
  });

  factory LuuPhieuChamSoc.fromJson(Map<String, dynamic> json) =>
      LuuPhieuChamSoc(
        mahs: json["mahs"],
        mabn: json["mabn"],
        manhapvien: json["manhapvien"],
        manamvien: json["manamvien"],
        makhoa: json["makhoa"],
        maphong: json["maphong"],
        chandoanicd: json["chandoanicd"],
        chandoan: json["chandoan"],
        maphieu: json["maphieu"],
        ngaylap: DateTime.parse(json["ngaylap"]),
        dienbien: json["dienbien"],
        ylenh: json["ylenh"],
      );

  Map<String, dynamic> toJson() => {
        "mahs": mahs,
        "mabn": mabn,
        "manhapvien": manhapvien,
        "manamvien": manamvien,
        "makhoa": makhoa,
        "maphong": maphong,
        "chandoanicd": chandoanicd,
        "chandoan": chandoan,
        "maphieu": maphieu,
        "ngaylap": ngaylap.toIso8601String(),
        "dienbien": dienbien,
        "ylenh": ylenh,
      };
}

class OutputPhieuChamSoc {
  bool success;
  //List<dynamic> data;
  String message;

  OutputPhieuChamSoc({
    required this.success,
    // required this.data,
    required this.message,
  });

  factory OutputPhieuChamSoc.fromJson(Map<String, dynamic> json) =>
      OutputPhieuChamSoc(
        success: json["success"],
        //data: List<dynamic>.from(json["data"].map((x) => x)),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        //"data": List<dynamic>.from(data.map((x) => x)),
        "message": message,
      };
}
