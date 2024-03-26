// To parse this JSON data, do
//
//     final xemKetQuaCls = xemKetQuaClsFromJson(jsonString);

import 'dart:convert';

XemKetQuaCls xemKetQuaClsFromJson(String str) =>
    XemKetQuaCls.fromJson(json.decode(str));

String xemKetQuaClsToJson(XemKetQuaCls data) => json.encode(data.toJson());

class XemKetQuaCls {
  bool success;
  XemKetQuaClsData data;
  String message;

  XemKetQuaCls({
    required this.success,
    required this.data,
    required this.message,
  });

  factory XemKetQuaCls.fromJson(Map<String, dynamic> json) => XemKetQuaCls(
        success: json["success"],
        data: XemKetQuaClsData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class XemKetQuaClsData {
  String link;

  XemKetQuaClsData({
    required this.link,
  });

  factory XemKetQuaClsData.fromJson(Map<String, dynamic> json) =>
      XemKetQuaClsData(
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
      };
}
