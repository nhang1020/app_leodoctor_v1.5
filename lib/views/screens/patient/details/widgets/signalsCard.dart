import 'package:app_leohis/models/sinhHieu.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class SignalsCard extends StatelessWidget {
  SignalsCard({super.key, required this.sinhHieu});
  SinhHieuData sinhHieu;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "${formatDate(sinhHieu.ngaydo)}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                    fontSize: 15,
                  ),
                ),
                Text(
                  "${formatTime(sinhHieu.ngaydo)}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: primaryColor,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Text(
              sinhHieu.tennguoidung,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: primaryColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Divider(height: 10),
        Wrap(
          runSpacing: 30,
          children: [
            Container(
              width: isSmallScreen(context)
                  ? screen(context).width
                  : screen(context).width / 2 - 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    constraints: BoxConstraints(minWidth: 100),
                    child: Column(
                      children: [
                        Measurement(
                            number: checkString(sinhHieu.mach),
                            text: "Mạch (l/p)",
                            icon: UniconsLine.heart_rate),
                        Measurement(
                            number: checkString(sinhHieu.spo2),
                            text: "SPO2 (%)")
                      ],
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minWidth: 100),
                    child: Column(
                      children: [
                        Measurement(
                          number: checkString(sinhHieu.nhietdo),
                          text: "Nhiệt độ (°C)",
                          icon: UniconsLine.temperature_quarter,
                        ),
                        Measurement(
                            number: checkString(sinhHieu.luongnuoctieu),
                            text: "Lượng nước tiểu"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: isSmallScreen(context)
                  ? screen(context).width
                  : screen(context).width / 2 - 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    constraints: BoxConstraints(minWidth: 100),
                    child: Column(
                      children: [
                        Measurement(
                          number: checkString(sinhHieu.huyetap),
                          text: "Huyết áp (mmHg)",
                        ),
                        Measurement(
                            number: checkString(sinhHieu.luongphan),
                            text: "Lượng phân"),
                      ],
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minWidth: 100),
                    child: Column(
                      children: [
                        Measurement(
                            number: checkString(sinhHieu.nhiptho),
                            text: "Nhịp thở (l/p)"),
                        Measurement(
                            number: checkString(sinhHieu.vongbung),
                            text: "Vòng bụng (cm)"),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class Measurement extends StatelessWidget {
  Measurement({
    super.key,
    required this.number,
    required this.text,
    this.icon,
  });
  String number;
  String text;
  IconData? icon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              number,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: primaryColor,
              ),
            ),
            Icon(icon, color: Colors.grey),
          ],
        ),
        Text(
          text,
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 5),
      ],
    );
  }
}
