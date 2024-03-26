import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/soKet15Ngay.dart';
import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class SoKet15NgayController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<SoKet15NgayData>> getSoKet15Ngay(String mahs) async {
    List<SoKet15NgayData> soket15 = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(Uri.parse(_api.Url_SoKe15NgayDieuTri()),
          body: {'mahs': mahs}, headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        var data = SoKet15Ngay.fromJson(jsonDecode(response.body));
        soket15 = data.data;
      }
    } catch (e) {
      print(e);
    }

    return soket15;
  }
}
