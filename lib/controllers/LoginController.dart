import 'dart:convert';

import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/DangXuat.dart';
import 'package:app_leohis/models/TokenTinNhan.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/LocalAccount.dart';
import '../models/taiKhoan.dart';
import '../APIs/APIs.dart';
import 'package:http/http.dart' as http;

class LoginController {
  APIs _api = APIs();
  LocalData _localData = LocalData();

  connectHttp(String Tendangnhap, String MatKhau) async {
    final response = await http.post(Uri.parse(_api.Url_Login()), body: {
      'tendangnhap': Tendangnhap,
      'matkhau': MatKhau,
    });
    return response;
  }

  Future<int> login(String Tendangnhap, String MatKhau, bool Save) async {
    try {
      AccountLogin accountLogin;

      final response = await http.post(Uri.parse(_api.Url_Login()), body: {
        'tendangnhap': Tendangnhap,
        'matkhau': MatKhau,
      });

      if (response.statusCode == 200) {
        accountLogin = AccountLogin.fromJson(jsonDecode(response.body));
        if (Save == true) {
          // Lưu tài khoản - mật khẩu (Hive)
          _localData.Hive_saveLocalAccount(Tendangnhap, MatKhau, Save);
          // Lưu thông tin tài khoản (Shared)
          _localData.Shared_saveLocalDataAccount(accountLogin.data);
        }
        return 0;
      } else {
        _localData.Hive_clearAccount();
        return 1;
      }
    } catch (e) {
      return 2;
    }
  }

  Future<bool> continueLogin() async {
    // Shared
    var checkShared = await SharedPreferences.getInstance();
    final json = checkShared.getString('dataAccount');
    // Hive
    var checkHive = await Hive.openBox<Account>('infoAccount');

    if (checkHive.isNotEmpty && json != null) {
      return true;
    }
    return false;
  }

  Future<DataAccount?> getDataAccount(
      String Tendangnhap, String MatKhau) async {
    AccountLogin accountLogin;
    DataAccount? dataAccount;
    final response = await http.post(Uri.parse(_api.Url_Login()), body: {
      'tendangnhap': Tendangnhap,
      'matkhau': MatKhau,
    });

    if (response.statusCode == 200) {
      accountLogin = AccountLogin.fromJson(jsonDecode(response.body));
      dataAccount = accountLogin.data;
    }
    return dataAccount;
  }

  Future<TokenTinNhan> saveTokenTinNhan(String token) async {
    TokenTinNhan outp = TokenTinNhan(success: false, data: [], message: '');

    try {
      final response = await http.post(Uri.parse(_api.Url_LuuTokenTinNhan()),
          body: {'token': token}, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var data = TokenTinNhan.fromJson(jsonDecode(response.body));
        outp = data;
      }
    } catch (e) {
      print(e);
    }

    return outp;
  }

  Future<DangXuat> LogOut(String token) async {
    DangXuat outp = DangXuat(success: false, data: [], message: '');

    try {
      final response = await http.post(Uri.parse(_api.Url_DangXuat()),
          body: {'token': token}, headers: {'Authorization': 'Bearer $token'});
      if (response.statusCode == 200) {
        var data = DangXuat.fromJson(jsonDecode(response.body));
        outp = data;
      }
    } catch (e) {
      print(e);
    }

    return outp;
  }
}
