import 'package:app_leohis/models/BenhNhanChamSoc.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Container_ThongTinBNCS extends StatefulWidget {
  BenhNhanCSData patient;
  Container_ThongTinBNCS({super.key, required this.patient});

  @override
  State<Container_ThongTinBNCS> createState() => _Container_ThongTinBNCSState();
}

class _Container_ThongTinBNCSState extends State<Container_ThongTinBNCS> {
  bool show = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        initiallyExpanded: true,
        childrenPadding: EdgeInsets.all(5),
        backgroundColor: primaryColor.withOpacity(.05),
        iconColor: primaryColor,
        textColor: primaryColor,
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
            "Ngày kê: ${formatDateVi2(widget.patient.donthuocChitiet[0].ngayDonthuoc)} | số lượng: ${widget.patient.donthuocChitiet.length.toString().padLeft(2, '0')}",
            style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500)),
        children: widget.patient.donthuocChitiet.map((item) {
          return Container(
            margin: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                      "${widget.patient.donthuocChitiet.indexOf(item) + 1} . ${item.tenthuoc}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                      "SL: ${convertDouble(item.soluong).toStringAsFixed(0).padLeft(2, '0')} ${item.donvi}",
                      // style: TextStyle(color: primaryColor),
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
