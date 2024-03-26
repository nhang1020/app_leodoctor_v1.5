import 'package:app_leohis/controllers/SoKet15NgayController.dart';
import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/models/soKet15Ngay.dart';
import 'package:app_leohis/views/components/card_Data.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/container_ThongTinBN.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/line_TenChucNang.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../../../components/rowData.dart';
import '../../../utils/contants.dart';
import 'widgets/emptyPage.dart';
import 'widgets/loadingPage.dart';

// ignore: must_be_immutable
class Screen_SoKet15Ngay extends StatefulWidget {
  BenhNhanData patient;
  Screen_SoKet15Ngay({super.key, required this.patient});

  @override
  State<Screen_SoKet15Ngay> createState() => _Screen_SoKet15NgayState();
}

class _Screen_SoKet15NgayState extends State<Screen_SoKet15Ngay> {
  SoKet15NgayController _conSoKet15 = SoKet15NgayController();
  List<SoKet15NgayData> _listSoKet15 = [];
  bool loading = false;
  List<String> lstXetNghiemCls = [];
  loadData() async {
    setState(() {
      loading = true;
    });
    try {
      _listSoKet15 = await _conSoKet15.getSoKet15Ngay(widget.patient.mahs);

      setState(() {
        _listSoKet15;
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
            name: 'sơ kết 15 ngày điều trị  (${_listSoKet15.length})'),
        Expanded(
          // height: screen(context).height,
          child: loading
              ? Loading()
              : _listSoKet15.length == 0
                  ? EmptyList(listName: "sơ kết 15 ngày điều trị")
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Wrap(
                        children: <Widget>[
                          for (int index = 0;
                              index < _listSoKet15.length;
                              index++)
                            viewSoKet15ngay(_listSoKet15[index], index),
                        ],
                      ),
                    ),
        ),
      ],
    );
  }

  Widget viewSoKet15ngay(SoKet15NgayData data, int index) {
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
                                backgroundColor: Colors.transparent,
                                avatar: Icon(UniconsLine.user_nurse,
                                    color: primaryColor, size: 17),
                                label: Text(
                                  "${checkString(data.tenbs)}",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Chip(
                                backgroundColor: Colors.transparent,
                                avatar: Icon(Icons.date_range,
                                    color: primaryColor, size: 17),
                                label: Text(
                                  "Ngày ký: ${formatDate(data.ngaykyBacsi)}",
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
                  RowData('Ngày ký Bác Sĩ: ', 13,
                      " ${formatDate(data.ngaykyBacsi)} ", 15),
                  RowData('Ngày ký Trưởng Khoa: ', 13,
                      " ${formatDate(data.ngaykyTruongkhoa)} ", 15),
                  Divider(
                    color: const Color.fromARGB(66, 120, 120, 120),
                  ),
                  RowData('Quá trình điều trị: ', 13,
                      checkString(data.quatrinhdieutri), 15),
                  RowData('Hướng  điều trị: ', 13,
                      checkString(data.huongdieutri), 15),
                  RowData('Đánh giá kết quả: ', 13,
                      checkString(data.danhgiaketqua), 15),
                  Divider(
                    color: const Color.fromARGB(66, 120, 120, 120),
                  ),
                  RowData('Diễn biến lâm sàng: ', 13,
                      checkString(data.dienbienlamsang), 15),
                  Card_Data(
                    title: 'Xét nghiệm cận lâm sàng: ',
                    text: checkString(
                        data.xetnghiemcls.toString().replaceAll(',', '\n')),
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
