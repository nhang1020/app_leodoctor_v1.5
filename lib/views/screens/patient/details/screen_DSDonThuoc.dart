import 'package:app_leohis/controllers/DonThuocController.dart';
import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/models/donThuoc.dart';
import 'package:app_leohis/views/components/zoomContainer.dart';
import 'package:app_leohis/views/screens/patient/details/screen_DonThuocChiTiet.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/container_ThongTinBN.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/emptyPage.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/line_TenChucNang.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/loadingPage.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../../../utils/contants.dart';
import '../../containBodyScreen.dart';

// ignore: must_be_immutable
class Screen_DSDonThuoc extends StatefulWidget {
  Screen_DSDonThuoc({super.key, required this.patient});
  BenhNhanData patient;
  @override
  State<Screen_DSDonThuoc> createState() => _Screen_DSDonThuocState();
}

class _Screen_DSDonThuocState extends State<Screen_DSDonThuoc> {
  DonThuocController _conDonThuoc = DonThuocController();
  List<DonThuocData> _listDonThuoc = [];
  bool loading = false;
  loadData() async {
    setState(() {
      loading = true;
    });
    try {
      _listDonThuoc = await _conDonThuoc.getDonThuoc(widget.patient.mahs);
      setState(() {
        _listDonThuoc;
      });
    } catch (e) {
    } finally {
      setState(() {
        loading = false;
      });
    }
    return true;
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
        Line_TenChucNang(name: 'đơn thuốc  (${_listDonThuoc.length})'),
        Expanded(
          child: loading
              ? Loading()
              : _listDonThuoc.length == 0
                  ? EmptyList(
                      listName: 'đơn thuốc',
                    )
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Wrap(
                          children: <Widget>[
                            for (int index = 0;
                                index < _listDonThuoc.length;
                                index++)
                              viewThuoc(_listDonThuoc[index], index),
                          ],
                        ),
                      ),
                    ),
        ),
      ],
    );
  }

  Widget viewThuoc(DonThuocData data, int index) {
    return Container(
      width: isSmallScreen(context)
          ? screen(context).width
          : screen(context).width / 2 - 10,
      child: Card(
        child: ZoomContainer(
          duration: Duration(milliseconds: 300),
          closedColor: Theme.of(context).cardColor,
          openWidget: ContainScreen(
              page: Screen_DonThuocChiTiet(
                madonthuoc: data.madonthuoc,
              ),
              title:
                  "Thời gian: ${formatDate(data.ngay)} - ${formatTime(data.ngay)}"),
          closeWidget: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [],
            ),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${formatTime(data.ngay)}",
                        style: TextStyle(color: primaryColor),
                      ),
                      Text(
                        "${formatDate(data.ngay)}",
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: 2,
                  color: primaryColor,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Wrap(
                      runSpacing: 10,
                      children: [
                        Chip(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          avatar: Icon(UniconsLine.hospital,
                              color: primaryColor, size: 17),
                          label: Text(
                            "${checkString(data.tenkhoa)}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Chip(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          avatar: Icon(UniconsLine.user_nurse,
                              color: primaryColor, size: 17),
                          label: Text(
                            "${checkString(data.tenbs)}",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.grey)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
