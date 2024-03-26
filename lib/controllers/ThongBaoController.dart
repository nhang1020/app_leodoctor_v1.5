import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/ThongBao.dart';
import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class ThongBaoController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<ThongBaoData>> getThongBao() async {
    List<ThongBaoData> list = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.get(Uri.parse(_api.Url_ThongBao()),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var data = ThongBao.fromJson(jsonDecode(response.body));
        list = data.data;
      }
    } catch (e) {
      print(e);
    }

    return list;
  }
}
