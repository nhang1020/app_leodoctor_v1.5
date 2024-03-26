// To parse this JSON data, do
//
//     final ketQuaCls = ketQuaClsFromJson(jsonString);

import 'dart:convert';

KetQuaCls ketQuaClsFromJson(String str) => KetQuaCls.fromJson(json.decode(str));

String ketQuaClsToJson(KetQuaCls data) => json.encode(data.toJson());

class KetQuaCls {
  bool success;
  List<KetQuaClsData> data;
  String message;

  KetQuaCls({
    required this.success,
    required this.data,
    required this.message,
  });

  factory KetQuaCls.fromJson(Map<String, dynamic> json) => KetQuaCls(
        success: json["success"],
        data: List<KetQuaClsData>.from(
            json["data"].map((x) => KetQuaClsData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class KetQuaClsData {
  dynamic hsHientai;
  dynamic mahs;
  DateTime ngayChidinh;
  dynamic tendichvu;
  dynamic bacsiChidinh;
  dynamic khoaChidinh;
  dynamic khoaTrakq;
  DateTime? ngayKetqua;
  dynamic nguoiTrakq;
  dynamic tinhtrangSudung;
  dynamic manhomdv;
  dynamic tennhomdv;
  dynamic manhomdvCha;
  dynamic machidinhDvct;
  dynamic machidinhDvctKq;

  KetQuaClsData({
    required this.hsHientai,
    required this.mahs,
    required this.ngayChidinh,
    required this.tendichvu,
    required this.bacsiChidinh,
    required this.khoaChidinh,
    required this.khoaTrakq,
    required this.ngayKetqua,
    required this.nguoiTrakq,
    required this.tinhtrangSudung,
    required this.manhomdv,
    required this.tennhomdv,
    required this.manhomdvCha,
    required this.machidinhDvct,
    required this.machidinhDvctKq,
  });

  factory KetQuaClsData.fromJson(Map<String, dynamic> json) => KetQuaClsData(
        hsHientai: json["hs_hientai"],
        mahs: json["mahs"],
        ngayChidinh: DateTime.parse(json["ngay_chidinh"]),
        tendichvu: json["tendichvu"],
        bacsiChidinh: json["bacsi_chidinh"],
        khoaChidinh: json["khoa_chidinh"],
        khoaTrakq: json["khoa_trakq"],
        ngayKetqua: json["ngay_ketqua"] == null
            ? null
            : DateTime.parse(json["ngay_ketqua"]),
        nguoiTrakq: json["nguoi_trakq"],
        tinhtrangSudung: json["tinhtrang_sudung"],
        manhomdv: json["manhomdv"],
        tennhomdv: json["tennhomdv"],
        manhomdvCha: json["manhomdv_cha"],
        machidinhDvct: json["machidinh_dvct"],
        machidinhDvctKq: json["machidinh_dvct_kq"],
      );

  Map<String, dynamic> toJson() => {
        "hs_hientai": hsHientai,
        "mahs": mahs,
        "ngay_chidinh": ngayChidinh.toIso8601String(),
        "tendichvu": tendichvu,
        "bacsi_chidinh": bacsiChidinh,
        "khoa_chidinh": khoaChidinh,
        "khoa_trakq": khoaTrakq,
        "ngay_ketqua": ngayKetqua?.toIso8601String(),
        "nguoi_trakq": nguoiTrakq,
        "tinhtrang_sudung": tinhtrangSudung,
        "manhomdv": manhomdv,
        "tennhomdv": tennhomdv,
        "manhomdv_cha": manhomdvCha,
        "machidinh_dvct": machidinhDvct,
        "machidinh_dvct_kq": machidinhDvctKq,
      };
}
