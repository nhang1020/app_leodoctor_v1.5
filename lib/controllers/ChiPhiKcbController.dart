import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/chiPhiKcb.dart';
import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class ChiPhiKcbController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<ChiPhiKcbData> getChiPhiKcb(String mahs) async {
    ChiPhiKcbData chiphi = ChiPhiKcbData(
        tongchiphikcb: 0,
        tongtiennguoibenhtra: 0,
        dathu: 0,
        quybhyttt: 0,
        nguoibenhcct: 0,
        nguoibenhtt: 0,
        tamung: 0,
        hoantra: 0,
        thuthem: 0);

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_ChiPhiKcb()),
        headers: {'Authorization': 'Bearer $token'},
        body: {"mahs": mahs},
      );
      if (response.statusCode == 200) {
        var data = ChiPhiKcb.fromJson(jsonDecode(response.body));
        chiphi = data.data;
      }
    } catch (e) {
      print(e);
    }

    return chiphi;
  }
}
