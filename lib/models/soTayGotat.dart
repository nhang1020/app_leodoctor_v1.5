// To parse this JSON data, do
//
//     final soTayGoTat = soTayGoTatFromJson(jsonString);

import 'dart:convert';

SoTayGoTat soTayGoTatFromJson(String str) =>
    SoTayGoTat.fromJson(json.decode(str));

String soTayGoTatToJson(SoTayGoTat data) => json.encode(data.toJson());

class SoTayGoTat {
  bool success;
  List<SoTayGoTatData> data;
  String message;

  SoTayGoTat({
    required this.success,
    required this.data,
    required this.message,
  });

  factory SoTayGoTat.fromJson(Map<String, dynamic> json) => SoTayGoTat(
        success: json["success"],
        data: List<SoTayGoTatData>.from(
            json["data"].map((x) => SoTayGoTatData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class SoTayGoTatData {
  String tugotat;
  String noidung;

  SoTayGoTatData({
    required this.tugotat,
    required this.noidung,
  });

  factory SoTayGoTatData.fromJson(Map<String, dynamic> json) => SoTayGoTatData(
        tugotat: json["tugotat"],
        noidung: json["noidung"],
      );

  Map<String, dynamic> toJson() => {
        "tugotat": tugotat,
        "noidung": noidung,
      };
}
