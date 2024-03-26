import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/BenhNhanDieuTri.dart';
import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class DieuTriBenhNhanController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<BenhNhanDTData>> getDieuTriBenhNhan(
    String maKhoa,
    String maKhu,
    String maPhong,
    String soHoSo,
    String maBA,
    String idBN,
    String hoTenBN,
  ) async {
    List<BenhNhanDTData> list = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_DieuTriBenhNhan()),
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
        var data = BenhNhanDieuTri.fromJson(jsonDecode(response.body));
        list = data.data;
      }
    } catch (e) {
      print(e);
    }

    return list;
  }
}
