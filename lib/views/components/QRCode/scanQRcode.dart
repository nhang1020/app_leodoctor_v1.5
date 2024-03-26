import 'dart:io';
import 'package:app_leohis/views/components/QRCode/CCCD.dart';
import 'package:app_leohis/views/components/QRCode/ThongTin.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen(
      (scanData) {
        setState(() {
          result = scanData;
        });

        controller.pauseCamera();
        var cccd = readCCCD('${scanData.code}');
        if (cccd != null)
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ThongTinQR(cccd: cccd),
              ));
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  CCCD? readCCCD(String data) {
    try {
      var getcccd = data.split('|');
      if (getcccd.length == 7) {
        var cccd = CCCD(
          soCCCD: getcccd[0].toString(),
          soCmnd: getcccd[1].toString(),
          ten: getcccd[2].toString(),
          ngaySinh: toDatime(getcccd[3].toString()),
          gioiTinh: getcccd[4].toString(),
          diaChi: getcccd[5].toString(),
          ngayCap: toDatime(getcccd[6].toString()),
        );
        print(cccd.toJson());
        return cccd;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  DateTime toDatime(String text) {
    var day = text.substring(0, 2);
    var mon = text.substring(2, 4);
    var year = text.substring(4);

    return DateTime(int.parse(year), int.parse(mon), int.parse(day));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Quét mã QR'),
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                  overlay: QrScannerOverlayShape(
                    borderWidth: 6,
                    borderColor: Colors.green,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: result != null
                      ? Text('${result!.code}')
                      : Text('Đang quét...'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
