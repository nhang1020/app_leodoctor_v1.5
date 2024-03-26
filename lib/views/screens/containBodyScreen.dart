import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';

class ContainScreen extends StatefulWidget {
  final Widget page;
  final String title;
  const ContainScreen({required this.page, required this.title});

  @override
  State<ContainScreen> createState() => _ContainScreenState();
}

class _ContainScreenState extends State<ContainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shadowColor: Colors.black12,
        title: Text(
          widget.title.isEmpty ? "" : widget.title,
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.blueGrey),
      ),
      body: widget.page,
    );
  }
}
