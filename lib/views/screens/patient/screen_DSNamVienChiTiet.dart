import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/screens/patient/tabs/screen_CacChucNang.dart';
import 'package:app_leohis/views/screens/patient/tabs/screen_LichSuKham.dart';
import 'package:app_leohis/views/screens/patient/tabs/screen_PhieuSoHoa.dart';
import 'package:app_leohis/views/screens/patient/tabs/screen_ThongTinBenhNhan.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class Screen_DSNamVienChiTiet extends StatefulWidget {
  Screen_DSNamVienChiTiet({
    super.key,
    required this.patient,
  });
  BenhNhanData patient;
  @override
  State<Screen_DSNamVienChiTiet> createState() =>
      _Screen_DSNamVienChiTietState();
}

class _Screen_DSNamVienChiTietState extends State<Screen_DSNamVienChiTiet> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "${widget.patient.hotenbn} - Số HS: ${widget.patient.sohoso}",

            //overflow: TextOverflow.ellipsis,'
          ),
          bottom: tabBar(),
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.blueGrey),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Screen_ThongTinBenhNhan(patient: widget.patient),
            Screen_CacChucNang(patient: widget.patient),
            Screen_LichSuKham(mabn: widget.patient.mabn),
            Screen_PhieuSoHoa(patient: widget.patient)
          ],
        ),
      ),
    );
  }

  TabBar tabBar() {
    return TabBar(
      indicatorColor: primaryColor,
      indicatorWeight: 3,
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: primaryColor,

      unselectedLabelColor: Colors.grey,
      tabs: [
        Tab(
          icon: Icon(UniconsLine.document_layout_left),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hồ sơ",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
        Tab(
          icon: Icon(Icons.widgets_outlined),
          child: Text(
            "Chức năng",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tab(
          icon: Icon(UniconsLine.file_bookmark_alt),
          child: Flexible(
            child: Text(
              "Lịch sử KCB",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Tab(
          icon: Icon(UniconsLine.package),
          child: Flexible(
            child: Text(
              "Phiếu số hóa",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
      // labelColor: primaryColor,
      // unselectedLabelColor: textColor1,
    );
  }

  TabBarView tabBarView() {
    return TabBarView(
      children: [
        Screen_ThongTinBenhNhan(patient: widget.patient),
        Screen_CacChucNang(patient: widget.patient),
        Screen_LichSuKham(mabn: widget.patient.mabn),
        Screen_PhieuSoHoa(patient: widget.patient)
      ],
    );
  }
}
