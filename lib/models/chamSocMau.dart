// To parse this JSON data, do
//
//     final chamSocMau = chamSocMauFromJson(jsonString);

import 'dart:convert';

ChamSocMau chamSocMauFromJson(String str) =>
    ChamSocMau.fromJson(json.decode(str));

String chamSocMauToJson(ChamSocMau data) => json.encode(data.toJson());

class ChamSocMau {
  bool success;
  List<ChamSocMauData> data;
  String message;

  ChamSocMau({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ChamSocMau.fromJson(Map<String, dynamic> json) => ChamSocMau(
        success: json["success"],
        data: List<ChamSocMauData>.from(
            json["data"].map((x) => ChamSocMauData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class ChamSocMauData {
  dynamic id;
  dynamic makhoa;
  dynamic tenphieumau;
  dynamic dienbien;
  dynamic ylenh;

  ChamSocMauData({
    required this.id,
    required this.makhoa,
    required this.tenphieumau,
    required this.dienbien,
    required this.ylenh,
  });

  factory ChamSocMauData.fromJson(Map<String, dynamic> json) => ChamSocMauData(
        id: json["id"],
        makhoa: json["makhoa"],
        tenphieumau: json["tenphieumau"],
        dienbien: json["dienbien"],
        ylenh: json["ylenh"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "makhoa": makhoa,
        "tenphieumau": tenphieumau,
        "dienbien": dienbien,
        "ylenh": ylenh,
      };
}
