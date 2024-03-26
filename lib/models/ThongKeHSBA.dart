// To parse this JSON data, do
//
//     final ThongKeHSBA = ThongKeHSBAFromJson(jsonString);

import 'dart:convert';

ThongKeHSBA ThongKeHSBAFromJson(String str) =>
    ThongKeHSBA.fromJson(json.decode(str));

String ThongKeHSBAToJson(ThongKeHSBA data) => json.encode(data.toJson());

class ThongKeHSBA {
  bool success;
  ThongKeHSBAData data;
  String message;

  ThongKeHSBA({
    required this.success,
    required this.data,
    required this.message,
  });

  factory ThongKeHSBA.fromJson(Map<String, dynamic> json) => ThongKeHSBA(
        success: json["success"],
        data: ThongKeHSBAData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class ThongKeHSBAData {
  dynamic nPkvv;
  dynamic nPdt;
  dynamic nBbhc;
  dynamic nSdks;
  dynamic nTput;
  dynamic nTtyhct;
  dynamic nDgdd;
  dynamic nChupct;
  dynamic nMonitoring;
  dynamic nGpb;
  dynamic nBdtv;
  dynamic nCv;
  dynamic nByl;
  dynamic nTtba;
  dynamic n15Ngay;
  dynamic nNhbhxh;
  dynamic nHiv;
  dynamic nPcs;
  dynamic nKhcs;
  dynamic nDhst;
  dynamic nPtd;
  dynamic nPtm;
  dynamic donthuoc;
  dynamic chandoanhinhanh;
  dynamic thamdochucnang;
  dynamic xetnghiem;
  dynamic phauthuthuat;

  ThongKeHSBAData({
    required this.nPkvv,
    required this.nPdt,
    required this.nBbhc,
    required this.nSdks,
    required this.nTput,
    required this.nTtyhct,
    required this.nDgdd,
    required this.nChupct,
    required this.nMonitoring,
    required this.nGpb,
    required this.nBdtv,
    required this.nCv,
    required this.nByl,
    required this.nTtba,
    required this.n15Ngay,
    required this.nNhbhxh,
    required this.nHiv,
    required this.nPcs,
    required this.nKhcs,
    required this.nDhst,
    required this.nPtd,
    required this.nPtm,
    required this.donthuoc,
    required this.chandoanhinhanh,
    required this.thamdochucnang,
    required this.xetnghiem,
    required this.phauthuthuat,
  });

  factory ThongKeHSBAData.fromJson(Map<String, dynamic> json) =>
      ThongKeHSBAData(
        nPkvv: json["n_pkvv"],
        nPdt: json["n_pdt"],
        nBbhc: json["n_bbhc"],
        nSdks: json["n_sdks"],
        nTput: json["n_tput"],
        nTtyhct: json["n_ttyhct"],
        nDgdd: json["n_dgdd"],
        nChupct: json["n_chupct"],
        nMonitoring: json["n_monitoring"],
        nGpb: json["n_gpb"],
        nBdtv: json["n_bdtv"],
        nCv: json["n_cv"],
        nByl: json["n_byl"],
        nTtba: json["n_ttba"],
        n15Ngay: json["n_15ngay"],
        nNhbhxh: json["n_nhbhxh"],
        nHiv: json["n_hiv"],
        nPcs: json["n_pcs"],
        nKhcs: json["n_khcs"],
        nDhst: json["n_dhst"],
        nPtd: json["n_ptd"],
        nPtm: json["n_ptm"],
        donthuoc: json["donthuoc"],
        chandoanhinhanh: json["chandoanhinhanh"],
        thamdochucnang: json["thamdochucnang"],
        xetnghiem: json["xetnghiem"],
        phauthuthuat: json["phauthuthuat"],
      );

  Map<String, dynamic> toJson() => {
        "n_pkvv": nPkvv,
        "n_pdt": nPdt,
        "n_bbhc": nBbhc,
        "n_sdks": nSdks,
        "n_tput": nTput,
        "n_ttyhct": nTtyhct,
        "n_dgdd": nDgdd,
        "n_chupct": nChupct,
        "n_monitoring": nMonitoring,
        "n_gpb": nGpb,
        "n_bdtv": nBdtv,
        "n_cv": nCv,
        "n_byl": nByl,
        "n_ttba": nTtba,
        "n_15ngay": n15Ngay,
        "n_nhbhxh": nNhbhxh,
        "n_hiv": nHiv,
        "n_pcs": nPcs,
        "n_khcs": nKhcs,
        "n_dhst": nDhst,
        "n_ptd": nPtd,
        "n_ptm": nPtm,
        "donthuoc": donthuoc,
        "chandoanhinhanh": chandoanhinhanh,
        "thamdochucnang": thamdochucnang,
        "xetnghiem": xetnghiem,
        "phauthuthuat": phauthuthuat,
      };
}
