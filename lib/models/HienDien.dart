// To parse this JSON data, do
//
//     final HienDien = HienDienFromJson(jsonString);

import 'dart:convert';

HienDien HienDienFromJson(String str) => HienDien.fromJson(json.decode(str));

String HienDienToJson(HienDien data) => json.encode(data.toJson());

class HienDien {
  bool success;
  HienDienData data;
  String message;

  HienDien({
    required this.success,
    required this.data,
    required this.message,
  });

  factory HienDien.fromJson(Map<String, dynamic> json) => HienDien(
        success: json["success"],
        data: HienDienData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class HienDienData {
  int hiendien;
  int nam;
  int nu;
  int bsDieutri;
  int hosoNgoaitru;
  int benhNang;
  int bhyt;
  int thuphi;
  int treem;
  int bvsk;
  int mienphi;

  HienDienData({
    required this.hiendien,
    required this.nam,
    required this.nu,
    required this.bsDieutri,
    required this.hosoNgoaitru,
    required this.benhNang,
    required this.bhyt,
    required this.thuphi,
    required this.treem,
    required this.bvsk,
    required this.mienphi,
  });

  factory HienDienData.fromJson(Map<String, dynamic> json) => HienDienData(
        hiendien: json["hiendien"],
        nam: json["nam"],
        nu: json["nu"],
        bsDieutri: json["bs_dieutri"],
        hosoNgoaitru: json["hoso_ngoaitru"],
        benhNang: json["benh_nang"],
        bhyt: json["bhyt"],
        thuphi: json["thuphi"],
        treem: json["treem"],
        bvsk: json["bvsk"],
        mienphi: json["mienphi"],
      );

  Map<String, dynamic> toJson() => {
        "hiendien": hiendien,
        "nam": nam,
        "nu": nu,
        "bs_dieutri": bsDieutri,
        "hoso_ngoaitru": hosoNgoaitru,
        "benh_nang": benhNang,
        "bhyt": bhyt,
        "thuphi": thuphi,
        "treem": treem,
        "bvsk": bvsk,
        "mienphi": mienphi,
      };
}
