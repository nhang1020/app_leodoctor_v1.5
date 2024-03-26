import 'package:app_leohis/controllers/PhieuDieuTriController.dart';
import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/models/phieuDieuTri.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/components/dropDown.dart';
import 'package:app_leohis/views/screens/containBodyScreen.dart';
import 'package:app_leohis/views/components/card_Data.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/container_ThongTinBN.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/emptyPage.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/line_TenChucNang.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/loadingPage.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/webViewPage.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:page_transition/page_transition.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class Screen_PhieuDieuTri extends StatefulWidget {
  BenhNhanData patient;
  Screen_PhieuDieuTri({super.key, required this.patient});

  @override
  State<Screen_PhieuDieuTri> createState() => _Screen_PhieuDieuTriState();
}

class _Screen_PhieuDieuTriState extends State<Screen_PhieuDieuTri> {
  List<PhieuDieuTriData> _listphieu = [];
  PhieuDieuTriController _dieuTriController = PhieuDieuTriController();
  bool loading = false;
  String selectKhoa = '';
  List<bool> show = [];

  loadData() async {
    setState(() {
      loading = true;
    });
    try {
      _listphieu = await _dieuTriController.getPhieuDieuTri(
          widget.patient.mahs, selectKhoa);

      setState(() {
        _listphieu;
      });
    } catch (e) {
    } finally {
      try {
        setState(() {
          loading = false;
        });
        for (int index = 0; index < _listphieu.length; index++) {
          show.add(true);
        }
      } catch (e) {}
    }
  }

  String HTML(String html) {
    html = html.replaceAll('label',
        """b , style=" border: 1px solid black; padding: 5px; border-radius: 50px/50px" """);

    return html;
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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          XemDieuTri xem = await _dieuTriController.getXemDieuTri(
            widget.patient.mahs,
            widget.patient.makhoa,
            widget.patient.manamvien,
            '',
          );
          print(xem.data.link);
          xem.success == true
              ? Navigator.push(
                  context,
                  PageTransition(
                      child: ContainScreen(
                        page: WebView_Page(
                          url: xem.data.link,
                        ),
                        title: "Phiếu điều trị",
                      ),
                      type: PageTransitionType.rightToLeft))
              : showMessage(context, message: "Lỗi", type: "error");
        },
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Container_TopView(patient: widget.patient),
          Container(
            padding: EdgeInsets.all(15),
            child: MyDropdown(
              items: dropdownItems,
              onChanged: (value) {
                setState(() {
                  selectKhoa = value!;
                  loadData();
                });
              },
            ),
          ),
          Line_TenChucNang(name: 'phiếu điều trị  (${_listphieu.length})'),
          Expanded(
            // height: screen(context).height,
            child: loading
                ? Loading()
                : _listphieu.length == 0
                    ? EmptyList(listName: "phiếu điều trị")
                    : SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Wrap(
                          children: <Widget>[
                            for (int index = 0;
                                index < _listphieu.length;
                                index++)
                              viewPhieuDieuTri(_listphieu[index], index),
                          ],
                        ),
                      ),
          ),
        ],
      ),
    );
  }

  Widget viewPhieuDieuTri(PhieuDieuTriData data, int index) {
    return Card(
      margin: EdgeInsets.all(7),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: isSmallScreen(context)
            ? screen(context).width
            : screen(context).width / 2 - 17,
        child: Container(
          padding: EdgeInsets.all(10),
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
                    height: 70,
                    width: 2,
                    color: primaryColor,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Chip(
                          backgroundColor: Colors.transparent,
                          avatar: Icon(UniconsLine.user_nurse,
                              color: primaryColor, size: 17),
                          label: Text(
                            "${checkString(data.tennguoidung)}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Chip(
                          backgroundColor: Colors.transparent,
                          avatar: Icon(UniconsLine.hospital,
                              color: primaryColor, size: 17),
                          label: Text(
                            "${checkString(data.tenkhoa)}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                height: 1,
              ),
              Visibility(
                visible: show[index],
                child: Container(
                  child: Column(children: [
                    Card_Data(
                        title: "Chẩn đoán: ",
                        text: checkString(data.chandoan).trim()),
                    Card_Data(
                        title: "Diễn biến: ",
                        text: checkString(data.dienbien).trim()),
                    Card_Data(
                      title: "Y lệnh diễn giải",
                      wtext: SingleChildScrollView(
                        child: //SelectableText(data.ylenhDiengiai)
                            HtmlWidget(
                          HTML(data.ylenhDiengiai),
                          buildAsync: true,
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ]),
                ),
              ),
              show[index]
                  ? Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton(
                            width: 200,
                            onPressed: () async {
                              XemDieuTri xem =
                                  await _dieuTriController.getXemDieuTri(
                                data.mahs,
                                data.makhoa,
                                data.manamvien,
                                data.maphieudieutri,
                              );
                              print(xem.data.link);
                              xem.success == true
                                  ? Navigator.push(
                                      context,
                                      PageTransition(
                                          child: ContainScreen(
                                            page: WebView_Page(
                                              url: xem.data.link,
                                            ),
                                            title: "Phiếu điều trị",
                                          ),
                                          type: PageTransitionType.rightToLeft))
                                  : showMessage(context,
                                      message: "Lỗi", type: "error");
                            },
                            label: "Xem và chỉnh sửa",
                            color: primaryColor.withOpacity(.1),
                            icon: Icon(
                              Icons.edit_road_outlined,
                              color: primaryColor,
                            ),
                            textColor: primaryColor,
                          ),
                        ],
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 17,
                        vertical: 10,
                      ),
                      child: Text(
                        "Xem chi tiết",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

class RowData extends StatelessWidget {
  const RowData({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 80,
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                // textAlign: TextAlign.right,
                // maxLines: select == index ? 10 : 1,
                maxLines: 25,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Tất cả"), value: ""),
    DropdownMenuItem(child: Text("Khoa Hồi sức cấp cứu"), value: "khoahscc"),
    DropdownMenuItem(child: Text("Khoa Cấp cứu"), value: "khoacapcuu"),
    DropdownMenuItem(child: Text("Khoa Nội"), value: "khoanoi"),
    DropdownMenuItem(child: Text("Khoa Ngoại"), value: "khoangoai"),
  ];
  return menuItems;
}
