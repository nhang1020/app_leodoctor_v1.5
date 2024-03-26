// To parse this JSON data, do
//
//     final tomTatBenhAn = tomTatBenhAnFromJson(jsonString);

import 'dart:convert';

TomTatBenhAn tomTatBenhAnFromJson(String str) =>
    TomTatBenhAn.fromJson(json.decode(str));

String tomTatBenhAnToJson(TomTatBenhAn data) => json.encode(data.toJson());

class TomTatBenhAn {
  bool success;
  List<TomTatBenhAnData> data;
  String message;

  TomTatBenhAn({
    required this.success,
    required this.data,
    required this.message,
  });

  factory TomTatBenhAn.fromJson(Map<String, dynamic> json) => TomTatBenhAn(
        success: json["success"],
        data: List<TomTatBenhAnData>.from(
            json["data"].map((x) => TomTatBenhAnData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class TomTatBenhAnData {
  DateTime ngaylap;
  dynamic tenkhoa;
  dynamic chandoanVaovien;
  dynamic chandoanRavien;
  dynamic tomtatbenhan;
  dynamic quatrinhbenhly;
  dynamic tomtatcanlamsang;
  dynamic phuongphapdieutri;
  dynamic tinhtrangravien;
  dynamic ghichu;
  dynamic donvicongtac;
  dynamic noinhan;
  String nguoilap;

  TomTatBenhAnData({
    required this.ngaylap,
    required this.tenkhoa,
    required this.chandoanVaovien,
    required this.chandoanRavien,
    required this.tomtatbenhan,
    required this.quatrinhbenhly,
    required this.tomtatcanlamsang,
    required this.phuongphapdieutri,
    required this.tinhtrangravien,
    required this.ghichu,
    required this.donvicongtac,
    required this.noinhan,
    required this.nguoilap,
  });

  factory TomTatBenhAnData.fromJson(Map<String, dynamic> json) =>
      TomTatBenhAnData(
        ngaylap: DateTime.parse(json["ngaylap"]),
        tenkhoa: json["tenkhoa"],
        chandoanVaovien: json["chandoan_vaovien"],
        chandoanRavien: json["chandoan_ravien"],
        tomtatbenhan: json["tomtatbenhan"],
        quatrinhbenhly: json["quatrinhbenhly"],
        tomtatcanlamsang: json["tomtatcanlamsang"],
        phuongphapdieutri: json["phuongphapdieutri"],
        tinhtrangravien: json["tinhtrangravien"],
        ghichu: json["ghichu"],
        donvicongtac: json["donvicongtac"],
        noinhan: json["noinhan"],
        nguoilap: json["nguoilap"],
      );

  Map<String, dynamic> toJson() => {
        "ngaylap": ngaylap.toIso8601String(),
        "tenkhoa": tenkhoa,
        "chandoan_vaovien": chandoanVaovien,
        "chandoan_ravien": chandoanRavien,
        "tomtatbenhan": tomtatbenhan,
        "quatrinhbenhly": quatrinhbenhly,
        "tomtatcanlamsang": tomtatcanlamsang,
        "phuongphapdieutri": phuongphapdieutri,
        "tinhtrangravien": tinhtrangravien,
        "ghichu": ghichu,
        "donvicongtac": donvicongtac,
        "noinhan": noinhan,
        "nguoilap": nguoilap,
      };
}
