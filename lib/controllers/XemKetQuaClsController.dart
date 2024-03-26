import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/xemKetQuaCls.dart';
import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class XemKetQuaClsController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<XemKetQuaClsData> getDataCls(String? machidinh_dvct) async {
    XemKetQuaClsData cls = XemKetQuaClsData(link: '');

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(Uri.parse(_api.Url_XemKetQuaCls()),
          body: {'machidinh_dvct': machidinh_dvct},
          headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var data = XemKetQuaCls.fromJson(jsonDecode(response.body));
        cls = data.data;
      }
    } catch (e) {
      print(e);
    }

    return cls;
  }

  Future<bool> getKetQuaCls(String? machidinh_dvct) async {
    String token = await _localData.Shared_getToken();
    final response = await http.post(Uri.parse(_api.Url_XemKetQuaCls()),
        body: {'machidinh_dvct': machidinh_dvct},
        headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var data = XemKetQuaCls.fromJson(jsonDecode(response.body));
      return data.success;
    }
    return false;
  }
}
