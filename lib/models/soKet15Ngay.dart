// To parse this JSON data, do
//
//     final soKet15Ngay = soKet15NgayFromJson(jsonString);

import 'dart:convert';

SoKet15Ngay soKet15NgayFromJson(String str) =>
    SoKet15Ngay.fromJson(json.decode(str));

String soKet15NgayToJson(SoKet15Ngay data) => json.encode(data.toJson());

class SoKet15Ngay {
  bool success;
  List<SoKet15NgayData> data;
  String message;

  SoKet15Ngay({
    required this.success,
    required this.data,
    required this.message,
  });

  factory SoKet15Ngay.fromJson(Map<String, dynamic> json) => SoKet15Ngay(
        success: json["success"],
        data: List<SoKet15NgayData>.from(
            json["data"].map((x) => SoKet15NgayData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class SoKet15NgayData {
  DateTime ngaylap;
  DateTime ngaykyBacsi;
  DateTime ngaykyTruongkhoa;
  dynamic tenbs;
  dynamic dienbienlamsang;
  dynamic xetnghiemcls;
  dynamic quatrinhdieutri;
  dynamic danhgiaketqua;
  dynamic huongdieutri;

  SoKet15NgayData({
    required this.ngaylap,
    required this.ngaykyBacsi,
    required this.ngaykyTruongkhoa,
    required this.tenbs,
    required this.dienbienlamsang,
    required this.xetnghiemcls,
    required this.quatrinhdieutri,
    required this.danhgiaketqua,
    required this.huongdieutri,
  });

  factory SoKet15NgayData.fromJson(Map<String, dynamic> json) =>
      SoKet15NgayData(
        ngaylap: DateTime.parse(json["ngaylap"]),
        ngaykyBacsi: DateTime.parse(json["ngayky_bacsi"]),
        ngaykyTruongkhoa: DateTime.parse(json["ngayky_truongkhoa"]),
        tenbs: json["tenbs"],
        dienbienlamsang: json["dienbienlamsang"],
        xetnghiemcls: json["xetnghiemcls"],
        quatrinhdieutri: json["quatrinhdieutri"],
        danhgiaketqua: json["danhgiaketqua"],
        huongdieutri: json["huongdieutri"],
      );

  Map<String, dynamic> toJson() => {
        "ngaylap": ngaylap.toIso8601String(),
        "ngayky_bacsi":
            "${ngaykyBacsi.year.toString().padLeft(4, '0')}-${ngaykyBacsi.month.toString().padLeft(2, '0')}-${ngaykyBacsi.day.toString().padLeft(2, '0')}",
        "ngayky_truongkhoa":
            "${ngaykyTruongkhoa.year.toString().padLeft(4, '0')}-${ngaykyTruongkhoa.month.toString().padLeft(2, '0')}-${ngaykyTruongkhoa.day.toString().padLeft(2, '0')}",
        "tenbs": tenbs,
        "dienbienlamsang": dienbienlamsang,
        "xetnghiemcls": xetnghiemcls,
        "quatrinhdieutri": quatrinhdieutri,
        "danhgiaketqua": danhgiaketqua,
        "huongdieutri": huongdieutri,
      };
}
