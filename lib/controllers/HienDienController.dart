import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/HienDien.dart';

import 'dart:convert';
import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class HienDienController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<HienDienData> getHienDien(String khoa) async {
    HienDienData _HienDienData = HienDienData(
        hiendien: 0,
        nam: 0,
        nu: 0,
        bsDieutri: 0,
        hosoNgoaitru: 0,
        benhNang: 0,
        bhyt: 0,
        thuphi: 0,
        treem: 0,
        bvsk: 0,
        mienphi: 0);

    try {
      String token = await _localData.Shared_getToken();
      String tenDangNhap = await _localData.Shared_getTenDangnhap();

      final response = await http.post(
        Uri.parse(_api.Url_HienDien()),
        headers: {'Authorization': 'Bearer $token'},
        body: {"makhoa": khoa, "tendangnhap": tenDangNhap},
      );
      if (response.statusCode == 200) {
        var data = HienDien.fromJson(jsonDecode(response.body));
        _HienDienData = data.data;
      }
    } catch (e) {
      print(e);
    }

    return _HienDienData;
  }
}
