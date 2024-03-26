import 'package:app_leohis/controllers/ChiPhiKcbController.dart';
import 'package:app_leohis/models/chiPhiKcb.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class Container_ChiPhiKcb extends StatefulWidget {
  String mahs;
  Container_ChiPhiKcb({super.key, required this.mahs});

  @override
  State<Container_ChiPhiKcb> createState() => _Container_ChiPhiKcbState();
}

class _Container_ChiPhiKcbState extends State<Container_ChiPhiKcb>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool loadingCP = false;
  ChiPhiKcbController _chiPhiKcbController = ChiPhiKcbController();
  ChiPhiKcbData _chiPhiKcbData = ChiPhiKcbData(
      tongchiphikcb: 0,
      tongtiennguoibenhtra: 0,
      dathu: 0,
      quybhyttt: 0,
      nguoibenhcct: 0,
      nguoibenhtt: 0,
      tamung: 0,
      hoantra: 0,
      thuthem: 0);

  void getChiPhiKcb() async {
    setState(() {
      loadingCP = true;
    });
    try {
      
        _chiPhiKcbData = await _chiPhiKcbController.getChiPhiKcb(widget.mahs);
        setState(() {
          _chiPhiKcbData;
        });
      
    } catch(e) {
    } finally {
      try {
        setState(() {
          loadingCP = false;
        });
      } catch (e) {}
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChiPhiKcb();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Container(
        padding: EdgeInsets.all(20),
        child: loadingCP
            ? Loading()
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Chi phí khám chữa bệnh',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      height: 3,
                      color: primaryColor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tổng chi phí: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          //color: primaryColor,
                        ),
                      ),
                      Text(
                        '${NumberFormat.decimalPattern().format(_chiPhiKcbData.tongchiphikcb)} đ',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  rowItem('Tạm ứng', _chiPhiKcbData.tamung, primaryColor),
                  rowItem('Hoàn trả', _chiPhiKcbData.hoantra, Colors.red),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  rowItem('BHYT thanh toán', _chiPhiKcbData.quybhyttt,
                      primaryColor),
                  rowItem('Người bệnh cùng trả', _chiPhiKcbData.nguoibenhcct,
                      primaryColor),
                  Padding(
                    padding: const EdgeInsets.all(3),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  rowItem('Tổng tiền cần trả',
                      _chiPhiKcbData.tongtiennguoibenhtra, primaryColor),
                  rowItem('Người bệnh thanh toán', _chiPhiKcbData.nguoibenhtt,
                      primaryColor),
                  rowItem('Thu thêm', _chiPhiKcbData.thuthem, Colors.green),
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  MyButton(
                    onPressed: () {
                      getChiPhiKcb();
                    },
                    subfixIcon: Icon(UniconsLine.refresh,
                        color: primaryColor, size: 20),
                    label: "Cập nhật",
                    color: primaryColor.withOpacity(.1),
                    textColor: primaryColor,
                  ),
                ],
              ),
      ),
    );
  }

  Widget rowItem(String name, double money, Color color) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${name}: ',
              style: TextStyle(
                fontSize: 16,
                //fontWeight: FontWeight.bold,
                //color: primaryColor,
              ),
            ),
            Text(
              '${NumberFormat.decimalPattern().format(money)} đ',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                //fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
