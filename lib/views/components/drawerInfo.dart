import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/taiKhoan.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/components/settingDialog.dart';
import 'package:app_leohis/views/screens/containBodyScreen.dart';
import 'package:app_leohis/views/screens/menu/screen_LichHen.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/screens/auth/screen_Login.dart';
import 'package:app_leohis/views/screens/menu/screen_GioiThieuHeThong.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class DrawerInfo extends StatefulWidget {
  const DrawerInfo({super.key});

  @override
  State<DrawerInfo> createState() => _DrawerInfoState();
}

class _DrawerInfoState extends State<DrawerInfo> {
  List<String> name = [];
  DataAccount data = DataAccount(
      token: '',
      tennguoidung: '',
      tendangnhap: '',
      ngaysinh: DateTime.now(),
      gioitinh: '',
      dienthoai: '',
      cchn: '',
      bacsi: false,
      maquyenhan: '',
      quyen: '',
      wan: 0,
      ngaydangky: DateTime.now());

  String trimDateTime(DateTime date) {
    String day = date.day.toString();
    String mon = date.month.toString();
    String year = date.year.toString();
    if (date.day < 10) day = '0${date.day}';
    if (date.month < 10) mon = '0${date.month}';
    return '$day/$mon/$year';
  }

  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final json = prefs.getString('dataAccount');

