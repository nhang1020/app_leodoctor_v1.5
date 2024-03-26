// To parse this JSON data, do
//
//     final AccountLogin = AccountLoginFromJson(jsonString);

import 'dart:convert';

AccountLogin AccountLoginFromJson(String str) =>
    AccountLogin.fromJson(json.decode(str));

String AccountLoginToJson(AccountLogin data) => json.encode(data.toJson());

class AccountLogin {
  bool success;
  DataAccount data;
  String message;

  AccountLogin({
    required this.success,
    required this.data,
    required this.message,
  });

  factory AccountLogin.fromJson(Map<String, dynamic> json) => AccountLogin(
        success: json["success"],
        data: DataAccount.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class DataAccount {
  String token;
  String tennguoidung;
  String tendangnhap;
  DateTime ngaysinh;
  String gioitinh;
  String dienthoai;
  String cchn;
  bool bacsi;
  String maquyenhan;
  String quyen;
  dynamic wan;
  DateTime ngaydangky;

  DataAccount({
    required this.token,
    required this.tennguoidung,
    required this.tendangnhap,
    required this.ngaysinh,
    required this.gioitinh,
    required this.dienthoai,
    required this.cchn,
    required this.bacsi,
    required this.maquyenhan,
    required this.quyen,
    required this.wan,
    required this.ngaydangky,
  });

  factory DataAccount.fromJson(Map<String, dynamic> json) => DataAccount(
        token: json["token"],
        tennguoidung: json["tennguoidung"],
        tendangnhap: json["tendangnhap"],
        ngaysinh: DateTime.parse(json["ngaysinh"]),
        gioitinh: json["gioitinh"],
        dienthoai: json["dienthoai"],
        cchn: json["cchn"],
        bacsi: json["bacsi"],
        maquyenhan: json["maquyenhan"],
        quyen: json["quyen"],
        wan: json["wan"],
        ngaydangky: DateTime.parse(json["ngaydangky"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "tennguoidung": tennguoidung,
        "tendangnhap": tendangnhap,
        "ngaysinh":
            "${ngaysinh.year.toString().padLeft(4, '0')}-${ngaysinh.month.toString().padLeft(2, '0')}-${ngaysinh.day.toString().padLeft(2, '0')}",
        "gioitinh": gioitinh,
        "dienthoai": dienthoai,
        "cchn": cchn,
        "bacsi": bacsi,
        "maquyenhan": maquyenhan,
        "quyen": quyen,
        "wan": wan,
        "ngaydangky": ngaydangky.toIso8601String(),
      };
}
