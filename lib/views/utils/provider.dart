import 'package:app_leohis/controllers/ChamSocBenhNhanController.dart';
import 'package:app_leohis/controllers/DieuTriBenhNhanController.dart';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/controllers/NamVienController.dart';
import 'package:app_leohis/controllers/QuyenKhoaPhongController.dart';
import 'package:app_leohis/controllers/readQKPtoList.dart';
import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/models/BenhNhanChamSoc.dart';
import 'package:app_leohis/models/BenhNhanDieuTri.dart';
import 'package:flutter/material.dart';

class KhoaProvider extends ChangeNotifier {
  LocalData _localData = LocalData();
  QuyenKhoaPhongController _khoaPhongController = QuyenKhoaPhongController();
  String _khoa = '';
  String get khoa => _khoa;
  List<dataKhuPhongKhoa> _lstKhoa = [];
  String _token = '';

  String _selectPhong = '';
  String _selectBacSi = '';
  String get selectPhong => _selectPhong;
  String get selectBacSi => _selectBacSi;
  set setPhong(String value) {
    _selectPhong = value;
  }

  set setBacSi(String value) {
    _selectBacSi = value;
  }

  List<BenhNhanData> listBenhNhan = [];
  List<BenhNhanDTData> listBenhNhanDieuTri = [];
  List<BenhNhanCSData> listBenhNhanChamSoc = [];
  List<dataKhuPhongKhoa> get lstKhoa => _lstKhoa;
  String get token => _token;

  //Khoa
  Future getKhoa() async {
    _token = await _localData.Shared_getToken();
    if (_token != '') {
      var lst = await _khoaPhongController.getQuyenKhoaPhong();
      _lstKhoa = readQKPtoList(data: lst).readToListKhoa();
      _khoa = await _localData.Shared_getKhoa();
    }
  }

  KhoaProvider() {
    getKhoa().then(
      (value) => getBenhNhan(),
    );
  }

  void updateKhoa(String newkhoa) {
    _khoa = newkhoa;
    notifyListeners();
  }

  //Bệnh nhân
  Future getBenhNhan() async {
    NamVienController _namVienController = NamVienController();
    ChamSocBenhNhanController _chamSocController = ChamSocBenhNhanController();
    DieuTriBenhNhanController _dieuTriController = DieuTriBenhNhanController();
    listBenhNhan = await _namVienController.getNamVien(
        _khoa, '', _selectPhong, '', '', '', '', _selectBacSi);
    listBenhNhanChamSoc = await _chamSocController.getChamSocBenhNhan(
        _khoa, '', '', '', '', '', '');
    listBenhNhanDieuTri = await _dieuTriController.getDieuTriBenhNhan(
        _khoa, '', '', '', '', '', '');

    notifyListeners();
  }
}
