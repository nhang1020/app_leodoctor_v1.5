import 'dart:convert';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/components/dropDown.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/emptyPage.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/loadingPage.dart';
import 'package:app_leohis/views/screens/patient/screen_DSNamVienChiTiet.dart';
import 'package:app_leohis/views/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import 'package:diacritic/diacritic.dart';

// ignore: must_be_immutable
class Screen_DSNamVien extends StatefulWidget {
  Screen_DSNamVien({
    super.key,
  });

  @override
  State<Screen_DSNamVien> createState() => _Screen_DSNamVienState();
}

class _Screen_DSNamVienState extends State<Screen_DSNamVien> {
  // @override
  // bool get wantKeepAlive => true;

  //Data
  LocalData _localData = LocalData();
  String khoa = '';
  bool load = false;
  String _maBacSi = '';
  String _tenBacSi = '';
  List<BenhNhanData> _list = [];
  List<BenhNhanData> _displayList = [];

  List<String> _lstTenBS = [];
  List<String> _lstTenPhong = [];
  String _selectBacSi = '';
  String _selectPhong = '';
  String _seclectTenBS = '';
  String _selectTenPhong = '';

  bool isDescDate = true;

  String formatString(String text) => removeDiacritics(text).toLowerCase();

  getIdDoctor() async {
    _maBacSi = await _localData.Shared_getTenDangnhap();
    await _localData.Shared_getTenDangnhap;
    _tenBacSi = await _localData.Shared_getTenNguoidung();
    setState(() {
      _maBacSi;
      _tenBacSi;
    });
  }

  String changeALL(String texts) {
    if (texts == 'Tất cả') {
      texts = '';
    }
    return texts;
  }

  @override
  void initState() {
    super.initState();
    getIdDoctor();
    setListBenhNhan(context);
  }

  void setListBenhNhan(BuildContext context) async {
    var _khoaProvider = Provider.of<KhoaProvider>(context, listen: false);
    _list = await _khoaProvider.listBenhNhan;
    khoa = await _khoaProvider.khoa;
    _selectBacSi = await _khoaProvider.selectBacSi;
    _selectPhong = await _khoaProvider.selectPhong;
    for (var item in _list) {
      _lstTenBS.add(item.bacsiDieutri);
      _lstTenPhong.add(item.tenphong);
    }
    _lstTenBS = _lstTenBS.toSet().toList();
    _lstTenPhong = _lstTenPhong.toSet().toList();
    setState(() {
      _lstTenBS;
      _lstTenPhong;
      _list;
      _displayList = _list;
    });
  }

  String findValue(String name, bool BS) {
    if (BS == true) {
      for (var item in _list) {
        if (item.bacsiDieutri == name) {
          return item.usernameBs;
        }
      }
    } else {
      for (var item in _list) {
        if (item.tenphong == name) {
          return item.maphong;
        }
      }
    }
    return '';
  }

