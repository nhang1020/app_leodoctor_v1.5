import 'dart:convert';

import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/donThuoc.dart';

import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class DonThuocController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<DonThuocData>> getDonThuoc(String mahs) async {
    List<DonThuocData> get = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_DonThuoc()),
        headers: {'Authorization': 'Bearer $token'},
        body: {"mahs": mahs},
      );
      if (response.statusCode == 200) {
        var data = DonThuoc.fromJson(jsonDecode(response.body));

        get = data.data;
      }
    } catch (e) {
      print(e);
    }

    return get;
  }
}
