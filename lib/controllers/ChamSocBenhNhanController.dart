import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/BenhNhanChamSoc.dart';
import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class ChamSocBenhNhanController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<BenhNhanCSData>> getChamSocBenhNhan(
    String maKhoa,
    String maKhu,
    String maPhong,
    String soHoSo,
    String maBA,
    String idBN,
    String hoTenBN,
    // String maBS,
  ) async {
    String token = await _localData.Shared_getToken();
    List<BenhNhanCSData> list = [];

    try {
      final response = await http.post(
        Uri.parse(_api.Url_ChamSocBenhNhan()),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "makhoa": maKhoa,
          "makhu": maKhu,
          "maphong": maPhong,
          "sohoso": soHoSo,
          "maba": maBA,
          "idbn": idBN,
          "start": '0',
          "limit": '5'
        },
      );
      if (response.statusCode == 200) {
        var data = BenhNhanChamSoc.fromJson(jsonDecode(response.body));
        list = data.data;
      }
    } catch (e) {
      print(e);
    }

    return list;
  }
}
