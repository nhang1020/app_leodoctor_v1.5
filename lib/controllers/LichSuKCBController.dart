import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';

import '../models/lichSuKham.dart';
import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class con_LichSuKham {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<LichSuKhamData>> getLichSuKham(String mabn) async {
    List<LichSuKhamData> get = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_LichSuKham()),
        headers: {'Authorization': 'Bearer $token'},
        body: {"mabn": mabn},
      );
      if (response.statusCode == 200) {
        var data = LichSuKham.fromJson(jsonDecode(response.body));

        get = data.data;
      }
    } catch (e) {
      print(e);
    }

    return get;
  }
}
