import 'dart:convert';

import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/phieuChamSoc.dart';

import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class PhieuChamSocController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<PhieuChamSocData>> getPhieuChamSoc(String mahs) async {
    List<PhieuChamSocData> get = [];

    try {
      String token = await _localData.Shared_getToken();

      final response = await http.post(
        Uri.parse(_api.Url_PhieuChamSoc()),
        headers: {'Authorization': 'Bearer $token'},
        body: {"mahs": mahs},
      );
      if (response.statusCode == 200) {
        var data = PhieuChamSoc.fromJson(jsonDecode(response.body));

        get = data.data;
      }
    } catch (e) {
      print(e);
    }

    return get;
  }

  Future<OutputPhieuChamSoc> post_PhieuChamSoc(
      LuuPhieuChamSoc pcs, String? maphieu) async {
    String token = await _localData.Shared_getToken();
    OutputPhieuChamSoc output = OutputPhieuChamSoc(success: false, message: '');
    try {
      final response =
          await http.post(Uri.parse(_api.Url_LuuPhieuChamSoc()), body: {
        "mahs": "${pcs.mahs}",
        "mabn": "${pcs.mabn}",
        "manhapvien": "${pcs.manhapvien}",
        "manamvien": "${pcs.manamvien}",
        "makhoa": "${pcs.makhoa}",
        "maphong": "${pcs.maphong}",
        "chandoanicd": "${pcs.chandoanicd}",
        "chandoan": "${pcs.chandoan}",
        "maphieu": maphieu,
        "ngaylap": pcs.ngaylap.toIso8601String(),
        "dienbien": "${pcs.dienbien}",
        "ylenh": "${pcs.ylenh}"
      }, headers: {
        'Authorization': 'Bearer $token'
      });

      var data = OutputPhieuChamSoc.fromJson(jsonDecode(response.body));
      output = data;
    } catch (e) {
      print(e);
    }
    return output;
  }

  Future<OutputPhieuChamSoc> delete_PhieuChamSoc(
      String mahs, String maphieu) async {
    OutputPhieuChamSoc output = OutputPhieuChamSoc(success: false, message: '');
    try {
      String token = await _localData.Shared_getToken();
      final response =
          await http.post(Uri.parse(_api.Url_XoaPhieuChamSoc()), body: {
        "mahs": mahs,
        "maphieu": maphieu,
      }, headers: {
        'Authorization': 'Bearer $token'
      });
      var data = OutputPhieuChamSoc.fromJson(jsonDecode(response.body));
      output = data;
    } catch (e) {
      print(e);
    }

    return output;
  }
}
