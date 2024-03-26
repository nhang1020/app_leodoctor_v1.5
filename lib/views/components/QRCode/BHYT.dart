// To parse this JSON data, do
//
//     final BHYT = BHYTFromJson(jsonString);

import 'dart:convert';

List<BHYT> BHYTFromJson(String str) =>
    List<BHYT>.from(json.decode(str).map((x) => BHYT.fromJson(x)));

String BHYTToJson(List<BHYT> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BHYT {
  String maThe;
  String hoTen;
  DateTime ngaySinh;
  int gioiTinh;
  dynamic diaChi;
  String maCoSo;
  DateTime hsdTuNgay;
  dynamic hsdDenNgay;
  DateTime ngayCap;
  String maQuanLy;
  dynamic tenChaMe;
  int maNoiSong;
  DateTime thoiDiem5Nam;
  String chuoiKiemTra;
  int maHuong;
  String noiCapDoithe;

  BHYT({
    required this.maThe,
    required this.hoTen,
    required this.ngaySinh,
    required this.gioiTinh,
    required this.diaChi,
    required this.maCoSo,
    required this.hsdTuNgay,
    required this.hsdDenNgay,
    required this.ngayCap,
    required this.maQuanLy,
    required this.tenChaMe,
    required this.maNoiSong,
    required this.thoiDiem5Nam,
    required this.chuoiKiemTra,
    required this.maHuong,
    required this.noiCapDoithe,
  });

  factory BHYT.fromJson(Map<String, dynamic> json) => BHYT(
        maThe: json["MaThe"],
        hoTen: json["HoTen"],
        ngaySinh: DateTime.parse(json["NgaySinh"]),
        gioiTinh: json["GioiTinh"],
        diaChi: json["DiaChi"],
        maCoSo: json["MaCoSo"],
        hsdTuNgay: DateTime.parse(json["HSD_TuNgay"]),
        hsdDenNgay: json["HSD_DenNgay"],
        ngayCap: DateTime.parse(json["NgayCap"]),
        maQuanLy: json["MaQuanLy"],
        tenChaMe: json["TenChaMe"],
        maNoiSong: json["MaNoiSong"],
        thoiDiem5Nam: DateTime.parse(json["ThoiDiem5Nam"]),
        chuoiKiemTra: json["ChuoiKiemTra"],
        maHuong: json["MaHuong"],
        noiCapDoithe: json["NoiCapDoithe"],
      );

  Map<String, dynamic> toJson() => {
        "MaThe": maThe,
        "HoTen": hoTen,
        "NgaySinh":
            "${ngaySinh.year.toString().padLeft(4, '0')}-${ngaySinh.month.toString().padLeft(2, '0')}-${ngaySinh.day.toString().padLeft(2, '0')}",
        "GioiTinh": gioiTinh,
        "DiaChi": diaChi,
        "MaCoSo": maCoSo,
        "HSD_TuNgay":
            "${hsdTuNgay.year.toString().padLeft(4, '0')}-${hsdTuNgay.month.toString().padLeft(2, '0')}-${hsdTuNgay.day.toString().padLeft(2, '0')}",
        "HSD_DenNgay": hsdDenNgay,
        "NgayCap":
            "${ngayCap.year.toString().padLeft(4, '0')}-${ngayCap.month.toString().padLeft(2, '0')}-${ngayCap.day.toString().padLeft(2, '0')}",
        "MaQuanLy": maQuanLy,
        "TenChaMe": tenChaMe,
        "MaNoiSong": maNoiSong,
        "ThoiDiem5Nam":
            "${thoiDiem5Nam.year.toString().padLeft(4, '0')}-${thoiDiem5Nam.month.toString().padLeft(2, '0')}-${thoiDiem5Nam.day.toString().padLeft(2, '0')}",
        "ChuoiKiemTra": chuoiKiemTra,
        "MaHuong": maHuong,
        "NoiCapDoithe": noiCapDoithe,
      };
}
