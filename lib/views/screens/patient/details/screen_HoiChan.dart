import 'package:app_leohis/controllers/HoiChanController.dart';
import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/models/hoiChan.dart';
import 'package:app_leohis/views/components/card_Data.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/container_ThongTinBN.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/line_TenChucNang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:unicons/unicons.dart';
import '../../../components/rowData.dart';
import '../../../utils/contants.dart';
import 'widgets/emptyPage.dart';
import 'widgets/loadingPage.dart';

// ignore: must_be_immutable
class Screen_HoiChan extends StatefulWidget {
  BenhNhanData patient;
  Screen_HoiChan({super.key, required this.patient});

  @override
  State<Screen_HoiChan> createState() => _Screen_HoiChanState();
}

class _Screen_HoiChanState extends State<Screen_HoiChan> {
  HoiChanController _conHoiChan = HoiChanController();
  List<HoiChanData> _listHoiChan = [];
  bool loading = false;
  loadData() async {
    setState(() {
      loading = true;
    });
    try {
      _listHoiChan = await _conHoiChan.getHoiChan(widget.patient.mahs);
      setState(() {
        _listHoiChan;
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

  String HTML(String html) {
    html = html.replaceAll('label',
        """b , style=" border: 1px solid black; padding: 5px; border-radius: 50px/50px" """);

    return html;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container_TopView(patient: widget.patient),
        Line_TenChucNang(name: 'hội chẩn  (${_listHoiChan.length})'),
        Expanded(
          // height: screen(context).height,
          child: loading
              ? Loading()
              : _listHoiChan.length == 0
                  ? EmptyList(listName: "hội chẩn")
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Wrap(
                        children: <Widget>[
                          for (int index = 0;
                              index < _listHoiChan.length;
                              index++)
                            viewHoiChan(_listHoiChan[index], index),
                        ],
                      ),
                    ),
        ),
      ],
    );
  }

  Widget viewHoiChan(HoiChanData data, int index) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.all(2),
      width: isSmallScreen(context)
          ? screen(context).width
          : screen(context).width / 2 - 5,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
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
                          "${formatTime(data.ngayhoichan)}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: primaryColor),
                        ),
                        Text("${formatDate(data.ngayhoichan)}"),
                      ],
                    ),
                  ),
                  Container(
                    height: 70,
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
                                avatar: Icon(UniconsLine.hospital,
                                    color: primaryColor, size: 17),
                                label: Text(
                                  "${checkString(data.tenkhoa)}",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Chip(
                                backgroundColor: Colors.transparent,
                                avatar: Icon(
                                    Icons.assignment_turned_in_outlined,
                                    color: primaryColor,
                                    size: 17),
                                label: Text(
                                  "${checkString(data.hinhthuc)}",
                                  maxLines: 2,
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
              Divider(
                height: 2,
              ),
              ExpansionTile(
                title: Text(
                  'Thông tin chi tiết',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                initiallyExpanded: false,
                childrenPadding: EdgeInsets.all(5),
                backgroundColor: primaryColor.withOpacity(.05),
                iconColor: primaryColor,
                textColor: primaryColor,
                collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                children: [
                  RowData('Chủ tọa : ', 13, checkString(data.chutoa), 14),
                  RowData('Thư ký : ', 13, checkString(data.thuky), 14),
                  // RowData(
                  //     'Thành viên : ',
                  //     13,
                  //     checkString(
                  //         data.thanhvien.toString().replaceAll('  ', '\n')),
                  //     15),
                  Card_Data(
                    title: 'Thành viên : ',
                    text: checkString(data.thanhvien
                        .toString()
                        .replaceAll('  ', '\n')
                        .trim()),
                  ),
                  Divider(
                    height: 2,
                  ),
                  RowData(
                      'Chuẩn đoán: ',
                      13,
                      checkString(
                          data.chandoan.toString().replaceAll(';', '\n')),
                      14),
                  RowData('Hướng điều trị: ', 13,
                      checkString(data.huongdieutri), 14),
                  Card_Data(
                    title: 'Tóm tắt điều trị: ',
                    wtext: SingleChildScrollView(
                      child: HtmlWidget(
                        HTML(data.tomtatDieutri),
                        buildAsync: true,
                      ),
                    ),
                  ),
                  RowData('Kết luận: ', 13, checkString(data.ketluan), 15),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
