import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/views/screens/patient/tabs/widgets/container_ChiPhiKcb.dart';
import 'package:app_leohis/views/screens/patient/tabs/widgets/container_SinhHieu.dart';
import 'package:app_leohis/views/screens/patient/tabs/widgets/container_ThongTinBenhNhan.dart';
// import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Screen_ThongTinBenhNhan extends StatefulWidget {
  Screen_ThongTinBenhNhan({super.key, required this.patient});
  BenhNhanData patient;
  @override
  State<Screen_ThongTinBenhNhan> createState() =>
      _Screen_ThongTinBenhNhanState();
}

class _Screen_ThongTinBenhNhanState extends State<Screen_ThongTinBenhNhan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // Thông tin bệnh nhân
          Container_ThongTinBenhNhan(patient: widget.patient),
          // Chi phí khám
          Container_ChiPhiKcb(mahs: widget.patient.mahs),
          // Sinh hiệu
          Container_SinhHieu(patient: widget.patient),

          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
