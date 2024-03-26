import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Card_Data extends StatefulWidget {
  String title;
  String? text;
  Widget? wtext;
  Card_Data({super.key, required this.title, this.text, this.wtext});

  @override
  State<Card_Data> createState() => _Card_DataState();
}

class _Card_DataState extends State<Card_Data> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
          initiallyExpanded: true,
          childrenPadding: EdgeInsets.all(5),
          backgroundColor: primaryColor.withOpacity(.05),
          iconColor: primaryColor,
          textColor: primaryColor,
          collapsedShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text("${widget.title}",
              style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500)),
          children: [
            widget.wtext != null
                ? Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    alignment: Alignment.topLeft,
                    child: widget.wtext,
                  )
                : Container(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${widget.text}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
          ]),
    );
  }
}
