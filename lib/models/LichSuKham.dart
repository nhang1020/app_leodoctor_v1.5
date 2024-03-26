// To parse this JSON data, do
//
//     final LichSuKham = LichSuKhamFromJson(jsonString);

import 'dart:convert';

LichSuKham LichSuKhamFromJson(String str) =>
    LichSuKham.fromJson(json.decode(str));

String LichSuKhamToJson(LichSuKham data) => json.encode(data.toJson());

class LichSuKham {
  bool success;
  List<LichSuKhamData> data;
  String message;

  LichSuKham({
    required this.success,
    required this.data,
    required this.message,
  });

  factory LichSuKham.fromJson(Map<String, dynamic> json) => LichSuKham(
        success: json["success"],
        data: List<LichSuKhamData>.from(
            json["data"].map((x) => LichSuKhamData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class LichSuKhamData {
  dynamic sohoso;
  DateTime ngayvaovien;
  DateTime ngaykham;
  dynamic loaikcb;
  dynamic chandoanIcd;
  dynamic chandoan;
  LichSuKhamData({
    required this.sohoso,
    required this.ngayvaovien,
    required this.ngaykham,
    required this.loaikcb,
    required this.chandoanIcd,
    required this.chandoan,
  });

  factory LichSuKhamData.fromJson(Map<String, dynamic> json) => LichSuKhamData(
        sohoso: json["sohoso"],
        ngayvaovien: DateTime.parse(json["ngayvaovien"]),
        ngaykham: DateTime.parse(json["ngaykham"]),
        loaikcb: json["loaikcb"],
        chandoanIcd: json["chandoan_icd"],
        chandoan: json["chandoan"],
      );

  Map<String, dynamic> toJson() => {
        "sohoso": sohoso,
        "ngayvaovien": ngayvaovien.toIso8601String(),
        "ngaykham": ngaykham.toIso8601String(),
        "loaikcb": loaikcb,
        "chandoan_icd": chandoanIcd,
        "chandoan": chandoan,
      };
}
