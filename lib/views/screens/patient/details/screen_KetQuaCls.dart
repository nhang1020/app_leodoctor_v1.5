import 'package:app_leohis/controllers/KetQuaClsController.dart';
import 'package:app_leohis/controllers/XemKetQuaClsController.dart';
import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/models/ketQuaCls.dart';
import 'package:app_leohis/models/xemKetQuaCls.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/container_ThongTinBN.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/line_TenChucNang.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/loadingPage.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/webViewPage.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:page_transition/page_transition.dart';
import '../../../components/rowData.dart';
import '../../../utils/contants.dart';
// import 'package:url_launcher/url_launcher.dart';
import '../../containBodyScreen.dart';
import 'widgets/emptyPage.dart';

// ignore: must_be_immutable
class Screen_KetQuaCls extends StatefulWidget {
  String MaNhomDv;
  BenhNhanData patient;
  Screen_KetQuaCls({super.key, required this.MaNhomDv, required this.patient});

  @override
  State<Screen_KetQuaCls> createState() => _Screen_KetQuaClsState();
}

class _Screen_KetQuaClsState extends State<Screen_KetQuaCls> {
  KetQuaClsController _conCls = KetQuaClsController();
  List<KetQuaClsData> _listCls = [];
  XemKetQuaClsController _conXemCls = XemKetQuaClsController();
  bool ketQua = false;
  XemKetQuaClsData _ketQuaCls = XemKetQuaClsData(link: '');
  bool loading = false;
  loadData() async {
    setState(() {
      loading = true;
    });
    try {
      _listCls =
          await _conCls.getKetQuaCls(widget.patient.mahs, widget.MaNhomDv);
      setState(() {
        _listCls;
      });
    } catch (e) {
    } finally {
      try {
        setState(() {
          loading = false;
        });
      } catch (e) {}
    }
    return true;
  }

  xemKetQua_TrinhDuyet(String? machidinh_dvct) async {
    ketQua = await _conXemCls.getKetQuaCls(machidinh_dvct);
    if (ketQua == true) {
      _ketQuaCls = await _conXemCls.getDataCls(machidinh_dvct);
    } else {
      showMessaged('Không có mã chỉ định');
    }
    setState(() {
      ketQua;
      _ketQuaCls;
    });
  }

  Future<String> getUrlKetQua(String? machidinh_dvct) async {
    String url = '';

    ketQua = await _conXemCls.getKetQuaCls(machidinh_dvct);
    if (ketQua == true) {
      _ketQuaCls = await _conXemCls.getDataCls(machidinh_dvct);
      url = _ketQuaCls.link;
    }

    return url;
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
        Line_TenChucNang(name: 'kết quả cận lâm sàng  (${_listCls.length})'),
        Expanded(
          child: loading
              ? Loading()
              : _listCls.length == 0
                  ? EmptyList(
                      listName: 'kết quả cận lâm sàng',
                    )
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Wrap(
                        children: <Widget>[
                          for (int index = 0; index < _listCls.length; index++)
                            viewKetQuaCls(_listCls[index], index),
                        ],
                      ),
                    ),
        ),
      ],
    );
  }

  Widget viewKetQuaCls(KetQuaClsData data, int index) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      width: isSmallScreen(context)
          ? screen(context).width
          : screen(context).width / 2 - 4,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Visibility(
                visible: data.hsHientai == '1' ? true : false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Chip(
                      backgroundColor: Colors.transparent,
                      side: BorderSide(color: Colors.green),
                      avatar: Icon(
                        Icons.remove_red_eye,
                        color: Colors.green,
                        size: 16,
                      ),
                      label: Text(
                        'Đang xem',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.green,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: data.hsHientai == 1 ? 15 : 1,
              // ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Ngày chỉ định',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            "${formatTime(data.ngayChidinh)}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: primaryColor),
                          ),
                          Text(
                            "${formatDate(data.ngayChidinh)}",
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 70,
                        width: 2,
                        color: primaryColor,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          checkString(data.tendichvu),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 1,
              ),
              data.ngayKetqua != null
                  ? RowData(
                      'Ngày trả kết quả: ',
                      15,
                      "${formatTime(data.ngayKetqua)}  ${formatDate(data.ngayKetqua)}",
                      16)
                  : RowData('Ngày trả kết quả: ', 15, "--", 16),
              RowData('Nhóm dịch vụ: ', 15, checkString(data.tennhomdv), 16),
              RowData(
                  'Bác sĩ chỉ định: ', 15, checkString(data.bacsiChidinh), 16),
              RowData('Khoa chỉ định: ', 15, checkString(data.khoaChidinh), 16),
              RowData(
                  'Khoa trả kết quả: ', 15, checkString(data.khoaTrakq), 16),
              Visibility(
                visible: int.parse(data.tinhtrangSudung) == 1 ? true : false,
                child: MyButton(
                  icon: Icon(
                    UniconsLine.eye,
                    size: 20,
                    color: Theme.of(context).cardColor,
                  ),
                  label: "Xem kết quả",
                  onPressed: () async {
                    String url = await getUrlKetQua(data.machidinhDvct);
                    print(url);
                    url == ''
                        ? showMessage(context,
                            message: "Không thể xem, chưa có kết quả CLS")
                        : Navigator.push(
                            context,
                            PageTransition(
                                child: ContainScreen(
                                  page: WebView_Page(
                                    url: url,
                                  ),
                                  title: "Xem kết quả cận lâm sàng",
                                ),
                                type: PageTransitionType.rightToLeft));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showMessaged(String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text(
            message,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Đóng'),
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
