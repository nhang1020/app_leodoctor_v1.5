// To parse this JSON data, do
//
//     final dangXuat = dangXuatFromJson(jsonString);

import 'dart:convert';

DangXuat dangXuatFromJson(String str) => DangXuat.fromJson(json.decode(str));

String dangXuatToJson(DangXuat data) => json.encode(data.toJson());

class DangXuat {
  bool success;
  List<dynamic> data;
  String message;

  DangXuat({
    required this.success,
    required this.data,
    required this.message,
  });

  factory DangXuat.fromJson(Map<String, dynamic> json) => DangXuat(
        success: json["success"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x)),
        "message": message,
      };
}
