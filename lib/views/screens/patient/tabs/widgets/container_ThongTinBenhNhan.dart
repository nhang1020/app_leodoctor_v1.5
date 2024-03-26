import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/views/components/rowData.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class Container_ThongTinBenhNhan extends StatefulWidget {
  BenhNhanData patient;
  Container_ThongTinBenhNhan({super.key, required this.patient});

  @override
  State<Container_ThongTinBenhNhan> createState() =>
      _Container_ThongTinBenhNhanState();
}

class _Container_ThongTinBenhNhanState
    extends State<Container_ThongTinBenhNhan> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          show = !show;
        });
      },
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          boxShadow: [],
          borderRadius: BorderRadius.circular(15),
          color: primaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Thông tin chung",
                    style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).cardColor,
            ),
            SizedBox(height: 10),
            Column(
              children: [
                LineData(
                    left: "Họ tên: ",
                    sizeLeft: 13,
                    right: checkString(widget.patient.hotenbn),
                    sizeRight: 15),
                LineData(
                    left: "Sổ bệnh án: ",
                    sizeLeft: 13,
                    right: checkString(widget.patient.maba),
                    sizeRight: 15),
                LineData(
                    left: "Ngày vào viện: ",
                    sizeLeft: 13,
                    right:
                        "${formatDate(widget.patient.ngayvaovien)} ${formatTime(widget.patient.ngayvaovien)}",
                    sizeRight: 15),
                LineData(
                    left: "Khu: ",
                    sizeLeft: 13,
                    right: checkString(widget.patient.khuDieutri),
                    sizeRight: 15),
                LineData(
                    left: "Khoa điều trị: ",
                    sizeLeft: 13,
                    right: checkString(widget.patient.khoaDieutri),
                    sizeRight: 15),
                LineData(
                    left: "Phòng: ",
                    sizeLeft: 13,
                    right: checkString(widget.patient.phongDieutri),
                    sizeRight: 15),
                LineData(
                    left: "Giường: ",
                    sizeLeft: 13,
                    right: checkString(widget.patient.tengiuong),
                    sizeRight: 15),
                LineData(
                    left: "Chẩn đoán: ",
                    sizeLeft: 13,
                    right: checkString(widget.patient.chandoanTaikhoa),
                    sizeRight: 15),
                Visibility(
                  visible: show,
                  child: LineData(
                      left: "Chẩn đoán phụ: ",
                      sizeLeft: 13,
                      right: checkString(widget.patient.chandoanTaikhoa),
                      sizeRight: 15),
                ),
                Visibility(
                  visible: show,
                  child: LineData(
                      left: "Bệnh kèm: ",
                      sizeLeft: 13,
                      right: checkString(widget.patient.benhkem),
                      sizeRight: 15),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15))),
                  child: Icon(
                    show ? UniconsLine.angle_up : UniconsLine.angle_down,
                    color: primaryColor,
                    size: 30,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
