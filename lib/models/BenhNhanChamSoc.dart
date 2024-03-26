// To parse this JSON data, do
//
//     final benhNhanChamSoc = benhNhanChamSocFromJson(jsonString);

import 'dart:convert';

BenhNhanChamSoc benhNhanChamSocFromJson(String str) =>
    BenhNhanChamSoc.fromJson(json.decode(str));

String benhNhanChamSocToJson(BenhNhanChamSoc data) =>
    json.encode(data.toJson());

class BenhNhanChamSoc {
  bool success;
  List<BenhNhanCSData> data;
  String message;

  BenhNhanChamSoc({
    required this.success,
    required this.data,
    required this.message,
  });

  factory BenhNhanChamSoc.fromJson(Map<String, dynamic> json) =>
      BenhNhanChamSoc(
        success: json["success"],
        data: List<BenhNhanCSData>.from(
            json["data"].map((x) => BenhNhanCSData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class BenhNhanCSData {
  dynamic idbn;
  dynamic mabn;
  dynamic sohoso;
  dynamic maba;
  dynamic hotenbn;
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
  String madonthuoc;
  List<DonthuocChitiet> donthuocChitiet;

  BenhNhanCSData({
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
    required this.madonthuoc,
    required this.donthuocChitiet,
  });

  factory BenhNhanCSData.fromJson(Map<String, dynamic> json) => BenhNhanCSData(
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
        avatar: json["avatar"],
        madonthuoc: json["madonthuoc"],
        donthuocChitiet: List<DonthuocChitiet>.from(
            json["donthuoc_chitiet"].map((x) => DonthuocChitiet.fromJson(x))),
      );

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
        "madonthuoc": madonthuoc,
        "donthuoc_chitiet":
            List<dynamic>.from(donthuocChitiet.map((x) => x.toJson())),
      };
}

class DonthuocChitiet {
  String tenthuoc;
  String hoatchat;
  String donvi;
  String hamluong;
  String soluong;
  DateTime ngayDonthuoc;

  DonthuocChitiet({
    required this.tenthuoc,
    required this.hoatchat,
    required this.donvi,
    required this.hamluong,
    required this.soluong,
    required this.ngayDonthuoc,
  });

  factory DonthuocChitiet.fromJson(Map<String, dynamic> json) =>
      DonthuocChitiet(
        tenthuoc: json["tenthuoc"],
        hoatchat: json["hoatchat"],
        donvi: json["donvi"],
        hamluong: json["hamluong"],
        soluong: json["soluong"],
        ngayDonthuoc: DateTime.parse(json["ngay_donthuoc"]),
      );

  Map<String, dynamic> toJson() => {
        "tenthuoc": tenthuoc,
        "hoatchat": hoatchat,
        "donvi": donvi,
        "hamluong": hamluong,
        "soluong": soluong,
        "ngay_donthuoc": ngayDonthuoc.toIso8601String(),
      };
}
