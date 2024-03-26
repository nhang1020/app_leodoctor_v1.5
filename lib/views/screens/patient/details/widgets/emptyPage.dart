import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EmptyList extends StatelessWidget {
  EmptyList({super.key, this.listName});
  String? listName;
  Color? color;
  @override
  Widget build(BuildContext context) {
    listName = listName != null ? "${listName} " : '';
    return Center(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/icons/inbox_64px.png",
                color: color ?? primaryColor,
              ),
              SizedBox(height: 10),
              Container(
                constraints: BoxConstraints(maxWidth: 250),
                child: Text(
                  "Danh sách ${listName}trống",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
