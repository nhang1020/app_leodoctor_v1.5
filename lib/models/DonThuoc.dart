// To parse this JSON data, do
//
//     final donThuoc = donThuocFromJson(jsonString);

import 'dart:convert';

DonThuoc donThuocFromJson(String str) => DonThuoc.fromJson(json.decode(str));

String donThuocToJson(DonThuoc data) => json.encode(data.toJson());

class DonThuoc {
  bool success;
  List<DonThuocData> data;
  String message;

  DonThuoc({
    required this.success,
    required this.data,
    required this.message,
  });

  factory DonThuoc.fromJson(Map<String, dynamic> json) => DonThuoc(
        success: json["success"],
        data: List<DonThuocData>.from(
            json["data"].map((x) => DonThuocData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class DonThuocData {
  dynamic id;
  dynamic manhapvien;
  dynamic madonthuoc;
  DateTime ngay;
  dynamic loaitoa;
  dynamic loidan;
  dynamic mabs;
  dynamic tenbs;
  dynamic makhoa;
  dynamic khoitao;
  dynamic tenkhoa;
  dynamic madv;
  dynamic tendichvu;
  dynamic machidinhDvct;
  dynamic soluongTra;
  dynamic xoaCd;
  dynamic dvkt;
  dynamic soluongChuky;
  dynamic soluongDaky;

  DonThuocData({
    required this.id,
    required this.manhapvien,
    required this.madonthuoc,
    required this.ngay,
    required this.loaitoa,
    required this.loidan,
    required this.mabs,
    required this.tenbs,
    required this.makhoa,
    required this.khoitao,
    required this.tenkhoa,
    required this.madv,
    required this.tendichvu,
    required this.machidinhDvct,
    required this.soluongTra,
    required this.xoaCd,
    required this.dvkt,
    required this.soluongChuky,
    required this.soluongDaky,
  });

  factory DonThuocData.fromJson(Map<String, dynamic> json) => DonThuocData(
        id: json["id"],
        manhapvien: json["manhapvien"],
        madonthuoc: json["madonthuoc"],
        ngay: DateTime.parse(json["ngay"]),
        loaitoa: json["loaitoa"],
        loidan: json["loidan"],
        mabs: json["mabs"],
        tenbs: json["tenbs"],
        makhoa: json["makhoa"],
        khoitao: json["khoitao"],
        tenkhoa: json["tenkhoa"],
        madv: json["madv"],
        tendichvu: json["tendichvu"],
        machidinhDvct: json["machidinh_dvct"],
        soluongTra: json["soluong_tra"],
        xoaCd: json["xoa_cd"],
        dvkt: json["dvkt"],
        soluongChuky: json["soluong_chuky"],
        soluongDaky: json["soluong_daky"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "manhapvien": manhapvien,
        "madonthuoc": madonthuoc,
        "ngay": ngay.toIso8601String(),
        "loaitoa": loaitoa,
        "loidan": loidan,
        "mabs": mabs,
        "tenbs": tenbs,
        "makhoa": makhoa,
        "khoitao": khoitao,
        "tenkhoa": tenkhoa,
        "madv": madv,
        "tendichvu": tendichvu,
        "machidinh_dvct": machidinhDvct,
        "soluong_tra": soluongTra,
        "xoa_cd": xoaCd,
        "dvkt": dvkt,
        "soluong_chuky": soluongChuky,
        "soluong_daky": soluongDaky,
      };
}
