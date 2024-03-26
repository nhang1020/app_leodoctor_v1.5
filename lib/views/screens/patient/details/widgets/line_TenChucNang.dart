import 'package:flutter/material.dart';

import '../../../../utils/contants.dart';

// ignore: must_be_immutable
class Line_TenChucNang extends StatelessWidget {
  String name;
  Line_TenChucNang({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text(
            "Danh sách ${name}",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Divider(
              height: 20,
              thickness: 2,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Line_TitleName extends StatelessWidget {
  String name;
  Line_TitleName({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text(
            "${name}",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 15, color: primaryColor),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Divider(
              height: 20,
              thickness: 2,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
