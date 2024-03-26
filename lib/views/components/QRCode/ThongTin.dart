import 'package:app_leohis/views/components/QRCode/CCCD.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ThongTinQR extends StatefulWidget {
  CCCD? cccd;
  ThongTinQR({super.key, this.cccd});

  @override
  State<ThongTinQR> createState() => _ThongTinQRState();
}

class _ThongTinQRState extends State<ThongTinQR> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin QR'),
      ),
      body: Center(
        child: Text('${widget.cccd.toString()}'),
      ),
    );
  }
}
