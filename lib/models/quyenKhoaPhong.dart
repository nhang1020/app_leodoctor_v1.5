// To parse this JSON data, do
//
//     final quyenKhoaPhong = quyenKhoaPhongFromJson(jsonString);

import 'dart:convert';

QuyenKhoaPhong quyenKhoaPhongFromJson(String str) =>
    QuyenKhoaPhong.fromJson(json.decode(str));

String quyenKhoaPhongToJson(QuyenKhoaPhong data) => json.encode(data.toJson());

class QuyenKhoaPhong {
  bool success;
  List<DataQkp> dataQkp;
  String message;

  QuyenKhoaPhong({
    required this.success,
    required this.dataQkp,
    required this.message,
  });

  factory QuyenKhoaPhong.fromJson(Map<String, dynamic> json) => QuyenKhoaPhong(
        success: json["success"],
        dataQkp:
            List<DataQkp>.from(json["data"].map((x) => DataQkp.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(dataQkp.map((x) => x.toJson())),
        "message": message,
      };
}

class DataQkp {
  dynamic makhoaphong;
  dynamic tenkhoaphong;
  dynamic makhoa;
  dynamic thutu;
  dynamic loai;
  dynamic makho;
  dynamic tenkho;

  DataQkp({
    required this.makhoaphong,
    required this.tenkhoaphong,
    required this.makhoa,
    required this.thutu,
    required this.loai,
    required this.makho,
    required this.tenkho,
  });

  factory DataQkp.fromJson(Map<String, dynamic> json) => DataQkp(
        makhoaphong: json["makhoaphong"],
        tenkhoaphong: json["tenkhoaphong"],
        makhoa: json["makhoa"],
        thutu: json["thutu"],
        loai: json["loai"],
        makho: json["makho"],
        tenkho: json["tenkho"],
      );

  Map<String, dynamic> toJson() => {
        "makhoaphong": makhoaphong,
        "tenkhoaphong": tenkhoaphong,
        "makhoa": [makhoa],
        "thutu": thutu,
        "loai": [loai],
        "makho": makho,
        "tenkho": tenkho,
      };
}
