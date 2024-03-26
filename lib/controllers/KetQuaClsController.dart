import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/ketQuaCls.dart';
import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class KetQuaClsController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<KetQuaClsData>> getKetQuaCls(String mahs, String manhomdv) async {
    List<KetQuaClsData> cls = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(Uri.parse(_api.Url_DanhSachKetQuaCls()),
          body: {'mahs': mahs, 'manhomdv_cha': manhomdv},
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        var data = KetQuaCls.fromJson(jsonDecode(response.body));

        cls = data.data;
      }
    } catch (e) {
      print(e);
    }

    return cls;
  }
}
