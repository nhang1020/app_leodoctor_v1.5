import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/hoiChan.dart';

import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class HoiChanController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<HoiChanData>> getHoiChan(String mahs) async {
    List<HoiChanData> hoichan = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(Uri.parse(_api.Url_BienBanHoiChan()),
          body: {'mahs': mahs}, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        var data = HoiChan.fromJson(jsonDecode(response.body));
        hoichan = data.data;
      }
    } catch (e) {
      print(e);
    }

    return hoichan;
  }
}
