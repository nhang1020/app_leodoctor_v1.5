import 'package:app_leohis/controllers/LichSuKCBController.dart';
import 'package:app_leohis/models/lichSuKham.dart';
import 'package:app_leohis/views/components/card_Data.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/emptyPage.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/loadingPage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Screen_LichSuKham extends StatefulWidget {
  String mabn;
  Screen_LichSuKham({required this.mabn});

  @override
  State<Screen_LichSuKham> createState() => _Screen_LichSuKhamState();
}

class _Screen_LichSuKhamState extends State<Screen_LichSuKham>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  con_LichSuKham _conLSKham = con_LichSuKham();
  List<LichSuKhamData> _listHistory = [];
  bool loading = false;

  loadData() async {
    setState(() {
      loading = true;
    });
    try {
      
        _listHistory = await _conLSKham.getLichSuKham(widget.mabn);
        setState(() {
          _listHistory;
        });
      
    } catch (e) {
    } finally {
      try {
        setState(() {
          loading = false;
        });
      } catch (e) {}
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        DividerTitle(title: 'Lịch sử khám'),
        Expanded(
          // height: screen(context).height,
          child: loading
              ? Loading()
              : _listHistory.length == 0
                  ? EmptyList(listName: "lịch sử khám")
                  : SingleChildScrollView(
                      child: Wrap(
                        children: <Widget>[
                          for (int index = 0;
                              index < _listHistory.length;
                              index++)
                            viewHistory(_listHistory[index], index),
                        ],
                      ),
                    ),
        ),
      ],
    );
  }

  Widget viewHistory(LichSuKhamData data, int index) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.all(2),
      width: isSmallScreen(context)
          ? screen(context).width
          : screen(context).width / 2 - 5,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ngày khám',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            // color: primaryColor
                          ),
                        ),
                        Text(
                          "${formatTime(data.ngaykham)}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: primaryColor),
                        ),
                        Text(
                          "${formatDate(data.ngaykham)}",
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 2,
                    color: primaryColor,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Chip(
                                backgroundColor: Colors.transparent,
                                avatar: Icon(Icons.numbers,
                                    color: primaryColor, size: 17),
                                label: Text(
                                  "Số HS: ${checkString(data.sohoso)}",
                                ),
                              ),
                              Chip(
                                backgroundColor: Colors.transparent,
                                avatar: Icon(Icons.class_,
                                    color: primaryColor, size: 17),
                                label: Text(
                                  "Loại: ${checkString(data.loaikcb)}",
                                ),
                              ),
                              Chip(
                                backgroundColor: Colors.transparent,
                                avatar: Icon(Icons.date_range,
                                    color: primaryColor, size: 17),
                                label: Text(
                                  "Vào viện: ${formatDate(data.ngayvaovien)}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Card_Data(
                title: 'Chẩn đoán: ',
                text:
                    "${checkString(data.chandoan)}, (${checkString(data.chandoanIcd)}) ",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
