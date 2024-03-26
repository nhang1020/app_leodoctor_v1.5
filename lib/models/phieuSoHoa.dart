// To parse this JSON data, do
//
//     final phieuSoHoa = phieuSoHoaFromJson(jsonString);

import 'dart:convert';

PhieuSoHoa phieuSoHoaFromJson(String str) =>
    PhieuSoHoa.fromJson(json.decode(str));

String phieuSoHoaToJson(PhieuSoHoa data) => json.encode(data.toJson());

class PhieuSoHoa {
  bool success;
  List<PhieuSoHoaData> data;
  String message;

  PhieuSoHoa({
    required this.success,
    required this.data,
    required this.message,
  });

  factory PhieuSoHoa.fromJson(Map<String, dynamic> json) => PhieuSoHoa(
        success: json["success"],
        data: List<PhieuSoHoaData>.from(
            json["data"].map((x) => PhieuSoHoaData.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class PhieuSoHoaData {
  String id;
  dynamic idEmr;
  dynamic idHsba;
  dynamic tenphieu;

  PhieuSoHoaData({
    required this.id,
    required this.idEmr,
    required this.idHsba,
    required this.tenphieu,
  });

  factory PhieuSoHoaData.fromJson(Map<String, dynamic> json) => PhieuSoHoaData(
        id: json["_id"],
        idEmr: json["id_emr"],
        idHsba: json["id_hsba"],
        tenphieu: json["tenphieu"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "id_emr": idEmr,
        "id_hsba": idHsba,
        "tenphieu": tenphieu,
      };
}

//upload
UpPhieuSoHoa upPhieuSoHoaFromJson(String str) =>
    UpPhieuSoHoa.fromJson(json.decode(str));

String upPhieuSoHoaToJson(UpPhieuSoHoa data) => json.encode(data.toJson());

class UpPhieuSoHoa {
  String mahs;
  String mabn;
  String idEmr;
  String fileName;
  String base64;

  UpPhieuSoHoa({
    required this.mahs,
    required this.mabn,
    required this.idEmr,
    required this.fileName,
    required this.base64,
  });

  factory UpPhieuSoHoa.fromJson(Map<String, dynamic> json) => UpPhieuSoHoa(
        mahs: json["mahs"],
        mabn: json["mabn"],
        idEmr: json["id_emr"],
        fileName: json["file_name"],
        base64: json["base64"],
      );

  Map<String, dynamic> toJson() => {
        "mahs": mahs,
        "mabn": mabn,
        "id_emr": idEmr,
        "file_name": fileName,
        "base64": base64,
      };
}

OutUpPhieuSoHoa outUpPhieuSoHoaFromJson(String str) =>
    OutUpPhieuSoHoa.fromJson(json.decode(str));

String outUpPhieuSoHoaToJson(OutUpPhieuSoHoa data) =>
    json.encode(data.toJson());

class OutUpPhieuSoHoa {
  bool success;
  OutUpPhieuSoHoaData data;
  String message;

  OutUpPhieuSoHoa({
    required this.success,
    required this.data,
    required this.message,
  });

  factory OutUpPhieuSoHoa.fromJson(Map<String, dynamic> json) =>
      OutUpPhieuSoHoa(
        success: json["success"],
        data: OutUpPhieuSoHoaData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
        "message": message,
      };
}

class OutUpPhieuSoHoaData {
  String idPhieu;
  String tenphieu;
  String urlHtml;

  OutUpPhieuSoHoaData({
    required this.idPhieu,
    required this.tenphieu,
    required this.urlHtml,
  });

  factory OutUpPhieuSoHoaData.fromJson(Map<String, dynamic> json) =>
      OutUpPhieuSoHoaData(
        idPhieu: json["id_phieu"],
        tenphieu: json["tenphieu"],
        urlHtml: json["url_html"],
      );

  Map<String, dynamic> toJson() => {
        "id_phieu": idPhieu,
        "tenphieu": tenphieu,
        "url_html": urlHtml,
      };
}
