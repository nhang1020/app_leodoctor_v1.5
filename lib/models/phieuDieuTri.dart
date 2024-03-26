// To parse this JSON data, do
//
//     final phieuDieuTri = phieuDieuTriFromJson(jsonString);

import 'dart:convert';

PhieuDieuTri phieuDieuTriFromJson(String str) =>
    PhieuDieuTri.fromJson(json.decode(str));

String phieuDieuTriToJson(PhieuDieuTri data) => json.encode(data.toJson());

class PhieuDieuTri {
  bool success;
  List<PhieuDieuTriData> data;
  String message;

  PhieuDieuTri({
    required this.success,
    required this.data,
    required this.message,
  });

  factory PhieuDieuTri.fromJson(Map<String, dynamic> json) => PhieuDieuTri(
        success: json["success"],
        data: List<PhieuDieuTriData>.from(
            json["data"].map((x) => PhieuDieuTriData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class PhieuDieuTriData {
  dynamic id;
  dynamic maphieudieutri;
  dynamic mabn;
  dynamic manhapvien;
  dynamic mahs;
  dynamic makhoa;
  dynamic maphong;
  DateTime ngaylap;
  dynamic giolap;
  dynamic chandoan;
  dynamic chandoanicd;
  dynamic dienbien;
  dynamic ylenh;
  dynamic ylenhcc;
  dynamic giaiDoanBenh;
  dynamic mabs;
  dynamic manguoidung;
  DateTime ngayhh;
  dynamic manamvien;
  dynamic backupMabs;
  dynamic mapk;
  dynamic idbenhanmantinh;
  dynamic tennguoidung;
  dynamic tenkhoa;
  dynamic soluongChuky;
  dynamic soluongDaky;
  dynamic ylenhDiengiai;

  PhieuDieuTriData({
    required this.id,
    required this.maphieudieutri,
    required this.mabn,
    required this.manhapvien,
    required this.mahs,
    required this.makhoa,
    required this.maphong,
    required this.ngaylap,
    required this.giolap,
    required this.chandoan,
    required this.chandoanicd,
    required this.dienbien,
    required this.ylenh,
    required this.ylenhcc,
    required this.giaiDoanBenh,
    required this.mabs,
    required this.manguoidung,
    required this.ngayhh,
    required this.manamvien,
    required this.backupMabs,
    required this.mapk,
    required this.idbenhanmantinh,
    required this.tennguoidung,
    required this.tenkhoa,
    required this.soluongChuky,
    required this.soluongDaky,
    required this.ylenhDiengiai,
  });

  factory PhieuDieuTriData.fromJson(Map<String, dynamic> json) =>
      PhieuDieuTriData(
        id: json["id"],
        maphieudieutri: json["maphieudieutri"],
        mabn: json["mabn"],
        manhapvien: json["manhapvien"],
        mahs: json["mahs"],
        makhoa: json["makhoa"],
        maphong: json["maphong"],
        ngaylap: DateTime.parse(json["ngaylap"]),
        giolap: json["giolap"],
        chandoan: json["chandoan"],
        chandoanicd: json["chandoanicd"],
        dienbien: json["dienbien"],
        ylenh: json["ylenh"],
        ylenhcc: json["ylenhcc"],
        giaiDoanBenh: json["giai_doan_benh"],
        mabs: json["mabs"],
        manguoidung: json["manguoidung"],
        ngayhh: DateTime.parse(json["ngayhh"]),
        manamvien: json["manamvien"],
        backupMabs: json["backup_mabs"],
        mapk: json["mapk"],
        idbenhanmantinh: json["idbenhanmantinh"],
        tennguoidung: json["tennguoidung"],
        tenkhoa: json["tenkhoa"],
        soluongChuky: json["soluong_chuky"],
        soluongDaky: json["soluong_daky"],
        ylenhDiengiai: json["ylenh_diengiai"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "maphieudieutri": maphieudieutri,
        "mabn": mabn,
        "manhapvien": manhapvien,
        "mahs": mahs,
        "makhoa": makhoa,
        "maphong": maphong,
        "ngaylap": ngaylap.toIso8601String(),
        "giolap": giolap,
        "chandoan": chandoan,
        "chandoanicd": chandoanicd,
        "dienbien": dienbien,
        "ylenh": ylenh,
        "ylenhcc": ylenhcc,
        "giai_doan_benh": giaiDoanBenh,
        "mabs": mabs,
        "manguoidung": manguoidung,
        "ngayhh": ngayhh.toIso8601String(),
        "manamvien": manamvien,
        "backup_mabs": backupMabs,
        "mapk": mapk,
        "idbenhanmantinh": idbenhanmantinh,
        "tennguoidung": tennguoidung,
        "tenkhoa": tenkhoa,
        "soluong_chuky": soluongChuky,
        "soluong_daky": soluongDaky,
        "ylenh_diengiai": ylenhDiengiai,
      };
}

XemDieuTri xemDieuTriFromJson(String str) =>
    XemDieuTri.fromJson(json.decode(str));

String xemDieuTriToJson(XemDieuTri data) => json.encode(data.toJson());

class XemDieuTri {
  bool success;
  XemDieuTriData data;
  String message;

  XemDieuTri({
    required this.success,
    required this.data,
    required this.message,
  });

  factory XemDieuTri.fromJson(Map<String, dynamic> json) => XemDieuTri(
        success: json["success"],
        data: XemDieuTriData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class XemDieuTriData {
  dynamic link;

  XemDieuTriData({
    required this.link,
  });

  factory XemDieuTriData.fromJson(Map<String, dynamic> json) => XemDieuTriData(
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
      };
}
