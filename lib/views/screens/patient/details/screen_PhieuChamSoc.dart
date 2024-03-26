import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/controllers/PhieuChamSocController.dart';
import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/models/phieuChamSoc.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/components/card_Data.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/container_ThongTinBN.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/line_TenChucNang.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/loadingPage.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/table_PhieuChamSoc.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../../utils/contants.dart';
import 'widgets/emptyPage.dart';
import 'widgets/table_ChamSocMau.dart';

// ignore: must_be_immutable
class Screen_PhieuChamSoc extends StatefulWidget {
  BenhNhanData patient;
  Screen_PhieuChamSoc({super.key, required this.patient});

  @override
  State<Screen_PhieuChamSoc> createState() => _Screen_PhieuChamSocState();
}

class _Screen_PhieuChamSocState extends State<Screen_PhieuChamSoc> {
  String tennguoidung = '';
  LocalData _localData = LocalData();
  PhieuChamSocController _conPhieuSamSoc = PhieuChamSocController();
  List<PhieuChamSocData> _listPhieuCS = [];
  PhieuChamSocController _chamSocController = PhieuChamSocController();
  bool loading = false;
  PhieuChamSocData? _phieuChamSoc;

  loadData() async {
    tennguoidung = await _localData.Shared_getTenNguoidung();
    setState(() {
      loading = true;
      tennguoidung;
    });
    try {
      _listPhieuCS = await _conPhieuSamSoc.getPhieuChamSoc(widget.patient.mahs);

      setState(() {
        _listPhieuCS;
      });
    } catch (e) {
    } finally {
      try {
        setState(() {
          loading = false;
        });
      } catch (e) {}
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: menuActionButton(),
      body: Column(
        children: [
          Container_TopView(patient: widget.patient),
          Line_TenChucNang(name: 'phiếu chăm sóc  (${_listPhieuCS.length})'),
          Expanded(
            // height: screen(context).height,
            child: loading
                ? Loading()
                : _listPhieuCS.length == 0
                    ? EmptyList(listName: "phiếu chăm sóc")
                    : SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Wrap(
                          children: <Widget>[
                            for (int index = 0;
                                index < _listPhieuCS.length;
                                index++)
                              viewPhieuChamSoc(_listPhieuCS[index], index),
                          ],
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget viewPhieuChamSoc(PhieuChamSocData data, int index) {
    return Card(
      margin: EdgeInsets.all(7),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: isSmallScreen(context)
            ? screen(context).width
            : screen(context).width / 2 - 17,
        child: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${formatTime(data.ngaylap)}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: primaryColor),
                          ),
                          Text("${formatDate(data.ngaylap)}"),
                        ],
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 2,
                      color: primaryColor,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Chip(
                              backgroundColor: Colors.transparent,
                              avatar: Icon(UniconsLine.user_nurse,
                                  color: primaryColor, size: 17),
                              label: Text(
                                "${checkString(data.nguoilap)}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.black26),
                Visibility(
                  visible: true,
                  child: Container(
                    child: Column(children: [
                      Card_Data(
                          title: "Chẩn đoán: ",
                          text: checkString(data.chandoan).trim()),
                      Card_Data(
                          title: 'Diễn biến',
                          text: checkString(data.dienbien).trim()),
                      Card_Data(
                          title: "Y lệnh: ",
                          text: checkString(data.ylenh).trim()),
                      Divider(color: Colors.black26),
                    ]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: MyButton(
                          onPressed: () {
                            if (int.parse(data.soluongDaky) > 0 &&
                                data.nguoilap != tennguoidung) {
                              Navigator.pop(context);

                              showMessage(context,
                                  message: "Không thể sửa phiếu chăm sóc này",
                                  type: "error");
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => Table_PhieuChamSoc(
                                  patient: widget.patient,
                                  pcs: data,
                                  maPhieu: data.maphieu,
                                ),
                              ).then((val) {
                                if (val == 1) loadData();
                              });
                            }
                          },
                          label: "Sửa",
                          color: primaryColor.withOpacity(.1),
                          icon: Icon(
                            Icons.edit_road_outlined,
                            color: primaryColor,
                          ),
                          textColor: primaryColor,
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: MyButton(
                          onPressed: () {
                            _phieuChamSoc = data;
                            showDialog(
                                context: context,
                                builder: (context) => Table_PhieuChamSoc(
                                      patient: widget.patient,
                                      maPhieu: '',
                                      pcs: _phieuChamSoc,
                                    )).then((val) {
                              if (val == 1) loadData();
                            });
                          },
                          label: "Chép mẫu",
                          color: primaryColor.withOpacity(.1),
                          icon: Icon(
                            Icons.copy_all,
                            color: primaryColor,
                          ),
                          textColor: primaryColor,
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        flex: 1,
                        child: MyButton(
                          onPressed: () {
                            showReminder(data);
                          },
                          label: "Xóa",
                          color: primaryColor.withOpacity(.1),
                          icon: Icon(
                            Icons.delete_sweep_outlined,
                            color: primaryColor,
                          ),
                          textColor: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                //  Container(
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 17,
                //       vertical: 10,
                //     ),
                //     child: Text(
                //       "Xem chi tiết",
                //       style: TextStyle(
                //         color: primaryColor,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //     decoration: BoxDecoration(
                //       color: primaryColor.withOpacity(.1),
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showReminder(PhieuChamSocData data) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Thông báo',
            //style: TextStyle(color: Colors.green),
          ),
          content: Text('Bạn chắc chắn xóa phiếu chăm sóc này?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Đóng'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(
                'Xóa',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                if (int.parse(data.soluongDaky) > 0 ||
                    data.nguoilap != tennguoidung) {
                  Navigator.pop(context);

                  showMessage(context,
                      message: 'Không thể xóa phiếu chăm sóc này',
                      type: "error");
                } else {
                  OutputPhieuChamSoc output = await _chamSocController
                      .delete_PhieuChamSoc(widget.patient.mahs, data.maphieu);
                  loadData();
                  setState(() {
                    _listPhieuCS;
                  });
                  Navigator.of(context).pop();
                  output.success == true
                      ? showMessage(context,
                          message: '${output.message}', type: "success")
                      : showMessage(context,
                          message: '${output.message}', type: "error");
                }
              },
            ),
          ],
        );
      },
    );
  }

  menuActionButton() {
    return SpeedDial(
      childMargin: EdgeInsets.all(10),
      icon: Icons.add, //icon on Floating action button
      activeIcon: Icons.close, //icon when menu is expanded on button
      backgroundColor: primaryColor, //background color of button
      foregroundColor: themeModeColor, //font color, icon color in button
      activeBackgroundColor:
          primaryColor, //background color when menu is expanded
      activeForegroundColor: themeModeColor,
      buttonSize: Size(60, 60), //button size
      visible: true,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      elevation: 8.0, //shadow elevation of button
      shape: CircleBorder(), //shape of button
      children: [
        SpeedDialChild(
          child: Icon(Icons.add_card),
          foregroundColor: primaryColor,
          label: 'Thêm mới',
          labelStyle: TextStyle(fontSize: 18.0, color: primaryColor),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => Table_PhieuChamSoc(
                      patient: widget.patient,
                      maPhieu: '',
                    )).then((val) {
              if (val == 1) loadData();
            });
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.copy),
          foregroundColor: primaryColor,
          label: 'Chọn mẫu',
          labelStyle: TextStyle(fontSize: 18.0, color: primaryColor),
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => Table_ChamSocMau(
                      patient: widget.patient,
                      maPhieu: '',
                    )).then((val) {
              if (val == 1) loadData();
            });
          },
        ),
      ],
    );
  }
}