  int selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Scaffold(
      floatingActionButton: SpeedDial(
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
            labelStyle:
                TextStyle(color: themeModeColor, fontWeight: FontWeight.w500),
            labelShadow: [],
            onTap: () {
              setState(() {
                isDescDate = !isDescDate;
                isDescDate
                    ? _displayList
                        .sort((a, b) => a.ngayvaovien.compareTo(b.ngayvaovien))
                    : _displayList
                        .sort((a, b) => b.ngayvaovien.compareTo(a.ngayvaovien));
              });
            },
          ),
          SpeedDialChild(
            child: Icon(UniconsLine.filter, color: primaryColor),
            backgroundColor: Colors.blue.shade50,
            label: 'Chọn lọc',
            labelBackgroundColor: Colors.transparent,
            labelStyle:
                TextStyle(color: themeModeColor, fontWeight: FontWeight.w500),
            labelShadow: [],
            onTap: () {
              DialogChonLoc();
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.symmetric(horizontal: 14),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(15))),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText:
                              "Tìm ID, tên bệnh nhân, tên bác sĩ điều trị...",
                          suffixIcon: Icon(Icons.search),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _displayList = _list
                                .where((item) =>
                                    formatString(item.hotenbn)
                                        .contains(formatString(value)) ||
                                    formatString(item.bacsiDieutri)
                                        .contains(formatString(value)) ||
                                    item.idbn.toString().contains(value))
                                .toList();
                          });
                        },
                      ),
                    ),
                    Card(
                      elevation: 0,
                      color: Colors.transparent,
                      // shape: CircleBorder(),
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: FilterTab(() {
                              setState(() {
                                selectedTab = 0;
                              });

                              _maBacSi = '';
                              // clear
                              _displayList = _list;
                              // BottomSnackbar_Success(
                              //     context, 'Tất cả bệnh nhân.', '');
                              showMessage(context,
                                  message: "Tất cả bệnh nhân",
                                  position: StyledToastPosition.top);
                            }, "Tất cả", 0),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: FilterTab(() {
                              setState(() {
                                selectedTab = 1;
                              });
                              getIdDoctor();
                              // _maBacSi = 'tadmin';

                              _displayList = _list
                                  .where((element) =>
                                      element.usernameBs == _maBacSi)
                                  .toList();

                              showMessage(context,
                                  message: "Bệnh nhân của ${_tenBacSi}",
                                  position: StyledToastPosition.top);
                            }, "Đang điều trị", 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //List bệnh nhân
            load
                ? Expanded(child: Container(child: Center(child: Loading())))
                : Expanded(
                    child: Container(
                      child: _displayList.isEmpty
                          ? EmptyList()
                          : Container(
                              padding: EdgeInsets.only(left: 7, right: 7),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Wrap(
                                  children: _displayList
                                      .map((e) => CardItem(
                                          data: _displayList[
                                              _displayList.indexOf(e)]))
                                      .toList(),
                                ),
                              ),
                            ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget FilterTab(Function() onTap, String title, int tabIndex) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: selectedTab != tabIndex
                ? primaryColor
                : Theme.of(context).cardColor,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [],
          // color: themeModeColor
          color: selectedTab == tabIndex
              ? primaryColor
              : primaryColor.withOpacity(.2),
        ),
      ),
    );
  }

  List<DropdownMenuItem> get dropdownBacSi {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text(
            "Tất cả",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          value: ""),
      for (var item in _lstTenBS)
        DropdownMenuItem(
            child: Text(
              "${item}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            value: "${item}"),
    ];
    return menuItems.toSet().toList();
  }

  List<DropdownMenuItem> get dropdownPhong {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text(
            "Tất cả",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          value: ""),
      for (var item in _lstTenPhong)
        DropdownMenuItem(
            child: Text(
              "${item}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            value: "${item}"),
    ];
    return menuItems.toSet().toList();
  }

  DialogChonLoc() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Chọn lọc',
                style: TextStyle(fontSize: 24, color: primaryColor),
              ),
              SizedBox(
                width: 10,
              ),
              Icon(UniconsLine.filter, color: primaryColor, size: 24),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chọn bác sĩ: ',
                            style: TextStyle(fontSize: 16),
                          ),
                          // Text(
                          //   '${checkString(_selectBacSi)}',
                          //   style: TextStyle(fontSize: 16, color: primaryColor),
                          // ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: MyDropdown(
                          items: dropdownBacSi,
                          selectted: _seclectTenBS,
                          onChanged: (value) {
                            _selectBacSi = findValue(value, true);
                            _seclectTenBS = value;
                            setState(() {
                              _selectBacSi;
                              _seclectTenBS;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Chọn phòng: ',
                            style: TextStyle(fontSize: 16),
                          ),
                          // Text(
                          //   '${checkString(_selectPhong)}',
                          //   style: TextStyle(fontSize: 16, color: primaryColor),
                          // ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: MyDropdown(
                          items: dropdownPhong,
                          selectted: _selectTenPhong,
                          onChanged: (value) {
                            _selectPhong = findValue(value, false);
                            _selectTenPhong = value;
                            setState(() {
                              _selectPhong;
                              _selectTenPhong;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Đóng.'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Đồng ý.'),
              onPressed: () async {
                Navigator.of(context).pop();
                var _khoaProvider =
                    Provider.of<KhoaProvider>(context, listen: false);
                _khoaProvider.setBacSi = _selectBacSi;
                _khoaProvider.setPhong = _selectPhong;
                _khoaProvider.getBenhNhan().then((_) async {
                  _displayList = await _khoaProvider.listBenhNhan;
                  setState(() {
                    _displayList;
                  });
                });
              },
            ),
          ],
        );
      },
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required BenhNhanData data,
  }) : _data = data;

  final BenhNhanData _data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7),
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                child: Screen_DSNamVienChiTiet(patient: _data),
                type: PageTransitionType.rightToLeft,
              ),
            );
          },
          child: Container(
            padding: EdgeInsets.all(10),
            width:
                isSmallScreen(context) ? null : screen(context).width / 2 - 28,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Số hồ sơ: ${_data.sohoso}",
                        style: TextStyle(
                          color: primaryColor,
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
                                  base64Decode(_data.avatar
                                      .toString()
                                      .substring(
                                          "data:image/jpeg;base64,".length)),
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: primaryColor,
                                foregroundImage: AssetImage(_data.gioitinh ==
                                        '1'
                                    ? "assets/images/medicals/patient_male.png"
                                    : "assets/images/medicals/patient_female.png")),
                        title: Text(_data.hotenbn),
                        subtitle: Text("IDBN: ${_data.idbn}"),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: MyButton(
                          color: primaryColor.withOpacity(.1),
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
                                  child: Text(
                                      "${checkString(_data.bacsiDieutri)}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(UniconsLine.bed, size: 20),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                      "Phòng nằm: ${checkString(_data.tenphong)}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(UniconsLine.document_info, size: 20),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                      "Chẩn đoán: ${checkString(_data.chandoanTaikhoa)}",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: MyButton(
                          label: "Chi tiết",
                          textColor: Theme.of(context).cardColor,
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                child: Screen_DSNamVienChiTiet(patient: _data),
                                type: PageTransitionType.rightToLeft,
                              ),
                            );
                          },
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
