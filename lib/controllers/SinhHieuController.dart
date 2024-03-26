import 'dart:convert';

import 'package:app_leohis/controllers/LocalData.dart';

import '../models/sinhHieu.dart';
import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class SinhHieuController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  Future<List<SinhHieuData>> getDauHieuSinhTon(String mahs) async {
    List<SinhHieuData> dauHieuData = [];

    try {
      String token = await _localData.Shared_getToken();
      final response = await http.post(Uri.parse(_api.Url_DauHieuSinhTon()),
          body: {'mahs': mahs}, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var data = SinhHieu.fromJson(jsonDecode(response.body));
        dauHieuData = data.data;
      }
    } catch (e) {
      print(e);
    }

    return dauHieuData;
  }

  Future<PostSinhHieu> post_SinhHieu(LuuSinhHieu sinhHieu) async {
    PostSinhHieu post = PostSinhHieu(success: false, message: '');

    try {
      String token = await _localData.Shared_getToken();
      final response =
          await http.post(Uri.parse(_api.Url_LuuSinhHieu()), body: {
        "mahs": "${sinhHieu.mahs}",
        "mabn": "${sinhHieu.mabn}",
        "manhapvien": "${sinhHieu.manhapvien}",
        "makhoa": "${sinhHieu.manhapvien}",
        "makhu": "${sinhHieu.makhu}",
        "maphong": "${sinhHieu.maphong}",
        "mash": "${sinhHieu.mash}",
        "ngaydo": sinhHieu.ngaydo.toIso8601String(),
        "mach": "${sinhHieu.mach}",
        "huyetap1": "${sinhHieu.huyetap1}",
        "huyetap2": "${sinhHieu.huyetap2}",
        "ha_xamlan": "${sinhHieu.haXamlan}",
        "nhietdo": "${sinhHieu.nhietdo}",
        "nhiptho": "${sinhHieu.nhiptho}",
        "SPO2": "${sinhHieu.spo2}",
        "luongnuoctieu": "${sinhHieu.luongnuoctieu}",
        "luongphan": "${sinhHieu.luongphan}",
      }, headers: {
        'Authorization': 'Bearer $token'
      });

      var data = PostSinhHieu.fromJson(jsonDecode(response.body));
      post = data;
    } catch (e) {
      print(e);
    }
    return post;
  }

  Future<PostSinhHieu> delete_SinhHieu(String maHs, String maSH) async {
    PostSinhHieu post = PostSinhHieu(success: false, message: '');

    try {
      String token = await _localData.Shared_getToken();
      final response =
          await http.post(Uri.parse(_api.Url_XoaSinhHieu()), body: {
        "mahs": maHs,
        "mash": maSH,
      }, headers: {
        'Authorization': 'Bearer $token'
      });

      var data = PostSinhHieu.fromJson(jsonDecode(response.body));
      post = data;
    } catch (e) {
      print(e);
    }

    return post;
  }
}
