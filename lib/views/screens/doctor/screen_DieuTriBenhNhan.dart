import 'dart:convert';

import 'package:app_leohis/models/BenhNhanDieuTri.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/components/draggableButton.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/screens/doctor/widgets/container_ThongTinDieuTri.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/emptyPage.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/loadingPage.dart';
import 'package:app_leohis/views/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import 'package:diacritic/diacritic.dart';

class Screen_DieuTriBenhNhan extends StatefulWidget {
  const Screen_DieuTriBenhNhan({super.key});

  @override
  State<Screen_DieuTriBenhNhan> createState() => _Screen_DieuTriBenhNhanState();
}

enum SingingCharacter { jefferson, adams }

class _Screen_DieuTriBenhNhanState extends State<Screen_DieuTriBenhNhan> {
  //Data
  String? khoa;
  String tendn = '';

  List<BenhNhanDTData> _list = [];
  //Fillter
  List<BenhNhanDTData> _displayList = [];

  bool isDescDate = true;
  bool loading = false;
  bool load = false;

  String formatString(String text) => removeDiacritics(text).toLowerCase();

  @override
  void initState() {
    super.initState();
    setListBenhNhan(context);
  }

  void setListBenhNhan(BuildContext context) async {
    var _khoaProvider = Provider.of<KhoaProvider>(context, listen: false);
    _list = await _khoaProvider.listBenhNhanDieuTri;

    setState(() {
      _list;
      _displayList = _list;
    });
  }

  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return load
        ? Loading()
        : Scaffold(
            body: ScaffoldDraggable(
              button: SpeedDial(
                backgroundColor: primaryColor,
                icon: Icons.menu_open,
                overlayColor: Colors.transparent,
                activeIcon: Icons.close,
                children: [
                  SpeedDialChild(
                    child: Icon(UniconsLine.calendar_alt, color: primaryColor),
                    backgroundColor: Colors.blue.shade50,
                    label: 'Sắp xếp ${isDescDate ? 'giảm' : 'tăng'} theo ngày',
                    labelBackgroundColor: Colors.transparent,
                    labelStyle: TextStyle(
                        color: themeModeColor, fontWeight: FontWeight.w500),
                    labelShadow: [],
                    onTap: () {
                      setState(() {
                        isDescDate = !isDescDate;
                        isDescDate
                            ? _displayList.sort((a, b) =>
                                a.ngayvaovien.compareTo(b.ngayvaovien))
                            : _displayList.sort((a, b) =>
                                b.ngayvaovien.compareTo(a.ngayvaovien));
                      });
                    },
                  ),
                  // SpeedDialChild(
                  //   child: Icon(UniconsLine.filter, color: primaryColor),
                  //   backgroundColor: Colors.blue.shade50,
                  //   label: 'Chọn lọc',
                  //   labelBackgroundColor: Colors.transparent,
                  //   labelStyle: TextStyle(
                  //       color: themeModeColor, fontWeight: FontWeight.w500),
                  //   labelShadow: [],
                  // ),
                  SpeedDialChild(
                    child: Icon(UniconsLine.refresh, color: primaryColor),
                    backgroundColor: Colors.blue.shade50,
                    label: 'Tải lại danh sách',
                    labelBackgroundColor: Colors.transparent,
                    labelStyle: TextStyle(
                        color: themeModeColor, fontWeight: FontWeight.w500),
                    labelShadow: [],
                    onTap: () {
                      setState(() {
                        selectedTab = 0;
                      });
                    },
                  ),
                ],
              ),
              child: Container(
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(15))),
                      margin: EdgeInsets.symmetric(horizontal: 14),
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              // padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                              alignment: Alignment.center,
                              height: 40,
                              decoration: BoxDecoration(
                                // boxShadow: [],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 20),
                                  hintText:
                                      "Tìm ID, tên bệnh nhân, tên bác sĩ điều trị...",
                                  suffixIcon: Icon(Icons.search),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _displayList = _list
                                        .where((item) =>
                                            formatString(item.hotenbn).contains(
                                                formatString(value)) ||
                                            formatString(item.bacsiDieutri)
                                                .contains(
                                                    formatString(value)) ||
                                            item.idbn
                                                .toString()
                                                .contains(value))
                                        .toList();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    //List bệnh nhân
                    DividerTitle(
                        title: "Danh sách chăm sóc  (${_list.length})"),
                    loading
                        ? Expanded(
                            child: Container(child: Center(child: Loading())))
                        : Expanded(
                            child: Container(
                              child: loading
                                  ? Loading()
                                  : _displayList.isEmpty
                                      ? EmptyList()
                                      : Container(
                                          padding: EdgeInsets.only(
                                              left: 7, right: 7),
                                          child: SingleChildScrollView(
                                            physics: BouncingScrollPhysics(),
                                            child: Wrap(
                                              children: _displayList
                                                  .map((e) => CardItem(
                                                      data: _displayList[
                                                          _displayList
                                                              .indexOf(e)]))
                                                  .toList(),
                                            ),
                                          ),
                                        ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required BenhNhanDTData data,
  }) : _data = data;

  final BenhNhanDTData _data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(7),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(10),
          width: isSmallScreen(context) ? null : screen(context).width / 2 - 28,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Số hồ sơ: ${_data.sohoso}",
                      style: TextStyle(
                        color: themeModeColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Ngày vào viện: ${formatDateVi2(_data.ngayvaovien)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: _data.avatar != '' && _data.avatar != null
                          ? CircleAvatar(
                              backgroundColor: primaryColor,
                              foregroundImage: MemoryImage(
                                base64Decode(_data.avatar.toString().substring(
                                    "data:image/jpeg;base64,".length)),
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: primaryColor,
                              foregroundImage: AssetImage(_data.gioitinh == '1'
                                  ? "assets/images/medicals/patient_male.png"
                                  : "assets/images/medicals/patient_female.png")),
                      title: Text(_data.hotenbn),
                      subtitle: Text("IDBN: ${_data.idbn}"),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: MyButton(
                        color: Colors.transparent,
                        label: "${formatTime(_data.ngayvaovien)}",
                        textColor: primaryColor,
                      )),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(UniconsLine.stethoscope, size: 20),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text("${_data.bacsiDieutri}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ),
                            ],
                          ),
                          Container_ThongTinDieuTri(patient: _data),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
