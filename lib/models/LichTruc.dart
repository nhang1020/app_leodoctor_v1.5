// To parse this JSON data, do
//
//     final LichTruc = LichTrucFromJson(jsonString);

import 'dart:convert';

LichTruc LichTrucFromJson(String str) => LichTruc.fromJson(json.decode(str));

String LichTrucToJson(LichTruc data) => json.encode(data.toJson());

class LichTruc {
  bool success;
  LichTrucData data;
  String message;

  LichTruc({
    required this.success,
    required this.data,
    required this.message,
  });

  factory LichTruc.fromJson(Map<String, dynamic> json) => LichTruc(
        success: json["success"],
        data: LichTrucData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class LichTrucData {
  String tenbophan;
  String mabophanCha;
  dynamic nhom;
  dynamic tenbophanCha;
  dynamic bacsi;
  dynamic dieuduong;
  dynamic holy;

  LichTrucData({
    required this.tenbophan,
    required this.mabophanCha,
    required this.nhom,
    this.tenbophanCha,
    this.bacsi,
    this.dieuduong,
    this.holy,
  });

  factory LichTrucData.fromJson(Map<String, dynamic> json) => LichTrucData(
        tenbophan: json["tenbophan"],
        mabophanCha: json["mabophan_cha"],
        nhom: json["nhom"],
        tenbophanCha: json["tenbophan_cha"],
        bacsi: json["bacsi"],
        dieuduong: json["dieuduong"],
        holy: json["holy"],
      );

  Map<String, dynamic> toJson() => {
        "tenbophan": tenbophan,
        "mabophan_cha": mabophanCha,
        "nhom": nhom,
        "tenbophan_cha": tenbophanCha,
        "bacsi": bacsi,
        "dieuduong": dieuduong,
        "holy": holy,
      };
}
