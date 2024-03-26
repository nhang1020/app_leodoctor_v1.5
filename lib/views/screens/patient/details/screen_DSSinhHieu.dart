import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/controllers/SinhHieuController.dart';
import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/models/sinhHieu.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/signalsCard.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/table_DoSinhHieu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'widgets/emptyPage.dart';

// ignore: must_be_immutable
class Screen_DSSinhHieu extends StatefulWidget {
  Screen_DSSinhHieu({
    super.key,
    required this.patient,
  });
  List<SinhHieuData> listSinhHieu = [];
  BenhNhanData patient;

  @override
  State<Screen_DSSinhHieu> createState() => _Screen_DSSinhHieuState();
}

class _Screen_DSSinhHieuState extends State<Screen_DSSinhHieu> {
  SinhHieuController _sinhHieuController = SinhHieuController();
  LocalData _localData = LocalData();
  String tennguoidung = '';
  bool bacsi = false;

  double bmi(String? cao, String? nang) {
    if (cao != null && nang != null)
      return int.parse(nang) /
          ((int.parse(cao) / 100) * (int.parse(cao) / 100));
    else
      return 0;
  }

  int selectRow = -1;
  List<SinhHieuData> listSinhHieu = [];

  void getDataSinhHieu() async {
    try {
      tennguoidung = await _localData.Shared_getTenNguoidung();
      bacsi = await _localData.Shared_getQuyenBacSi();

      listSinhHieu =
          await _sinhHieuController.getDauHieuSinhTon(widget.patient.mahs);
      setState(() {
        tennguoidung;
        bacsi;
        listSinhHieu;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataSinhHieu();
  }

  bool isDescDate = false;
  @override
  Widget build(BuildContext context) {
    return listSinhHieu.length <= 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 7, left: 14, right: 14),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: primaryColor,
                  boxShadow: [],
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(15)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.sp,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: widget.patient.gioitinh == '1'
                                        ? AssetImage(
                                            "assets/images/medicals/patient_male.png")
                                        : AssetImage(
                                            "assets/images/medicals/patient_female.png"),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                children: [
                                  Text(
                                    widget.patient.hotenbn,
                                    style: TextStyle(
                                        color: Theme.of(context).cardColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Số hồ sơ: ${widget.patient.sohoso}",
                                    style: TextStyle(
                                        color: Theme.of(context).cardColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        MyButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => Table_DoSinhHieu(
                                patient: widget.patient,
                              ),
                            ).then((Val) {
                              if (Val == 1) {
                                getDataSinhHieu();
                              }
                            });
                          },
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: primaryColor,
                          ),
                          color: Theme.of(context).cardColor,
                          label: "Thêm",
                          textColor: primaryColor,
                          padding: EdgeInsets.all(5),
                        )
                      ],
                    ),
                    Divider(
                      height: 10,
                      color: themeModeColor,
                    ),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            RowInfo(
                              title: "Chiều cao",
                              info: checkString(listSinhHieu[0].chieucao),
                              icon: FontAwesomeIcons.personArrowUpFromLine,
                            ),
                            RowInfo(
                              title: "Cân nặng",
                              info: checkString(listSinhHieu[0].cannang),
                              icon: FontAwesomeIcons.weightScale,
                            ),
                            RowInfo(
                              title: "BMI",
                              info:
                                  checkString(listSinhHieu[0].chieucao) != "--"
                                      ? bmi(listSinhHieu[0].chieucao,
                                              listSinhHieu[0].cannang)
                                          .toStringAsFixed(2)
                                      : "",
                              icon: FontAwesomeIcons.cloudscale,
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                child: Container(
                  alignment: Alignment.center,
                  width: screen(context).width,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Lịch sử đo sinh hiệu",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: listSinhHieu.length == 0
                      ? EmptyList()
                      : ListView(
                          children: <Widget>[
                            for (int index = 0;
                                index < listSinhHieu.length;
                                index++)
                              buildItem(listSinhHieu[index], index),
                          ],
                        ),
                ),
              )
            ],
          );
  }

  // double _width = 50;
  Widget buildItem(SinhHieuData data, int index) {
    return InkWell(
      onTap: () {
        if (selectRow == index) {
          setState(() {
            selectRow = -1;
          });
        } else {
          setState(() {
            selectRow = index;
          });
        }
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SignalsCard(sinhHieu: data),
              Visibility(
                visible: selectRow == index,
                child: Container(
                  child: Column(
                    children: [
                      Divider(
                        height: 1,
                        color: primaryColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Table_DoSinhHieu(
                                    patient: widget.patient,
                                    sinhHieu: data,
                                    mash: data.madhst,
                                  ),
                                ).then((Val) {
                                  if (Val != 0) {
                                    getDataSinhHieu();
                                  }
                                });
                              },
                              label: "Sửa",
                              color: primaryColor.withOpacity(.1),
                              icon: Icon(
                                Icons.edit_road_outlined,
                                color: primaryColor,
                              ),
                              textColor: primaryColor,
                            ),
                            MyButton(
                              onPressed: () {
                                showReminder(data);
                                setState(() {
                                  selectRow = -1;
                                });
                              },
                              label: "Xóa",
                              color: primaryColor.withOpacity(.1),
                              icon: Icon(
                                Icons.delete_sweep_outlined,
                                color: primaryColor,
                              ),
                              textColor: primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showReminder(SinhHieuData data) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Thông báo',
            //style: TextStyle(color: Colors.green),
          ),
          content: Text('Bạn chắc chắn xóa sinh hiệu này?'),
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
                if (data.tennguoidung != tennguoidung) {
                  Navigator.pop(context);

                  showMessage(context,
                      message: 'Không thể lưu phiếu chăm sóc này',
                      type: "error");
                } else {
                  PostSinhHieu post = await _sinhHieuController.delete_SinhHieu(
                      widget.patient.mahs, data.madhst);
                  getDataSinhHieu();
                  setState(() {
                    listSinhHieu;
                  });
                  Navigator.of(context).pop();
                  post.success == true
                      ? showMessage(context,
                          message: '${post.message}', type: "success")
                      : showMessage(context,
                          message: '${post.message}', type: "warning");
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class RowInfo extends StatelessWidget {
  const RowInfo(
      {super.key, required this.title, required this.info, required this.icon});

  final String title;
  final String? info;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: screen(context).width / 3 - 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).cardColor),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Theme.of(context).cardColor),
              ),
              Text(
                checkString(info),
                style: TextStyle(color: Theme.of(context).cardColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
