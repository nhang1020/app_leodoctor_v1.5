import 'package:app_leohis/controllers/PhieuDieuTriController.dart';
import 'package:app_leohis/controllers/TKHSBAController.dart';
import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/models/phieuDieuTri.dart';
import 'package:app_leohis/models/thongKeHSBA.dart';
import 'package:app_leohis/views/screens/patient/details/screen_PhieuDieuTri.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/webViewPage.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/screens/containBodyScreen.dart';
import 'package:app_leohis/views/screens/patient/details/screen_DSDonThuoc.dart';
import 'package:app_leohis/views/screens/patient/details/screen_HoiChan.dart';
import 'package:app_leohis/views/screens/patient/details/screen_KetQuaCls.dart';
import 'package:app_leohis/views/screens/patient/details/screen_PhieuChamSoc.dart';
import 'package:app_leohis/views/screens/patient/details/screen_SoKet15Ngay.dart';
import 'package:app_leohis/views/screens/patient/details/screen_TomTatHSBA.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:badges/badges.dart' as badges;

// ignore: must_be_immutable
class Screen_CacChucNang extends StatefulWidget {
  BenhNhanData patient;
  Screen_CacChucNang({super.key, required this.patient});

  @override
  State<Screen_CacChucNang> createState() => _Screen_CacChucNangState();
}

class _Screen_CacChucNangState extends State<Screen_CacChucNang> {
  TKHSBAController _tkhsbanController = TKHSBAController();
  ThongKeHSBAData _ThongKeHSBA = initTKHSBA;
  PhieuDieuTriController _dieuTriController = PhieuDieuTriController();

