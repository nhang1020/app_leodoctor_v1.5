import 'dart:convert';

import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/BenhNhan.dart';

import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class NamVienController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<BenhNhanData>> getNamVien(
      String maKhoa,
      String maKhu,
      String maPhong,
      String soHoSo,
      String maBA,
      String idBN,
      String hoTenBN,
      String maBS) async {
    List<BenhNhanData> list = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(
        Uri.parse(_api.Url_DanhSachNamVien()),
        headers: {'Authorization': 'Bearer $token'},
        body: {
          "makhoa": maKhoa,
          "makhu": maKhu,
          "maphong": maPhong,
          "sohoso": soHoSo,
          "maba": maBA,
          "idbn": idBN,
          "hotenbn": hoTenBN,
          "mabs": maBS,
        },
      );
      if (response.statusCode == 200) {
        var data = BenhNhan.fromJson(jsonDecode(response.body));
        list = data.data;
      }
    } catch (e) {
      print(e);
    }

    return list;
  }
}
