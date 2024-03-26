import 'package:app_leohis/controllers/LichTrucController.dart';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/LichTruc.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicons/unicons.dart';

import '../../utils/contants.dart';

class Screen_LichTruc extends StatefulWidget {
  const Screen_LichTruc({super.key});

  @override
  State<Screen_LichTruc> createState() => _Screen_LichTrucState();
}

class _Screen_LichTrucState extends State<Screen_LichTruc> {
  LocalData localData = LocalData();
  String? khoa;
  bool load = false;
  LichTrucData _scheduleData =
      LichTrucData(tenbophan: '', mabophanCha: '', nhom: 0);
  LichTrucController _conSchedule = LichTrucController();
  String selectedValue = "khoahscc";
  List<String> _lstBacSi = [];
  List<String> _lstDieuDuong = [];
  List<String> _lstHoLy = [];
  bool _showBS = true;
  bool _showDD = true;
  bool _showHL = true;
  DateTime today = DateTime.now();

  loadData() async {
    try {
      _scheduleData = await _conSchedule.getLichTruc(selectedValue);

      setState(() {
        _scheduleData;
        _lstBacSi.clear();
        _lstDieuDuong.clear();
        _lstHoLy.clear();
        if (_scheduleData.bacsi != null) {
          _lstBacSi = _scheduleData.bacsi!.split(';');
        }

        if (_scheduleData.holy != null) {
          _lstHoLy = _scheduleData.holy!.split(';');
        }
        if (_scheduleData.dieuduong != null) {
          _lstDieuDuong = _scheduleData.dieuduong!.split(';');
        }
      });
    } catch (e) {}
  }

  readKhoa() async {
    setState(() {
      load = true;
    });
    try {
      khoa = await localData.Shared_getKhoa();
      if (khoa != null) selectedValue = khoa!;
    } catch (e) {
    } finally {
      setState(() {
        load = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    readKhoa();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    // Size screen = screen(context);
    return load
        ? Loading()
        : SingleChildScrollView(
            child: Column(
              children: [
                toDay(),
                buildTableBS("DANH SÁCH BÁC SĨ (${_lstBacSi.length})",
                    FontAwesomeIcons.userDoctor),
                buildTableDD("DANH SÁCH ĐIỀU DƯỠNG (${_lstDieuDuong.length})",
                    FontAwesomeIcons.userNurse),
                buildTableHL("DANH SÁCH HỘ LÝ (${_lstHoLy.length})",
                    FontAwesomeIcons.person),
              ],
            ),
          );
  }

  Widget buildTableBS(String title, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        child: InkWell(
          onTap: () {
            setState(() {
              _showBS = !_showBS;
            });
          },
          child: Column(
            children: [
              topTable(title),
              Visibility(
                visible: _showBS,
                child: bodyTable(_lstBacSi, icon),
              ),
              bottomTable(_showBS),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTableDD(String title, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: [],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        child: InkWell(
          onTap: () {
            setState(() {
              _showDD = !_showDD;
            });
          },
          child: Column(
            children: [
              topTable(title),
              Visibility(
                visible: _showDD,
                child: bodyTable(_lstDieuDuong, icon),
              ),
              bottomTable(_showDD),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTableHL(String title, IconData icon) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        boxShadow: [],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Card(
        child: InkWell(
          onTap: () {
            setState(() {
              _showHL = !_showHL;
            });
          },
          child: Column(
            children: [
              topTable(title),
              Visibility(
                visible: _showHL,
                child: bodyTable(_lstHoLy, icon),
              ),
              bottomTable(_showHL)
            ],
          ),
        ),
      ),
    );
  }

  topTable(String title) {
    return Container(
      alignment: Alignment.center,
      width: screen(context).width,
      padding: EdgeInsets.symmetric(vertical: 10),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
  }

  bodyTable(List<String> list, IconData icon) {
    return Container(
      child: Column(
        children: [
          for (var item in list)
            Container(
              margin: EdgeInsets.symmetric(vertical: 7),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(
                  icon,
                  color: primaryColor,
                ),
                title: Text(
                  item,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  bottomTable(bool show) {
    return Container(
      decoration: BoxDecoration(
          color: themeModeColor, borderRadius: BorderRadius.circular(10)),
      child: Icon(
        show ? UniconsLine.angle_up : UniconsLine.angle_down,
        color: primaryColor,
        size: 30,
      ),
    );
  }

  Widget toDay() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Ngày',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: primaryColor),
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              '${today.day < 10 ? '0${today.day}' : today.day}',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            'Tháng',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: primaryColor),
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              '${today.month < 10 ? '0${today.month}' : today.month}',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
