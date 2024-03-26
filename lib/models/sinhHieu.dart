// To parse this JSON data, do
//
//     final sinhHieu = sinhHieuFromJson(jsonString);

import 'dart:convert';

SinhHieu sinhHieuFromJson(String str) => SinhHieu.fromJson(json.decode(str));

String sinhHieuToJson(SinhHieu data) => json.encode(data.toJson());

class SinhHieu {
  bool success;
  List<SinhHieuData> data;
  String message;

  SinhHieu({
    required this.success,
    required this.data,
    required this.message,
  });

  factory SinhHieu.fromJson(Map<String, dynamic> json) => SinhHieu(
        success: json["success"],
        data: List<SinhHieuData>.from(
            json["data"].map((x) => SinhHieuData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class SinhHieuData {
  String madhst;
  String tennguoidung;
  DateTime ngaydo;
  dynamic mach;
  dynamic nhietdo;
  dynamic huyetap1;
  dynamic huyetap2;
  dynamic huyetap;
  dynamic nhiptho;
  dynamic luongnuoctieu;
  dynamic luongphan;
  dynamic spo2;
  dynamic thangtuoi;
  dynamic cannang;
  dynamic chieucao;
  dynamic vongbung;
  dynamic mattrai;
  dynamic matphai;
  dynamic mattraick;
  dynamic matphaick;
  dynamic nhanapMattrai;
  dynamic nhanapMatphai;
  dynamic soluongChuky;
  dynamic soluongDaky;

  SinhHieuData({
    required this.madhst,
    required this.tennguoidung,
    required this.ngaydo,
    required this.mach,
    required this.nhietdo,
    required this.huyetap1,
    required this.huyetap2,
    required this.huyetap,
    required this.nhiptho,
    required this.luongnuoctieu,
    required this.luongphan,
    required this.spo2,
    required this.thangtuoi,
    required this.cannang,
    required this.chieucao,
    required this.vongbung,
    required this.mattrai,
    required this.matphai,
    required this.mattraick,
    required this.matphaick,
    required this.nhanapMattrai,
    required this.nhanapMatphai,
    required this.soluongChuky,
    required this.soluongDaky,
  });

  factory SinhHieuData.fromJson(Map<String, dynamic> json) => SinhHieuData(
        madhst: json["madhst"],
        tennguoidung: json["tennguoidung"],
        ngaydo: DateTime.parse(json["ngaydo"]),
        mach: json["mach"],
        nhietdo: json["nhietdo"],
        huyetap1: json["huyetap1"],
        huyetap2: json["huyetap2"],
        huyetap: json["huyetap"],
        nhiptho: json["nhiptho"],
        luongnuoctieu: json["luongnuoctieu"],
        luongphan: json["luongphan"],
        spo2: json["spo2"],
        thangtuoi: json["thangtuoi"],
        cannang: json["cannang"],
        chieucao: json["chieucao"],
        vongbung: json["vongbung"],
        mattrai: json["mattrai"],
        matphai: json["matphai"],
        mattraick: json["mattraick"],
        matphaick: json["matphaick"],
        nhanapMattrai: json["nhanap_mattrai"],
        nhanapMatphai: json["nhanap_matphai"],
        soluongChuky: json["soluong_chuky"],
        soluongDaky: json["soluong_daky"],
      );

  Map<String, dynamic> toJson() => {
        "madhst": madhst,
        "tennguoidung": tennguoidung,
        "ngaydo": ngaydo.toIso8601String(),
        "mach": mach,
        "nhietdo": nhietdo,
        "huyetap1": huyetap1,
        "huyetap2": huyetap2,
        "huyetap": huyetap,
        "nhiptho": nhiptho,
        "luongnuoctieu": luongnuoctieu,
        "luongphan": luongphan,
        "spo2": spo2,
        "thangtuoi": thangtuoi,
        "cannang": cannang,
        "chieucao": chieucao,
        "vongbung": vongbung,
        "mattrai": mattrai,
        "matphai": matphai,
        "mattraick": mattraick,
        "matphaick": matphaick,
        "nhanap_mattrai": nhanapMattrai,
        "nhanap_matphai": nhanapMatphai,
        "soluong_chuky": soluongChuky,
        "soluong_daky": soluongDaky,
      };
}

class LuuSinhHieu {
  String mahs;
  String mabn;
  String manhapvien;
  String makhoa;
  String makhu;
  String maphong;
  dynamic mash;
  DateTime ngaydo;
  dynamic mach;
  dynamic huyetap1;
  dynamic huyetap2;
  dynamic haXamlan;
  dynamic nhietdo;
  dynamic nhiptho;
  dynamic spo2;
  dynamic luongnuoctieu;
  dynamic luongphan;

  LuuSinhHieu({
    required this.mahs,
    required this.mabn,
    required this.manhapvien,
    required this.makhoa,
    required this.makhu,
    required this.maphong,
    required this.mash,
    required this.ngaydo,
    this.mach,
    this.huyetap1,
    this.huyetap2,
    this.haXamlan,
    this.nhietdo,
    this.nhiptho,
    this.spo2,
    this.luongnuoctieu,
    this.luongphan,
  });

  factory LuuSinhHieu.fromJson(Map<String, dynamic> json) => LuuSinhHieu(
        mahs: json["mahs"],
        mabn: json["mabn"],
        manhapvien: json["manhapvien"],
        makhoa: json["makhoa"],
        makhu: json["makhu"],
        maphong: json["maphong"],
        mash: json["mash"],
        ngaydo: DateTime.parse(json["ngaydo"]),
        mach: json["mach"],
        huyetap1: json["huyetap1"],
        huyetap2: json["huyetap2"],
        haXamlan: json["ha_xamlan"],
        nhietdo: json["nhietdo"],
        nhiptho: json["nhiptho"],
        spo2: json["SPO2"],
        luongnuoctieu: json["luongnuoctieu"],
        luongphan: json["luongphan"],
      );

  Map<String, dynamic> toJson() => {
        "mahs": mahs,
        "mabn": mabn,
        "manhapvien": manhapvien,
        "makhoa": makhoa,
        "makhu": makhu,
        "maphong": maphong,
        "mash": mash,
        "ngaydo": ngaydo.toIso8601String(),
        "mach": mach,
        "huyetap1": huyetap1,
        "huyetap2": huyetap2,
        "ha_xamlan": haXamlan,
        "nhietdo": nhietdo,
        "nhiptho": nhiptho,
        "SPO2": spo2,
        "luongnuoctieu": luongnuoctieu,
        "luongphan": luongphan,
      };
}

class PostSinhHieu {
  bool success;
  String message;

  PostSinhHieu({
    required this.success,
    required this.message,
  });

  factory PostSinhHieu.fromJson(Map<String, dynamic> json) => PostSinhHieu(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
