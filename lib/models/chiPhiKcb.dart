// To parse this JSON data, do
//
//     final chiPhiKcb = chiPhiKcbFromJson(jsonString);

import 'dart:convert';

ChiPhiKcb chiPhiKcbFromJson(String str) => ChiPhiKcb.fromJson(json.decode(str));

String chiPhiKcbToJson(ChiPhiKcb data) => json.encode(data.toJson());

class ChiPhiKcb {
  bool success;
  ChiPhiKcbData data;
  String message;

  ChiPhiKcb({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ChiPhiKcb.fromJson(Map<String, dynamic> json) => ChiPhiKcb(
        success: json["success"],
        data: ChiPhiKcbData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class ChiPhiKcbData {
  double tongchiphikcb;
  double tongtiennguoibenhtra;
  double dathu;
  double quybhyttt;
  double nguoibenhcct;
  double nguoibenhtt;
  double tamung;
  double hoantra;
  double thuthem;

  ChiPhiKcbData({
    required this.tongchiphikcb,
    required this.tongtiennguoibenhtra,
    required this.dathu,
    required this.quybhyttt,
    required this.nguoibenhcct,
    required this.nguoibenhtt,
    required this.tamung,
    required this.hoantra,
    required this.thuthem,
  });

  factory ChiPhiKcbData.fromJson(Map<String, dynamic> json) => ChiPhiKcbData(
        tongchiphikcb: json["tongchiphikcb"]?.toDouble(),
        tongtiennguoibenhtra: json["tongtiennguoibenhtra"]?.toDouble(),
        dathu: json["dathu"]?.toDouble(),
        quybhyttt: json["quybhyttt"]?.toDouble(),
        nguoibenhcct: json["nguoibenhcct"]?.toDouble(),
        nguoibenhtt: json["nguoibenhtt"]?.toDouble(),
        tamung: json["tamung"]?.toDouble(),
        hoantra: json["hoantra"]?.toDouble(),
        thuthem: json["thuthem"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "tongchiphikcb": tongchiphikcb,
        "tongtiennguoibenhtra": tongtiennguoibenhtra,
        "dathu": dathu,
        "quybhyttt": quybhyttt,
        "nguoibenhcct": nguoibenhcct,
        "nguoibenhtt": nguoibenhtt,
        "tamung": tamung,
        "hoantra": hoantra,
        "thuthem": thuthem,
      };
}
