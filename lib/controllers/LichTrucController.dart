import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/LichTruc.dart';
import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class LichTrucController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<LichTrucData> getLichTruc(String khoa) async {
    LichTrucData get = LichTrucData(tenbophan: '', mabophanCha: '', nhom: 0);

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_LichTruc()),
        headers: {'Authorization': 'Bearer $token'},
        body: {"makhoa": khoa},
      );
      if (response.statusCode == 200) {
        var data = LichTruc.fromJson(jsonDecode(response.body));
        get = data.data;
      }
    } catch (e) {
      print(e);
    }

    return get;
  }
}
