// To parse this JSON data, do
//
//     final tokenTinNhan = tokenTinNhanFromJson(jsonString);

import 'dart:convert';

TokenTinNhan tokenTinNhanFromJson(String str) =>
    TokenTinNhan.fromJson(json.decode(str));

String tokenTinNhanToJson(TokenTinNhan data) => json.encode(data.toJson());

class TokenTinNhan {
  bool success;
  List<dynamic> data;
  String message;

  TokenTinNhan({
    required this.success,
    required this.data,
    required this.message,
  });

  factory TokenTinNhan.fromJson(Map<String, dynamic> json) => TokenTinNhan(
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
