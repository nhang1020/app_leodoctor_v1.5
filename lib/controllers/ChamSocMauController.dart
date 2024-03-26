import 'dart:convert';

import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/ChamSocMau.dart';

import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class ChamSocMauController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<ChamSocMauData>> getChamSocMau(String khoa) async {
    List<ChamSocMauData> get = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_ChamSocMau()),
        headers: {'Authorization': 'Bearer $token'},
        body: {"makhoa": khoa},
      );
      if (response.statusCode == 200) {
        var data = ChamSocMau.fromJson(jsonDecode(response.body));
        get = data.data;
      }
    } catch (e) {
      print(e);
    }

    return get;
  }
}
