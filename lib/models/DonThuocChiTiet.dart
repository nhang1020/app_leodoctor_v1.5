// To parse this JSON data, do
//
//     final donThuocChiTiet = donThuocChiTietFromJson(jsonString);

import 'dart:convert';

DonThuocChiTiet donThuocChiTietFromJson(String str) =>
    DonThuocChiTiet.fromJson(json.decode(str));

String donThuocChiTietToJson(DonThuocChiTiet data) =>
    json.encode(data.toJson());

class DonThuocChiTiet {
  bool success;
  List<DonThuocChiTietData> data;
  String message;

  DonThuocChiTiet({
    required this.success,
    required this.data,
    required this.message,
  });

  factory DonThuocChiTiet.fromJson(Map<String, dynamic> json) =>
      DonThuocChiTiet(
        success: json["success"],
        data: List<DonThuocChiTietData>.from(
            json["data"].map((x) => DonThuocChiTietData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class DonThuocChiTietData {
  String madonthuocCt;
  dynamic madonthuoc;
  dynamic mahhvt;
  dynamic mathuoc;
  dynamic maphieuct;
  dynamic maloai;
  dynamic xqPhimHu;
  dynamic maAx;
  dynamic thongtinthau;
  dynamic ycsdks;
  dynamic hoichan;
  dynamic tinhtrangThuchien;
  dynamic tinhtrangLinhtra;
  dynamic makho;
  dynamic dongiaBv;
  dynamic thanhtien;
  dynamic giaBhyt;
  dynamic tyleTtBhyt;
  dynamic soluong;
  dynamic soluongTra;
  dynamic nguonthanhtoan;
  dynamic tennguonthanhtoan;
  dynamic songay;
  dynamic sang;
  dynamic trua;
  dynamic chieu;
  dynamic toi;
  dynamic tenkho;
  dynamic tenkhoViettat;
  dynamic lieudung;
  dynamic cachdung;
  dynamic tenviettat;
  dynamic tenthuoc;
  dynamic hoatchat;
  dynamic hamluong;
  dynamic donvi;
  dynamic mathuocTt40;
  dynamic tinhtrangthanhtoan;
  dynamic manguoitao;
  dynamic tennguoidung;
  DateTime createdAt;
  dynamic thutuIndon;
  dynamic maphieuDn;
  dynamic sophieu;
  dynamic ngaydenghi;
  dynamic tinhtrangDuyet;
  dynamic nguonttDm;

  DonThuocChiTietData({
    required this.madonthuocCt,
    required this.madonthuoc,
    required this.mahhvt,
    required this.mathuoc,
    required this.maphieuct,
    required this.maloai,
    required this.xqPhimHu,
    required this.maAx,
    required this.thongtinthau,
    required this.ycsdks,
    required this.hoichan,
    required this.tinhtrangThuchien,
    required this.tinhtrangLinhtra,
    required this.makho,
    required this.dongiaBv,
    required this.thanhtien,
    required this.giaBhyt,
    required this.tyleTtBhyt,
    required this.soluong,
    required this.soluongTra,
    required this.nguonthanhtoan,
    required this.tennguonthanhtoan,
    required this.songay,
    required this.sang,
    required this.trua,
    required this.chieu,
    required this.toi,
    required this.tenkho,
    required this.tenkhoViettat,
    required this.lieudung,
    required this.cachdung,
    required this.tenviettat,
    required this.tenthuoc,
    required this.hoatchat,
    required this.hamluong,
    required this.donvi,
    required this.mathuocTt40,
    required this.tinhtrangthanhtoan,
    required this.manguoitao,
    required this.tennguoidung,
    required this.createdAt,
    required this.thutuIndon,
    required this.maphieuDn,
    required this.sophieu,
    required this.ngaydenghi,
    required this.tinhtrangDuyet,
    required this.nguonttDm,
  });

  factory DonThuocChiTietData.fromJson(Map<String, dynamic> json) =>
      DonThuocChiTietData(
        madonthuocCt: json["madonthuoc_ct"],
        madonthuoc: json["madonthuoc"],
        mahhvt: json["mahhvt"],
        mathuoc: json["mathuoc"],
        maphieuct: json["maphieuct"],
        maloai: json["maloai"],
        xqPhimHu: json["xq_phim_hu"],
        maAx: json["ma_ax"],
        thongtinthau: json["thongtinthau"],
        ycsdks: json["ycsdks"],
        hoichan: json["hoichan"],
        tinhtrangThuchien: json["tinhtrang_thuchien"],
        tinhtrangLinhtra: json["tinhtrang_linhtra"],
        makho: json["makho"],
        dongiaBv: json["dongia_bv"],
        thanhtien: json["thanhtien"],
        giaBhyt: json["gia_bhyt"],
        tyleTtBhyt: json["tyle_tt_bhyt"],
        soluong: json["soluong"],
        soluongTra: json["soluong_tra"],
        nguonthanhtoan: json["nguonthanhtoan"],
        tennguonthanhtoan: json["tennguonthanhtoan"],
        songay: json["songay"],
        sang: json["sang"],
        trua: json["trua"],
        chieu: json["chieu"],
        toi: json["toi"],
        tenkho: json["tenkho"],
        tenkhoViettat: json["tenkho_viettat"],
        lieudung: json["lieudung"],
        cachdung: json["cachdung"],
        tenviettat: json["tenviettat"],
        tenthuoc: json["tenthuoc"],
        hoatchat: json["hoatchat"],
        hamluong: json["hamluong"],
        donvi: json["donvi"],
        mathuocTt40: json["mathuoc_tt40"],
        tinhtrangthanhtoan: json["tinhtrangthanhtoan"],
        manguoitao: json["manguoitao"],
        tennguoidung: json["tennguoidung"],
        createdAt: DateTime.parse(json["created_at"]),
        thutuIndon: json["thutu_indon"],
        maphieuDn: json["maphieu_dn"],
        sophieu: json["sophieu"],
        ngaydenghi: json["ngaydenghi"],
        tinhtrangDuyet: json["tinhtrang_duyet"],
        nguonttDm: json["nguontt_dm"],
      );

  Map<String, dynamic> toJson() => {
        "madonthuoc_ct": madonthuocCt,
        "madonthuoc": madonthuoc,
        "mahhvt": mahhvt,
        "mathuoc": mathuoc,
        "maphieuct": maphieuct,
        "maloai": maloai,
        "xq_phim_hu": xqPhimHu,
        "ma_ax": maAx,
        "thongtinthau": thongtinthau,
        "ycsdks": ycsdks,
        "hoichan": hoichan,
        "tinhtrang_thuchien": tinhtrangThuchien,
        "tinhtrang_linhtra": tinhtrangLinhtra,
        "makho": makho,
        "dongia_bv": dongiaBv,
        "thanhtien": thanhtien,
        "gia_bhyt": giaBhyt,
        "tyle_tt_bhyt": tyleTtBhyt,
        "soluong": soluong,
        "soluong_tra": soluongTra,
        "nguonthanhtoan": nguonthanhtoan,
        "tennguonthanhtoan": tennguonthanhtoan,
        "songay": songay,
        "sang": sang,
        "trua": trua,
        "chieu": chieu,
        "toi": toi,
        "tenkho": tenkho,
        "tenkho_viettat": tenkhoViettat,
        "lieudung": lieudung,
        "cachdung": cachdung,
        "tenviettat": tenviettat,
        "tenthuoc": tenthuoc,
        "hoatchat": hoatchat,
        "hamluong": hamluong,
        "donvi": donvi,
        "mathuoc_tt40": mathuocTt40,
        "tinhtrangthanhtoan": tinhtrangthanhtoan,
        "manguoitao": manguoitao,
        "tennguoidung": tennguoidung,
        "created_at": createdAt.toIso8601String(),
        "thutu_indon": thutuIndon,
        "maphieu_dn": maphieuDn,
        "sophieu": sophieu,
        "ngaydenghi": ngaydenghi,
        "tinhtrang_duyet": tinhtrangDuyet,
        "nguontt_dm": nguonttDm,
      };
}
