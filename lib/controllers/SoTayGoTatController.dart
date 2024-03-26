import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/soTayGotat.dart';

import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class SoTayGoTatController {
  APIs _api = APIs();
  LocalData _localData = LocalData();
  List<SoTayGoTatData> soTay = [
    SoTayGoTatData(tugotat: 'Dv', noidung: 'Đơn vị tính'),
    SoTayGoTatData(tugotat: '+', noidung: 'Positive'),
    SoTayGoTatData(tugotat: 'HIV', noidung: 'Không phản ứng với test HIV'),
  ];

  Future<List<SoTayGoTatData>> getSoTayGoTat() async {
    List<SoTayGoTatData> lst = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.get(Uri.parse(_api.Url_SoTayGoTat()),
          headers: {'Authorization': 'Bearer $token'});

      if (response.statusCode == 200) {
        var data = SoTayGoTat.fromJson(jsonDecode(response.body));
        lst = data.data;
      }
    } catch (e) {
      print(e);
    }

    return soTay;
  }
}