  getDataThongKe() async {
    try {
      _ThongKeHSBA =
          await _tkhsbanController.getThongKeHSBA(widget.patient.mahs);
      setState(() {
        _ThongKeHSBA;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    getDataThongKe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isSmallScreen = screen(context).width < 800;
    return ListView(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Y lệnh điều trị",
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    YLenh(),
                    TreatmentButton(
                        "Thuốc - vtyt",
                        _ThongKeHSBA.donthuoc,
                        Screen_DSDonThuoc(patient: widget.patient),
                        "assets/images/icons/pills_96px.png"),
                    TreatmentButton(
                        "Điều trị",
                        _ThongKeHSBA.nPdt,
                        Screen_PhieuDieuTri(patient: widget.patient),
                        "assets/images/icons/health_checkup_96px.png"),
                    TreatmentButton(
                        "Chăm sóc",
                        _ThongKeHSBA.nPcs,
                        Screen_PhieuChamSoc(
                          patient: widget.patient,
                        ),
                        "assets/images/icons/trust_96px.png"),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Kết quả CLS",
                      style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: ContainScreen(
                                    page: Screen_KetQuaCls(
                                      MaNhomDv: '',
                                      patient: widget.patient,
                                    ),
                                    title: 'Kết quả cận lâm sàng'),
                                type: PageTransitionType.rightToLeft));
                      },

                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 2, color: primaryColor)),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            "Xem tất cả",
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      // style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                    )
                  ],
                ),
                SizedBox(height: 20),
                Wrap(
                  runSpacing: 20,
                  children: [
                    Container(
                      width: isSmallScreen
                          ? screen(context).width
                          : screen(context).width / 2 - 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                minWidth: screen(context).width / 4 - 20),
                            child: TreatmentButton(
                                "Chẩn đoán hình ảnh",
                                _ThongKeHSBA.chandoanhinhanh,
                                Screen_KetQuaCls(
                                  MaNhomDv: 'chandoanhinhanh',
                                  patient: widget.patient,
                                ),
                                "assets/images/icons/video_stabilization_96px.png"),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                minWidth: screen(context).width / 4 - 20),
                            child: TreatmentButton(
                                "Thăm dò chức năng",
                                _ThongKeHSBA.thamdochucnang,
                                Screen_KetQuaCls(
                                  MaNhomDv: 'thamdochucnang',
                                  patient: widget.patient,
                                ),
                                "assets/images/icons/caduceus_96px.png"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: isSmallScreen
                          ? screen(context).width
                          : screen(context).width / 2 - 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                minWidth: screen(context).width / 4 - 20),
                            child: TreatmentButton(
                                "Xét nghiệm",
                                _ThongKeHSBA.xetnghiem,
                                Screen_KetQuaCls(
                                  MaNhomDv: 'xetnghiem',
                                  patient: widget.patient,
                                ),
                                "assets/images/icons/acid_surface_96px.png"),
                          ),
                          Container(
                            constraints: BoxConstraints(
                                minWidth: screen(context).width / 4 - 20),
                            child: TreatmentButton(
                                "Phẩu thuật-Thủ thuật",
                                _ThongKeHSBA.phauthuthuat,
                                Screen_KetQuaCls(
                                  MaNhomDv: 'phauthuthuat',
                                  patient: widget.patient,
                                ),
                                "assets/images/icons/scissors_96px.png"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hồ sơ bệnh án",
                  style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TreatmentButton(
                        "Tóm tắt BA",
                        _ThongKeHSBA.nTtba,
                        Screen_TomTatHSBA(
                          patient: widget.patient,
                        ),
                        "assets/images/icons/resume_website_96px.png"),
                    TreatmentButton(
                        "15 ngày điều trị",
                        _ThongKeHSBA.n15Ngay,
                        Screen_SoKet15Ngay(
                          patient: widget.patient,
                        ),
                        "assets/images/icons/2015_96px.png"),
                    TreatmentButton(
                        "Hội chẩn",
                        _ThongKeHSBA.nBbhc,
                        Screen_HoiChan(
                          patient: widget.patient,
                        ),
                        "assets/images/icons/teamwork_96px.png"),
                    TreatmentButton(
                        "Chuyển viện",
                        _ThongKeHSBA.nCv,
                        Center(
                          child: Text(
                            'Đang cập nhật...',
                            style: TextStyle(fontSize: 26),
                          ),
                        ),
                        "assets/images/icons/ambulance_96px.png"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget YLenh() {
    return InkWell(
      onTap: () async {
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
                      title: "Y lệnh",
                    ),
                    type: PageTransitionType.rightToLeft))
            : showMessage(context, message: "Lỗi", type: "error");
      },
      child: Column(
        children: [
          badges.Badge(
            badgeContent: Text(
                _ThongKeHSBA.nByl.toString() == '0'
                    ? '+'
                    : _ThongKeHSBA.nByl.toString(),
                style: TextStyle(color: themeModeColor)),
            badgeStyle: badges.BadgeStyle(
              badgeColor: Colors.red.shade300,
            ),
            child: Container(
              width: 50,
              height: 50,
              // padding: EdgeInsets.all(10),
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //   image: AssetImage('assets/images/medicals/ylenh.png'),
              // )),
              child: Image.asset("assets/images/icons/Medical_File_96px.png",
                  color: primaryColor),
            ),
          ),
          SizedBox(height: 5),
          Container(
              alignment: Alignment.center,
              width: screen(context).width / 4 - 20,
              child: Text(
                'Y Lệnh',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }

  Widget TreatmentButton(
    String title,
    dynamic badgeNumber,
    Widget page,
    String icon,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
                context,
                PageTransition(
                    child: ContainScreen(page: page, title: title),
                    type: PageTransitionType.rightToLeft))
            .then((value) => getDataThongKe());
      },
      child: Column(
        children: [
          badgeNumber != null
              ? badges.Badge(
                  badgeAnimation: badges.BadgeAnimation.rotation(),
                  badgeContent: Text(badgeNumber.toString(),
                      style: TextStyle(color: themeModeColor)),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.red.shade300,
                  ),
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Image.asset(icon, color: primaryColor),
                  ),
                )
              : Container(
                  width: 50,
                  height: 50,
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeModeColor,
                    // shape: BoxShape.circle,
                  ),
                  // child: Image.asset(imageUrl,),
                ),
          SizedBox(height: 5),
          Container(
              alignment: Alignment.center,
              width: screen(context).width / 4 - 20,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}
