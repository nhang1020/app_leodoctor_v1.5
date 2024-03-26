import 'package:app_leohis/models/BenhNhanDieuTri.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class Container_ThongTinDieuTri extends StatefulWidget {
  BenhNhanDTData patient;
  Container_ThongTinDieuTri({super.key, required this.patient});

  @override
  State<Container_ThongTinDieuTri> createState() =>
      _Container_ThongTinDieuTriState();
}

class _Container_ThongTinDieuTriState extends State<Container_ThongTinDieuTri> {
  String HTML(String html) {
    html = html.replaceAll('label',
        """b , style=" border: 1px solid black; padding: 5px; border-radius: 50px/50px" """);

    return html;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ExpansionTile(
            initiallyExpanded: true,
            childrenPadding: EdgeInsets.all(5),
            backgroundColor: primaryColor.withOpacity(.05),
            iconColor: primaryColor,
            textColor: primaryColor,
            collapsedShape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(
              "Ngày lập phiếu: ${formatDateVi2(widget.patient.pdtNgaylap)}",
              style: TextStyle(fontSize: 14),
            ),
            children: [
              Row(
                children: [
                  Icon(UniconsLine.file_check, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text("Chẩn đoán: ${widget.patient.pdtChandoan}",
                        maxLines: 2, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(UniconsLine.heart_rate, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text("Diễn biến: ${widget.patient.pdtDienbien}",
                        maxLines: 5, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Y lệnh diễn giải',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: primaryColor),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                // height: 200,
                child: SingleChildScrollView(
                  child: HtmlWidget(
                    HTML(widget.patient.ylenhDiengiai),
                    buildAsync: true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
