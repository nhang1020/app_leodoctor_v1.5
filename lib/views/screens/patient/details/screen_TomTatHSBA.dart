import 'package:app_leohis/controllers/TomTatBAController.dart';
import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/models/tomTatBenhAn.dart';
import 'package:app_leohis/views/components/card_Data.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/container_ThongTinBN.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/line_TenChucNang.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../../../components/rowData.dart';
import '../../../utils/contants.dart';
import 'widgets/emptyPage.dart';

// ignore: must_be_immutable
class Screen_TomTatHSBA extends StatefulWidget {
  BenhNhanData patient;

  Screen_TomTatHSBA({super.key, required this.patient});

  @override
  State<Screen_TomTatHSBA> createState() => _Screen_TomTatHSBAState();
}

class _Screen_TomTatHSBAState extends State<Screen_TomTatHSBA> {
  TomTatBAController _conTomTatBA = TomTatBAController();
  List<TomTatBenhAnData> _listTomTatBA = [];
  bool loading = false;

  loadData() async {
    setState(() {
      loading = true;
    });
    try {
      _listTomTatBA = await _conTomTatBA.getTomTatBenhAn(widget.patient.mahs);

      setState(() {
        _listTomTatBA;
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
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container_TopView(patient: widget.patient),
        Line_TenChucNang(
            name: 'tóm tắt hồ sơ bệnh án  (${_listTomTatBA.length})'),
        Expanded(
          // height: screen(context).height,
          child: loading
              ? Loading()
              : _listTomTatBA.length == 0
                  ? EmptyList(listName: "sơ kết 15 ngày điều trị")
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Wrap(
                        children: <Widget>[
                          for (int index = 0;
                              index < _listTomTatBA.length;
                              index++)
                            viewTomTatHSBA(_listTomTatBA[index], index),
                        ],
                      ),
                    ),
        ),
      ],
    );
  }

  Widget viewTomTatHSBA(TomTatBenhAnData data, int index) {
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
                          "${formatTime(data.ngaylap)}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: primaryColor),
                        ),
                        Text("${formatDate(data.ngaylap)}"),
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
                                avatar: Icon(UniconsLine.user_nurse,
                                    color: primaryColor, size: 17),
                                label: Text(
                                  "${checkString(data.nguoilap)}",
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
                  RowData('Đơn vị công tác: ', 13,
                      checkString(data.donvicongtac), 15),
                  RowData('Nơi nhận: ', 13, checkString(data.noinhan), 15),
                  RowData('Chuẩn đoán Vào viện: ', 13,
                      checkString(data.chandoanVaovien), 15),
                  RowData('Chuẩn đoán Ra viện: ', 13,
                      checkString(data.chandoanRavien), 15),
                  RowData('Tình trạng ra viện: ', 13,
                      checkString(data.tinhtrangravien), 15),
                  RowData('Tóm tắt bệnh nhân: ', 13,
                      checkString(data.tomtatbenhan), 15),
                  RowData('Tóm tắt cận lâm sàng: ', 13,
                      checkString(data.tomtatcanlamsang), 15),
                  RowData('Phương pháp điều trị: ', 13,
                      checkString(data.phuongphapdieutri), 15),
                  RowData('Ghi chú: ', 13, checkString(data.ghichu), 15),
                  Card_Data(
                    title: 'Quá trình bệnh lý:',
                    text: checkString(data.quatrinhbenhly),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
