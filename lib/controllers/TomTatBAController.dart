import 'dart:convert';

import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/tomTatBenhAn.dart';

import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class TomTatBAController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<TomTatBenhAnData>> getTomTatBenhAn(String mahs) async {
    List<TomTatBenhAnData> tomtatHSBA = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(Uri.parse(_api.Url_TomTatHoSoBenhAn()),
          body: {'mahs': mahs}, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var data = TomTatBenhAn.fromJson(jsonDecode(response.body));
        tomtatHSBA = data.data;
      }
    } catch (e) {
      print(e);
    }

    return tomtatHSBA;
  }
}