    if (json == null) {
      print("No data");
    } else {
      setState(() {
        data = DataAccount.fromJson(jsonDecode(json));
        name = data.tennguoidung.split(' ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildDrawerInfo();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  int _selectIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  Widget buildDrawerInfo() {
    return SafeArea(
      child: Drawer(
        width: isSmallScreen(context)
            ? screen(context).width / 1.2
            : screen(context).width / 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(20),
          ),
        ),
        child: Container(
          height: screen(context).height,
          child: Column(
            // padding: EdgeInsets.zero,
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        // contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: primaryColor,
                          radius: 20,
                          child: name.isEmpty
                              ? Icon(Icons.person)
                              : Text(
                                  checkString(name.last),
                                  style: TextStyle(
                                      color: Theme.of(context).cardColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                        title: Text(
                          '${checkString(data.tennguoidung)}',
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          "(+84) 972667944", //'${checkString(data.dienthoai)}',
                          style: TextStyle(fontSize: 14),
                        ),
                        trailing: Icon(UniconsLine.stethoscope),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyButton(
                          onPressed: () {
                            _pageController.animateToPage(0,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.linear);
                          },
                          label: "Tài khoản",
                          height: 40,
                          // width: screen(context).width / 3,
                          radius: 15,
                          color: _selectIndex == 0
                              ? primaryColor
                              : primaryColor.withOpacity(.03),
                          textColor: _selectIndex == 0
                              ? Theme.of(context).cardColor
                              : Colors.grey,
                          icon: Icon(
                            UniconsLine.user,
                            color: _selectIndex == 0
                                ? Theme.of(context).cardColor
                                : Colors.grey,
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 10),
                        MyButton(
                          // width: screen(context).width / 3,
                          radius: 15,
                          icon: Icon(
                            UniconsLine.android_alt,
                            color: _selectIndex == 1
                                ? Theme.of(context).cardColor
                                : Colors.grey,
                            size: 20,
                          ),
                          height: 40,
                          onPressed: () {
                            _pageController.animateToPage(1,
                                duration: Duration(milliseconds: 200),
                                curve: Curves.linear);
                          },
                          label: "Hệ thống",
                          color: _selectIndex == 1
                              ? primaryColor
                              : primaryColor.withOpacity(.03),
                          textColor: _selectIndex == 1
                              ? Theme.of(context).cardColor
                              : Colors.grey,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (value) {
                      setState(() {
                        _selectIndex = value;
                      });
                    },
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ListView(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                "THÔNG TIN",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                            CardInfo(
                              iconName: UniconsLine.at,
                              text: "nhangnhanh1234@gmail.com",
                            ),
                            CardInfo(
                              iconName: UniconsLine.ticket,
                              text: data.tennguoidung,
                            ),
                            CardInfo(
                              iconName: data.gioitinh == "Nam"
                                  ? UniconsLine.mars
                                  : UniconsLine.venus,
                              text: data.gioitinh,
                            ),
                            CardInfo(
                              iconName: Icons.cake_outlined,
                              text: formatDate(data.ngaysinh),
                            ),
                            CardInfo(
                              iconName: UniconsLine.phone,
                              text: data.dienthoai,
                            ),
                            CardInfo(
                              iconName: UniconsLine.user_exclamation,
                              text: data.tendangnhap,
                            ),
                            Divider(
                                height: 50,
                                color: primaryColor.withOpacity(.1),
                                thickness: 1),

                            //               //THÊM
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: Text(
                                "THÊM",
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                            ),
                            CardInfo(
                              iconName: UniconsLine.file_bookmark_alt,
                              text: data.cchn,
                              advance: MyButton(
                                color: Colors.transparent,
                                icon: Text(
                                  "Chứng chỉ  ",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic),
                                ),
                                subfixIcon: Icon(FontAwesomeIcons.crown,
                                    size: 15, color: Colors.amber),
                                padding: EdgeInsets.zero,
                              ),
                            ),
                            OpenContainer(
                              closedElevation: 0,
                              closedColor: Theme.of(context).canvasColor,
                              openBuilder: (context, action) => ContainScreen(
                                title: "",
                                page: Screen_LichHen(),
                              ),
                              closedBuilder: (context, action) => CardInfo(
                                iconName: UniconsLine.calendar_alt,
                                function: action,
                                text: "Xem lịch",
                                advance: MyButton(
                                  color: Colors.transparent,
                                  icon: Text(
                                    "Lịch hẹn  ",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  subfixIcon: Icon(
                                      FontAwesomeIcons.handshakeSimple,
                                      size: 15,
                                      color: Colors.green),
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            CardInfo(
                              function: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => SettingDialog(),
                                );
                              },
                              iconName: UniconsLine.setting,
                              text: "Cài đặt",
                              advance: Icon(Icons.arrow_forward_ios, size: 17),
                            ),
                            SizedBox(height: 50),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MyButton(
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) =>
                                          NotifiacationDialog(),
                                    ),
                                    color: primaryColor.withOpacity(.1),
                                    radius: 15,
                                    height: 50,
                                    width: 200,
                                    // border: Border.all(color: primaryColor),
                                    icon: RotatedBox(
                                      quarterTurns: 2,
                                      child: Icon(Icons.logout,
                                          color: primaryColor),
                                    ),
                                    label: "Đăng xuất tài khoản",
                                    textColor: primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Screen_GioiThieuHeThong(),
                      ),
                    ],
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

class CardInfo extends StatelessWidget {
  const CardInfo({
    super.key,
    required this.iconName,
    required this.text,
    this.advance,
    this.function,
  });
  final IconData iconName;
  final String text;
  final Widget? advance;
  final Function()? function;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        margin: EdgeInsets.all(7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(iconName, color: primaryColor),
                SizedBox(width: 10),
                Container(
                  width: isSmallScreen(context)
                      ? advance != null
                          ? null
                          : screen(context).width / 1.8
                      : null,
                  child: Text(
                    checkString(text),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Container(
                width: advance != null ? null : 1,
                child: advance ?? SizedBox()),
          ],
        ),
      ),
    );
  }
}

class NotifiacationDialog extends StatelessWidget {
  const NotifiacationDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    LocalData localData = LocalData();
    return AlertDialog(
      title: const Text(
        'Thông báo',
        // style: TextStyle(color: themeModeColor),
      ),
      content: const Text('Bạn có chắc chắn muốn đăng xuất tài khoản không?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text(
            'Hủy',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextButton(
          onPressed: () {
            localData.Shared_clearLocalDataAccount();
            
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                PageTransition(
                    child: LoginScreen(),
                    type: PageTransitionType.rightToLeft));
          },
          child: Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Có',
                style: TextStyle(color: Theme.of(context).cardColor),
              )),
        ),
      ],
    );
  }
}
