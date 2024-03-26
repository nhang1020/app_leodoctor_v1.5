import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/quyenKhoaPhong.dart';
import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class QuyenKhoaPhongController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<DataQkp>> getQuyenKhoaPhong() async {
    List<DataQkp> lstQKP = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.get(Uri.parse(_api.Url_QuyenKhoaPhong()),
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var data = QuyenKhoaPhong.fromJson(jsonDecode(response.body));
        lstQKP = data.dataQkp;
      }
    } catch (e) {
      print(e);
    }

    return lstQKP;
  }
}
