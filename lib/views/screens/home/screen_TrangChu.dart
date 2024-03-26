import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/screens/home/widgets/chart_HienDien.dart';
import 'package:app_leohis/views/screens/home/screen_LichTruc.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../../../controllers/LocalData.dart';
// import 'package:page_transition/page_transition.dart';

class Screen_TrangChu extends StatefulWidget {
  const Screen_TrangChu({super.key});

  @override
  State<Screen_TrangChu> createState() => _Screen_TrangChuState();
}

class _Screen_TrangChuState extends State<Screen_TrangChu> {
  List<PageWidget> _pages = [
    PageWidget(title: "Thống kê theo khoa", page: Chart_HienDien()),
    PageWidget(title: "Lịch trực", page: Screen_LichTruc()),
    PageWidget(title: "Quyền khoa phòng", page: Container())
  ];
  int _selectedIndex = 0;
  LocalData _localData = LocalData();

  String ten = '';
  List<String> tenAvatar = [];
  getTenNguoiDung() async {
    ten = await _localData.Shared_getTenNguoidung();
    tenAvatar = ten.split(' ');
    setState(() {
      ten;
      tenAvatar;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTenNguoiDung();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // SizedBox(height: 30),
          Container(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: primaryColor,
                child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      tenAvatar.isEmpty ? '' : tenAvatar.last,
                      style: TextStyle(color: themeModeColor, fontSize: 10),
                    )),
              ),
              title: Text(
                "Hi, ${ten}",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 50),
            constraints: BoxConstraints(maxWidth: 318),
            child: TextField(
              cursorHeight: 15,
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
                hintText: "Tìm kiếm...",
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Wrap(
              children: [
                UtilityCard("Trang chủ", UniconsLine.chart_growth, 0),
                UtilityCard("Lịch trực", UniconsLine.calendar_alt, 1),
                UtilityCard("Xem khoa", UniconsLine.building, 2),
              ],
            ),
          ),
          DividerTitle(title: _pages[_selectedIndex].title),
          Container(
              height: _selectedIndex == 2 ? screen(context).height : null,
              child: _pages[_selectedIndex].page),
        ],
      ),
    );
  }

  Widget UtilityCard(String cardName, IconData icon, int index) {
    // ignore: unused_local_variable

    return badges.Badge(
      badgeContent: _selectedIndex == index
          ? Icon(Icons.check_circle, color: primaryColor)
          : null,
      badgeStyle: badges.BadgeStyle(
        badgeColor: Colors.transparent,
        padding: EdgeInsets.all(10),
      ),
      child: Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onTap: () {
            setState(() {
              _selectedIndex = index;
            });
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                // Image.asset(icon, width: 70),
                Icon(icon, size: 50, color: primaryColor),
                SizedBox(height: 10),
                Text(
                  cardName,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PageWidget {
  final String title;
  final Widget page;

  PageWidget({required this.title, required this.page});
}

Widget gapY(double? height) => SizedBox(height: height);
