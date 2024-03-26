import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/thongKeHSBA.dart';

import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class TKHSBAController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<ThongKeHSBAData> getThongKeHSBA(String mahs) async {
    ThongKeHSBAData get = ThongKeHSBAData(
        nPkvv: '0',
        nPdt: '0',
        nBbhc: '0',
        nSdks: '0',
        nTput: '0',
        nTtyhct: '0',
        nDgdd: '0',
        nChupct: '0',
        nMonitoring: '0',
        nGpb: '0',
        nBdtv: '0',
        nCv: '0',
        nByl: '0',
        nTtba: '0',
        n15Ngay: '0',
        nNhbhxh: '0',
        nHiv: '0',
        nPcs: '0',
        nKhcs: '0',
        nDhst: '0',
        nPtd: '0',
        nPtm: '0',
        donthuoc: 0,
        chandoanhinhanh: '0',
        thamdochucnang: '0',
        xetnghiem: '0',
        phauthuthuat: '0');

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_DashboardHoSoBenhAn()),
        headers: {'Authorization': 'Bearer $token'},
        body: {"mahs": mahs},
      );
      if (response.statusCode == 200) {
        var data = ThongKeHSBA.fromJson(jsonDecode(response.body));
        get = data.data;
      }
    } catch (e) {
      print(e);
    }

    return get;
  }
}
