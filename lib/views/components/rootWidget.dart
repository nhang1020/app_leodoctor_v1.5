import 'package:app_leohis/controllers/FCMController.dart';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/controllers/ThongBaoController.dart';
import 'package:app_leohis/models/ThongBao.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/components/notification_manager/firebase_notification.dart';
import 'package:app_leohis/views/screens/home/screen_Dashboard.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/screens/doctor/screen_DieuTriBenhNhan.dart';
// import 'package:app_leohis/views/screens/home/screen_TrangChu.dart';
import 'package:app_leohis/views/screens/nursing/screen_ChamSocBenhNhan.dart';
import 'package:app_leohis/views/screens/patient/screen_DSNamVien.dart';
import 'package:app_leohis/views/components/drawerInfo.dart';
import 'package:app_leohis/views/utils/theme.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
// import 'package:badges/badges.dart' as badges;

// ignore: must_be_immutable
class NavBars extends StatefulWidget {
  @override
  _NavBarsState createState() => _NavBarsState();
  _NavBarsState root = _NavBarsState();
}

class _NavBarsState extends State<NavBars> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  ThongBaoController _thongBaoController = ThongBaoController();
  bool _haveNotification = false;
  static List<Widget> _widgetOptions = <Widget>[
    Screen_Dashboard(),
    Screen_DSNamVien(),
    Screen_DieuTriBenhNhan(),
    Screen_ChamSocBenhNhan(),
  ];

  CheckThongBao() async {
    var _listTb = await _thongBaoController.getThongBao();
    if (_listTb.isNotEmpty)
      setState(() {
        _haveNotification = true;
      });
  }

  @override
  void initState() {
    super.initState();
    CheckThongBao();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return DefaultTabController(
      length: _widgetOptions.length,
      initialIndex: 0,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 70,
          // iconTheme: IconThemeData(color: IconThemeData(color: )),

          leading: IconButton(
            icon: Icon(UniconsLine.list_ui_alt),
            onPressed: () {
              scaffoldKey.currentState!.isDrawerOpen
                  ? scaffoldKey.currentState!.closeDrawer()
                  : scaffoldKey.currentState!.openDrawer();
            },
          ),
          title: Text(
            "Leohis",
            // style: TextStyle(color: textColor2),
          ),
          // backgroundColor: themeModeColor,
          scrolledUnderElevation: 0.3,
          elevation: 0,
          actions: [
            // NotificationDrawer(),
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
                icon: badges.Badge(
                  position: badges.BadgePosition.custom(top: -3, end: -2),
                  badgeStyle: badges.BadgeStyle(
                    shape: badges.BadgeShape.circle,
                    badgeColor:
                        _haveNotification ? Colors.red : Colors.transparent,
                  ),
                  child: Icon(Icons.notifications_none),
                ),
              ),
            )
          ],
        ),
        endDrawer: NotificationDrawer(),
        drawer: DrawerInfo(),
        body: TabBarView(children: _widgetOptions),
        bottomNavigationBar: ConvexAppBar(
          backgroundColor:
              themeProvider.isDarkMode || themeProvider.isSysDark(context)
                  ? Color(0xff2B3038)
                  : themeModeColor,
          elevation: 20,
          shadowColor: const Color.fromARGB(22, 0, 0, 0),
          color: Colors.grey,
          height: 60,
          activeColor: primaryColor.withOpacity(.15),
          curveSize: 100,
          items: <TabItem>[
            TabItem(
                icon: Icon(UniconsLine.estate, color: Colors.grey),
                activeIcon: Icon(UniconsLine.estate, color: primaryColor),
                title: "Trang chủ"),
            TabItem(
                icon: Icon(UniconsLine.users_alt, color: Colors.grey),
                activeIcon: Icon(UniconsLine.users_alt, color: primaryColor),
                title: "Bệnh nhân"),
            TabItem(
                icon: Icon(UniconsLine.stethoscope, color: Colors.grey),
                activeIcon: Icon(UniconsLine.stethoscope, color: primaryColor),
                title: "Bác sĩ"),
            TabItem(
                icon: Icon(UniconsLine.user_nurse, color: Colors.grey),
                activeIcon: Icon(UniconsLine.user_nurse, color: primaryColor),
                title: "Điều dưỡng"),
          ],
        ),
      ),
    );
  }
}

class NotificationDrawer extends StatefulWidget {
  const NotificationDrawer({super.key});

  @override
  State<NotificationDrawer> createState() => _NotificationDrawerState();
}

class _NotificationDrawerState extends State<NotificationDrawer> {
  List<ThongBaoData> _listTb = [];
  ThongBaoController _thongBaoController = ThongBaoController();

  getThongBao() async {
    _listTb = await _thongBaoController.getThongBao();
    setState(() {
      _listTb;
    });
  }

  @override
  void initState() {
    super.initState();
    getThongBao();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      width: screen(context).width / 1.2,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: SafeArea(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              height: screen(context).height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, right: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.only(left: 15, bottom: 0),
                          // clipBehavior: Clip.hardEdge,
                          height: 450,
                          width: screen(context).width,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 70,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Thông báo",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10),
                                      child: MyButton(
                                        width: 160,
                                        height: 35,
                                        label: "Xóa thông báo",
                                        textColor: primaryColor,
                                        radius: 10,
                                        padding: EdgeInsets.all(5),
                                        onPressed: () async {
                                          // _listTb.clear();
                                          // await _localData
                                          //     .Shared_clearThongBao();
                                          FCMController.sendNotification(
                                              receiverToken: deviceToken,
                                              body: "Phong",
                                              title: "...");
                                        },
                                        color: primaryColor.withOpacity(.2),
                                        subfixIcon: Icon(
                                          Icons.check_circle_outline,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Scrollbar(
                                  radius: Radius.circular(5),
                                  thickness: 7,
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Column(
                                        children: _listTb.isEmpty
                                            ? [
                                                SizedBox(height: 100),
                                                Image.asset(
                                                  "assets/images/icons/inbox_64px.png",
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  "Chưa có thông báo mới nào",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              ]
                                            : [
                                                for (var item in _listTb)
                                                  buildThongBao(item),
                                              ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildThongBao(ThongBaoData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: ListTile(
        onTap: () async {},
        minLeadingWidth: 0,
        minVerticalPadding: 0,
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: primaryColor,
          child: Icon(
            Icons.notifications,
            color: Theme.of(context).cardColor,
            size: 24,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: RichText(
                  text: TextSpan(children: [
                WidgetSpan(
                    child: Text(
                  "${checkString(data.tieude)}                 ",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                )),
                WidgetSpan(
                    child: Text(
                  "${formatTime(data.ngaythongbao)}  ${formatDate(data.ngaythongbao)}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: primaryColor, fontSize: 14),
                )),
                if (data.ngayhen != null)
                  WidgetSpan(
                      child: Text(
                    "Ngày hẹn: ${formatTime(data.ngayhen)}  ${formatDate(data.ngayhen)}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
              ])),
            ),
          ],
        ),
        subtitle: Text(
          "${checkString(data.noidung)}",
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
