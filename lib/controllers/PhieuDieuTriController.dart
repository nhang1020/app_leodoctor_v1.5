import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/phieuDieuTri.dart';

import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class PhieuDieuTriController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<PhieuDieuTriData>> getPhieuDieuTri(
      String mahs, String makhoa) async {
    List<PhieuDieuTriData> get = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_PhieuDieuTri()),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "mahs": mahs,
          "makhoa": "${makhoa}",
        },
      );
      if (response.statusCode == 200) {
        var data = PhieuDieuTri.fromJson(jsonDecode(response.body));
        get = data.data;
      }
    } catch (e) {
      print(e);
    }
    return get;
  }

  Future<XemDieuTri> getXemDieuTri(
    String mahs,
    String makhoa,
    String manamvien,
    String maphieudieutri,
  ) async {
    XemDieuTri get =
        XemDieuTri(success: false, data: XemDieuTriData(link: ''), message: '');

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_XemDieuTri()),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "mahs": mahs,
          "makhoa": "${makhoa}",
          "manamvien": manamvien,
          "maphieudieutri": "${maphieudieutri}"
        },
      );
      if (response.statusCode == 200) {
        var data = XemDieuTri.fromJson(jsonDecode(response.body));
        get = data;
      }
    } catch (e) {
      print(e);
    }

    return get;
  }
}
