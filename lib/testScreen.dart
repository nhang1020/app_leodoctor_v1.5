import 'dart:convert';
import 'package:app_leohis/views/components/QRCode/BHYT.dart';
import 'package:convert/convert.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  bool isListening = false;
  SpeechToText speechToText = SpeechToText();
  String text =
      '8924380620|5472e1baa76e205468616e68204e68c3a06e67|12/10/2001|1|-|89 - 012|01/12/2021|-|07/01/2022|89008924380620|-|4|20/09/2021|70289294e018da7-7102|4|54e1bb896e6820416e204769616e67|#';

  String hexToUtf8(String text) {
    List<int> bytes = hex.decode(text);
    String utf8String = utf8.decode(bytes);
    return utf8String;
  }

  DateTime toDatime(String text) {
    try {
      DateFormat date = DateFormat("dd/MM/yyyy");
      return date.parse(text);
    } catch (e) {
      print(e);
      return DateTime.now();
    }

    // return DateTime(int.parse(year), int.parse(mon), int.parse(day));
  }

  BHYT? readBHYT(String data) {
    try {
      var getbhyt = text.split('|');

      var bhyt = BHYT(
        maThe: getbhyt[0].toString(),
        hoTen: hexToUtf8(getbhyt[1].toString()),
        ngaySinh: toDatime(getbhyt[2].toString()),
        gioiTinh: int.parse(getbhyt[3].toString()),
        diaChi: getbhyt[4].toString(),
        maCoSo: getbhyt[5].toString(),
        hsdTuNgay: toDatime(getbhyt[6].toString()),
        hsdDenNgay: getbhyt[7].toString() != "-"
            ? toDatime(getbhyt[7].toString())
            : getbhyt[7].toString(),
        ngayCap: toDatime(getbhyt[8].toString()),
        maQuanLy: getbhyt[9].toString(),
        tenChaMe: getbhyt[10].toString(),
        maNoiSong: int.parse(getbhyt[11].toString()),
        thoiDiem5Nam: toDatime(getbhyt[12].toString()),
        chuoiKiemTra: getbhyt[13].toString(),
        maHuong: int.parse(getbhyt[14].toString()),
        noiCapDoithe: hexToUtf8(getbhyt[15].toString()),
      );
      print(bhyt.toJson());
      return bhyt;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text('$text'),
              MyButton(
                label: "Click",
                onPressed: () {
                  print(hexToUtf8('5472e1baa76e205468616e68204e68c3a06e67'));
                  readBHYT(text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
