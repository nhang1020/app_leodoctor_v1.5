import 'package:app_leohis/controllers/ChiTietDonThuocController.dart';
import 'package:app_leohis/models/donThuocChiTiet.dart';
import 'package:app_leohis/views/components/rowData.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../../../utils/contants.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Screen_DonThuocChiTiet extends StatefulWidget {
  String madonthuoc;
  Screen_DonThuocChiTiet({super.key, required this.madonthuoc});

  @override
  State<Screen_DonThuocChiTiet> createState() => _Screen_DonThuocChiTietState();
}

class _Screen_DonThuocChiTietState extends State<Screen_DonThuocChiTiet> {
  ChiTietDonThuocController _conDonThuocChiTiet = ChiTietDonThuocController();
  List<DonThuocChiTietData> _listDonThuocCT = [];
  double sum = 0;

  loadData() async {
    try {
      _listDonThuocCT =
          await _conDonThuocChiTiet.getDonThuocChiTiet(widget.madonthuoc);

      setState(() {
        _listDonThuocCT;
        for (var item in _listDonThuocCT) sum += double.parse(item.thanhtien);
      });
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _listDonThuocCT.length == 0
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                topView(_listDonThuocCT.first),

                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Wrap(
                        children: [
                          for (int index = 0;
                              index < _listDonThuocCT.length;
                              index++)
                            viewThuoc(_listDonThuocCT[index], index),
                        ],
                      ),
                    ),
                  ),
                ),
                //Tổng tiền:

                //bottomView(),
              ],
            ),
    );
  }

  Widget topView(DonThuocChiTietData data) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: [boxShadows[5]],
        borderRadius: BorderRadius.circular(15),
        color: primaryColor,
      ),
      child: Container(
        width: isSmallScreen(context)
            ? screen(context).width
            : screen(context).width / 2,
        height: 60,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Người tạo: ',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).cardColor,
                ),
              ),
              Text(
                data.tennguoidung,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bottomView() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        color: primaryColor,
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tổng tiền: ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  Text(
                    '${NumberFormat.decimalPattern().format(sum)} đ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Theme.of(context).cardColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget viewThuoc(DonThuocChiTietData data, int index) {
    return InkWell(
      onTap: () => showDetail(data),
      child: Ink(
        width: isSmallScreen(context)
            ? screen(context).width
            : screen(context).width / 2 - 16,
        child: Card(
          margin: EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  // width: screen(context).width,
                  padding: EdgeInsets.all(5),
                  margin:
                      EdgeInsets.only(top: 5, right: 10, left: 5, bottom: 10),

                  child: Text(
                    data.tenthuoc,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      // width: screen(context).width / 2,
                      child: Row(children: [
                        Icon(UniconsLine.calendar_alt, size: 15),
                        SizedBox(width: 10),
                        Text(
                          '${formatTime(data.createdAt)} ${formatDate(data.createdAt)}',
                        ),
                      ]),
                    ),
                    Expanded(
                      child: Text(
                        'Số lượng: ${double.parse(data.soluong).toStringAsFixed(0).padLeft(2, '0')} ${data.donvi}',
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
                LineData(
                  left: 'Cách dùng: ',
                  right: checkString(data.cachdung),
                  sizeLeft: 14,
                  sizeRight: 16,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(UniconsLine.eye, size: 20, color: primaryColor),
                      SizedBox(width: 5),
                      Text(
                        "Xem chi tiết",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: primaryColor),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  showDetail(DonThuocChiTietData data) {
    double fontSize = 14;
    double thanhTien = double.parse(data.thanhtien);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Card(
            color: primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                data.tenthuoc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).cardColor,
                ),
              ),
            ),
          ),
          content: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  RowData(
                      'Thời gian: ',
                      fontSize,
                      "${formatTime(data.createdAt)}  ${formatDate(data.createdAt)} ",
                      15),
                  RowData('Kho: ', fontSize, checkString(data.tenkho), 15),
                  Divider(color: Colors.black38),
                  RowData('Tên viết tắt: ', fontSize,
                      checkString(data.tenviettat), 15),
                  RowData(
                      'Hoạt chất: ', fontSize, checkString(data.hoatchat), 15),
                  RowData(
                      'Hàm lượng: ', fontSize, checkString(data.hamluong), 15),
                  RowData('Đơn vị: ', fontSize, checkString(data.donvi), 15),
                  Divider(color: Colors.black38),
                  RowData(
                      'Liều dùng: ', fontSize, checkString(data.lieudung), 15),
                  RowData(
                      'Số lượng: ',
                      fontSize,
                      '${double.parse(data.soluong).toStringAsFixed(0).padLeft(2, '0')}',
                      15),
                  RowData('Số ngày: ', fontSize,
                      '${data.songay}'.padLeft(2, '0'), 15),
                  RowData(
                      'Cách dùng: ', fontSize, checkString(data.cachdung), 15),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(color: Colors.black12))),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              top: 5, bottom: 5, start: 15, end: 15),
                          child: Text(
                            'Sáng: ${double.parse(data.sang).toStringAsFixed(1)}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              top: 5, bottom: 5, start: 15, end: 15),
                          child: Text(
                            'Trưa: ${double.parse(data.trua).toStringAsFixed(1)}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              top: 5, bottom: 5, start: 15, end: 15),
                          child: Text(
                            'Chiều: ${double.parse(data.chieu).toStringAsFixed(1)}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              top: 5, bottom: 5, start: 15, end: 15),
                          child: Text(
                            'Tối: ${double.parse(data.toi).toStringAsFixed(1)}',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: const Color.fromARGB(66, 120, 120, 120),
                  ),
                  RowData(
                      'Đơn giá bệnh viện: ',
                      fontSize,
                      '${NumberFormat.decimalPattern().format(double.parse(data.dongiaBv))} đ',
                      15),
                  RowData(
                      'Đơn giá bảo hiểm: ',
                      fontSize,
                      '${NumberFormat.decimalPattern().format(double.parse(data.giaBhyt))} đ',
                      15),
                  RowData(
                      'Thành tiền: ',
                      fontSize,
                      '${NumberFormat.decimalPattern().format(thanhTien)} đ',
                      15)
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Đóng', style: TextStyle(color: primaryColor)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


// ListTile(
//               title: Container(
//                 child: Text(
//                   data.tenthuoc,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 0, 108, 158),
//                     fontSize: 20,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 ),
//               ),
//               subtitle: Column(
//                 children: [
//                   RowData(
//                       '${data.tenviettat}',
//                       15,
//                       "${formatTime(data.createdAt)}  ${formatDate(data.createdAt)} ",
//                       15),
//                   Padding(
//                     padding: const EdgeInsets.all(8),
//                     child: Container(
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               child: Text(
//                                 'Đơn vị: ${data.donvi}',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               child: Text(
//                                 'Số lượng: ${double.parse(data.soluong).toStringAsFixed(1)}',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: Container(
//                               child: Text(
//                                 'Thành tiền: ${NumberFormat.decimalPattern().format(thanhTien)} VND',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.black,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
          