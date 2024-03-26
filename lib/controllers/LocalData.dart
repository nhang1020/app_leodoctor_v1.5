import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/LocalAccount.dart';
import '../models/taiKhoan.dart';

class LocalData {
  //   Hive
  Hive_saveLocalAccount(
      String Tendangnhap, String MatKhau, bool TrangThai) async {
    var box = await Hive.openBox<Account>('infoAccount');
    box.put(
      '1',
      Account(
        UsernName: Tendangnhap,
        Password: MatKhau,
        Status: TrangThai,
      ),
    );
  }

  Future<Account?> Hive_getLocalAccount() async {
    Account? account;
    var box = await Hive.openBox<Account>('infoAccount');
    if (!box.isEmpty) {
      account = box.getAt(0);
    }
    return account;
  }

  Hive_clearAccount() async {
    var box = await Hive.openBox<Account>('infoAccount');
    box.clear();
  }

  //   Shared
  Shared_saveLocalDataAccount(DataAccount? accountDaTa) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = jsonEncode(accountDaTa);
    prefs.setString('dataAccount', json);
  }

  Future<DataAccount?> Shared_getLocalDataAccount() async {
    DataAccount? data;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('dataAccount');
    if (json != null) {
      data = DataAccount.fromJson(jsonDecode(json));
    }
    return data;
  }

  Future<String> Shared_getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = '';
    final json = prefs.getString('dataAccount');
    if (json != null) {
      Map<String, dynamic> map = jsonDecode(json);
      token = map['token'];
    }
    return token;
  }

  Future<String> Shared_getTenDangnhap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tendangnhap = '';
    final json = prefs.getString('dataAccount');
    if (json != null) {
      Map<String, dynamic> map = jsonDecode(json);
      tendangnhap = map['tendangnhap'];
    }
    return tendangnhap;
  }

  Future<String> Shared_getTenNguoidung() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String tennguoidung = '';
    final json = prefs.getString('dataAccount');
    if (json != null) {
      Map<String, dynamic> map = jsonDecode(json);
      tennguoidung = map['tennguoidung'];
    }
    return tennguoidung;
  }

  Future<bool> Shared_getQuyenBacSi() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool bacsi = false;
    final json = prefs.getString('dataAccount');
    if (json != null) {
      Map<String, dynamic> map = jsonDecode(json);
      bacsi = map['bacsi'];
    }
    return bacsi;
  }

  Shared_clearLocalDataAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.remove('dataAccount');
    await prefs.clear();
  }

  Shared_saveKhoa(String khoa) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('khoa', khoa);
  }

  Future<dynamic> Shared_getKhoa() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('khoa') ?? '';
  }

  Shared_clearKhoa(String khoa) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('khoa');
  }
}
