import 'dart:convert';

import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/donThuocChiTiet.dart';

import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class ChiTietDonThuocController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<DonThuocChiTietData>> getDonThuocChiTiet(
      String madonthuoc) async {
    List<DonThuocChiTietData> get = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_DonThuocChiTiet()),
        headers: {'Authorization': 'Bearer $token'},
        body: {"madonthuoc": madonthuoc},
      );
      if (response.statusCode == 200) {
        var data = DonThuocChiTiet.fromJson(jsonDecode(response.body));
        get = data.data;
      }
    } catch (e) {
      print(e);
    }

    return get;
  }
}
