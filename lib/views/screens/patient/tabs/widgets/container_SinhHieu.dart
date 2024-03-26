import 'package:app_leohis/controllers/SinhHieuController.dart';
import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/models/sinhHieu.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/screens/containBodyScreen.dart';
import 'package:app_leohis/views/screens/patient/details/screen_DSSinhHieu.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/loadingPage.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/signalsCard.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/table_DoSinhHieu.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class Container_SinhHieu extends StatefulWidget {
  BenhNhanData patient;

  Container_SinhHieu({super.key, required this.patient});

  @override
  State<Container_SinhHieu> createState() => _Container_SinhHieuState();
}

class _Container_SinhHieuState extends State<Container_SinhHieu> {
  bool show = false;
  SinhHieuController _con_SinhHieu = SinhHieuController();
  List<SinhHieuData> _listSinhHieu = [];
  bool loadingSH = false;
  void getDataSinhHieu() async {
    setState(() {
      loadingSH = true;
    });
    try {
      _listSinhHieu =
          await _con_SinhHieu.getDauHieuSinhTon(widget.patient.mahs);
      setState(() {
        _listSinhHieu;
      });
    } catch (e) {
    } finally {
      try {
        setState(() {
          loadingSH = false;
        });
      } catch (e) {}
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataSinhHieu();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: loadingSH
            ? Loading()
            : _listSinhHieu.isNotEmpty
                ? Column(
                    children: [
                      SignalsCard(sinhHieu: _listSinhHieu[0]),
                      Divider(color: primaryColor, height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
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
                            subfixIcon: Icon(UniconsLine.comment_edit,
                                color: primaryColor, size: 20),
                            label: "Đo sinh hiệu",
                            color: primaryColor.withOpacity(.1),
                            textColor: primaryColor,
                          ),
                          MyButton(
                            onPressed: () {
                              Navigator.push(
                                      context,
                                      PageTransition(
                                          child: ContainScreen(
                                            page: Screen_DSSinhHieu(
                                              patient: widget.patient,
                                            ),
                                            title: "Thông tin đo sinh hiệu",
                                          ),
                                          type: PageTransitionType.rightToLeft))
                                  .then((_) => getDataSinhHieu());
                            },
                            subfixIcon: Icon(UniconsLine.eye,
                                color: primaryColor, size: 20),
                            color: primaryColor.withOpacity(.1),
                            textColor: primaryColor,
                            label: "Xem tất cả",
                          ),
                        ],
                      )
                    ],
                  )
                : Column(
                    children: [
                      Image.asset(
                          "assets/images/medicals/List Is Empty_96px.png"),
                      Text(
                        "Chưa đo sinh hiệu",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      MyButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Table_DoSinhHieu(
                              patient: widget.patient,
                            ),
                          );
                        },
                        icon: Text(
                          "Đo sinh hiệu  ",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        width: 170,
                        color: primaryColor.withOpacity(.2),
                        subfixIcon:
                            Icon(UniconsLine.comment_edit, color: primaryColor),
                      )
                    ],
                  ),
      ),
    );
  }
}
