// To parse this JSON data, do
//
//     final benhNhan = benhNhanFromJson(jsonString);

import 'dart:convert';

BenhNhan benhNhanFromJson(String str) => BenhNhan.fromJson(json.decode(str));

String benhNhanToJson(BenhNhan data) => json.encode(data.toJson());

class BenhNhan {
  bool success;
  List<BenhNhanData> data;
  String message;

  BenhNhan({
    required this.success,
    required this.data,
    required this.message,
  });

  factory BenhNhan.fromJson(Map<String, dynamic> json) => BenhNhan(
        success: json["success"],
        data: List<BenhNhanData>.from(
            json["data"].map((x) => BenhNhanData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class BenhNhanData {
  String idbn;
  String mabn;
  String sohoso;
  String maba;
  String hotenbn;
  dynamic gioitinh;
  DateTime ngaysinh;
  dynamic diachi;
  dynamic maloaihs;
  dynamic benhnang;
  dynamic benhanNgoaitru;
  dynamic chandoanTaikhoa;
  dynamic chandoanphuTaikhoa;
  dynamic icdTaikhoa;
  dynamic icdphuTaikhoa;
  DateTime ngayvao;
  dynamic ngayravien;
  dynamic khoaravien;
  DateTime ngayvaovien;
  dynamic benhkem;
  dynamic maloaikcb;
  dynamic tenphong;
  dynamic tengiuong;
  dynamic magiuongQuiuoc;
  dynamic tenviettat;
  dynamic mahs;
  dynamic maravien;
  dynamic manamvien;
  dynamic manhapvien;
  dynamic makhoa;
  dynamic makhu;
  dynamic maphong;
  dynamic mabs;
  dynamic khoaDieutri;
  dynamic khuDieutri;
  dynamic phongDieutri;
  dynamic bacsiDieutri;
  dynamic usernameBs;
  dynamic avatar;
  BenhNhanData({
    required this.idbn,
    required this.mabn,
    required this.sohoso,
    required this.maba,
    required this.hotenbn,
    required this.gioitinh,
    required this.ngaysinh,
    required this.diachi,
    required this.maloaihs,
    required this.benhnang,
    required this.benhanNgoaitru,
    required this.chandoanTaikhoa,
    required this.chandoanphuTaikhoa,
    required this.icdTaikhoa,
    required this.icdphuTaikhoa,
    required this.ngayvao,
    required this.ngayravien,
    required this.khoaravien,
    required this.ngayvaovien,
    required this.benhkem,
    required this.maloaikcb,
    required this.tenphong,
    required this.tengiuong,
    required this.magiuongQuiuoc,
    required this.tenviettat,
    required this.mahs,
    required this.maravien,
    required this.manamvien,
    required this.manhapvien,
    required this.makhoa,
    required this.makhu,
    required this.maphong,
    required this.mabs,
    required this.khoaDieutri,
    required this.khuDieutri,
    required this.phongDieutri,
    required this.bacsiDieutri,
    required this.usernameBs,
    required this.avatar,
  });

  factory BenhNhanData.fromJson(Map<String, dynamic> json) => BenhNhanData(
      idbn: json["idbn"],
      mabn: json["mabn"],
      sohoso: json["sohoso"],
      maba: json["maba"],
      hotenbn: json["hotenbn"],
      gioitinh: json["gioitinh"],
      ngaysinh: DateTime.parse(json["ngaysinh"]),
      diachi: json["diachi"],
      maloaihs: json["maloaihs"],
      benhnang: json["benhnang"],
      benhanNgoaitru: json["benhan_ngoaitru"],
      chandoanTaikhoa: json["chandoan_taikhoa"],
      chandoanphuTaikhoa: json["chandoanphu_taikhoa"],
      icdTaikhoa: json["icd_taikhoa"],
      icdphuTaikhoa: json["icdphu_taikhoa"],
      ngayvao: DateTime.parse(json["ngayvao"]),
      ngayravien: json["ngayravien"],
      khoaravien: json["khoaravien"],
      ngayvaovien: DateTime.parse(json["ngayvaovien"]),
      benhkem: json["benhkem"],
      maloaikcb: json["maloaikcb"],
      tenphong: json["tenphong"],
      tengiuong: json["tengiuong"],
      magiuongQuiuoc: json["magiuong_quiuoc"],
      tenviettat: json["tenviettat"],
      mahs: json["mahs"],
      maravien: json["maravien"],
      manamvien: json["manamvien"],
      manhapvien: json["manhapvien"],
      makhoa: json["makhoa"],
      makhu: json["makhu"],
      maphong: json["maphong"],
      mabs: json["mabs"],
      khoaDieutri: json["khoa_dieutri"],
      khuDieutri: json["khu_dieutri"],
      phongDieutri: json["phong_dieutri"],
      bacsiDieutri: json["bacsi_dieutri"],
      usernameBs: json["username_bs"],
      avatar: json["avatar"]);

  Map<String, dynamic> toJson() => {
        "idbn": idbn,
        "mabn": mabn,
        "sohoso": sohoso,
        "maba": maba,
        "hotenbn": hotenbn,
        "gioitinh": gioitinh,
        "ngaysinh":
            "${ngaysinh.year.toString().padLeft(4, '0')}-${ngaysinh.month.toString().padLeft(2, '0')}-${ngaysinh.day.toString().padLeft(2, '0')}",
        "diachi": diachi,
        "maloaihs": maloaihs,
        "benhnang": benhnang,
        "benhan_ngoaitru": benhanNgoaitru,
        "chandoan_taikhoa": chandoanTaikhoa,
        "chandoanphu_taikhoa": chandoanphuTaikhoa,
        "icd_taikhoa": icdTaikhoa,
        "icdphu_taikhoa": icdphuTaikhoa,
        "ngayvao": ngayvao.toIso8601String(),
        "ngayravien": ngayravien,
        "khoaravien": khoaravien,
        "ngayvaovien": ngayvaovien.toIso8601String(),
        "benhkem": benhkem,
        "maloaikcb": maloaikcb,
        "tenphong": tenphong,
        "tengiuong": tengiuong,
        "magiuong_quiuoc": magiuongQuiuoc,
        "tenviettat": tenviettat,
        "mahs": mahs,
        "maravien": maravien,
        "manamvien": manamvien,
        "manhapvien": manhapvien,
        "makhoa": makhoa,
        "makhu": makhu,
        "maphong": maphong,
        "mabs": mabs,
        "khoa_dieutri": khoaDieutri,
        "khu_dieutri": khuDieutri,
        "phong_dieutri": phongDieutri,
        "bacsi_dieutri": bacsiDieutri,
        "username_bs": usernameBs,
        "avatar": avatar,
      };
}
