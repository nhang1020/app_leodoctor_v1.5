// To parse this JSON data, do
//
//     final hoiChan = hoiChanFromJson(jsonString);

import 'dart:convert';

HoiChan hoiChanFromJson(String str) => HoiChan.fromJson(json.decode(str));

String hoiChanToJson(HoiChan data) => json.encode(data.toJson());

class HoiChan {
  bool success;
  List<HoiChanData> data;
  String message;

  HoiChan({
    required this.success,
    required this.data,
    required this.message,
  });

  factory HoiChan.fromJson(Map<String, dynamic> json) => HoiChan(
        success: json["success"],
        data: List<HoiChanData>.from(
            json["data"].map((x) => HoiChanData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class HoiChanData {
  dynamic mahoichan;
  DateTime ngayhoichan;
  dynamic hinhthuc;
  dynamic tenkhoa;
  dynamic chutoa;
  dynamic thuky;
  dynamic thanhvien;
  dynamic chandoan;
  dynamic tomtatDieutri;
  dynamic ketluan;
  dynamic huongdieutri;

  HoiChanData({
    required this.mahoichan,
    required this.ngayhoichan,
    required this.hinhthuc,
    required this.tenkhoa,
    required this.chutoa,
    required this.thuky,
    required this.thanhvien,
    required this.chandoan,
    required this.tomtatDieutri,
    required this.ketluan,
    required this.huongdieutri,
  });

  factory HoiChanData.fromJson(Map<String, dynamic> json) => HoiChanData(
        mahoichan: json["mahoichan"],
        ngayhoichan: DateTime.parse(json["ngayhoichan"]),
        hinhthuc: json["hinhthuc"],
        tenkhoa: json["tenkhoa"],
        chutoa: json["chutoa"],
        thuky: json["thuky"],
        thanhvien: json["thanhvien"],
        chandoan: json["chandoan"],
        tomtatDieutri: json["tomtat_dieutri"],
        ketluan: json["ketluan"],
        huongdieutri: json["huongdieutri"],
      );

  Map<String, dynamic> toJson() => {
        "mahoichan": mahoichan,
        "ngayhoichan": ngayhoichan.toIso8601String(),
        "hinhthuc": hinhthuc,
        "tenkhoa": tenkhoa,
        "chutoa": chutoa,
        "thuky": thuky,
        "thanhvien": thanhvien,
        "chandoan": chandoan,
        "tomtat_dieutri": tomtatDieutri,
        "ketluan": ketluan,
        "huongdieutri": huongdieutri,
      };
}
