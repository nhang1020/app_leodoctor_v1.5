import 'dart:convert';

import 'package:app_leohis/models/BenhNhan.dart';
import 'package:flutter/material.dart';

import '../../../../utils/contants.dart';

// ignore: must_be_immutable
class Container_TopView extends StatefulWidget {
  BenhNhanData patient;
  Container_TopView({super.key, required this.patient});

  @override
  State<Container_TopView> createState() => _Container_TopViewState();
}

class _Container_TopViewState extends State<Container_TopView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: screen(context).width,
      // isSmallScreen(context)
      //   ? screen(context).width
      //   : screen(context).width / 2,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // patient.gioitinh == '1'
                //     ? Image.asset("assets/images/medicals/patient_male.png",
                //         width: 40)
                //     : Image.asset("assets/images/medicals/patient_female.png",
                //         width: 40),
                Container(
                  padding: EdgeInsets.all(3),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: themeModeColor, width: 2),
                    image: widget.patient.avatar != '' &&
                            widget.patient.avatar != null
                        ? DecorationImage(
                            image: MemoryImage(
                              base64Decode(widget.patient.avatar
                                  .toString()
                                  .substring("data:image/jpeg;base64,".length)),
                            ),
                          )
                        : DecorationImage(
                            image: widget.patient.gioitinh == '1'
                                ? AssetImage(
                                    "assets/images/medicals/patient_male.png")
                                : AssetImage(
                                    "assets/images/medicals/patient_female.png"),
                          ),
                  ),
                ),
                Text(
                  "ID: ${widget.patient.idbn}",
                  style: TextStyle(color: Theme.of(context).cardColor),
                ),
              ],
            ),
          ),
          Container(height: 80, width: 2, color: Theme.of(context).cardColor),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.patient.hotenbn} (${DateTime.now().year - widget.patient.ngaysinh.year} tuổi)",
                    style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Giới tính: ${checkGender(widget.patient.gioitinh)}",
                    style: TextStyle(color: Theme.of(context).cardColor),
                  ),
                  Text(
                    "Loại HS: ${checkLoaiHoSo(widget.patient.maloaihs)}",
                    style: TextStyle(color: Theme.of(context).cardColor),
                  ),
                  Text(
                    "Số HS: ${widget.patient.sohoso}",
                    style: TextStyle(color: Theme.of(context).cardColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
