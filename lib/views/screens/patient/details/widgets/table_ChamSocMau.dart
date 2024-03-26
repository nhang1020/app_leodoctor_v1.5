import 'package:app_leohis/controllers/ChamSocMauController.dart';
import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/models/ChamSocMau.dart';
import 'package:app_leohis/models/phieuChamSoc.dart';
import 'package:app_leohis/views/components/dropDown.dart';
import 'package:app_leohis/views/components/rowData.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/emptyPage.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/table_PhieuChamSoc.dart';
import 'package:flutter/material.dart';
import '../../../../utils/contants.dart';

// ignore: must_be_immutable
class Table_ChamSocMau extends StatefulWidget {
  BenhNhanData patient;
  String maPhieu;
  Table_ChamSocMau({super.key, required this.maPhieu, required this.patient});

  @override
  State<Table_ChamSocMau> createState() => _Table_ChamSocMauState();
}

class _Table_ChamSocMauState extends State<Table_ChamSocMau> {
  String selectedValue = "khoahscc";
  ChamSocMauController _chamSocMauController = ChamSocMauController();
  List<ChamSocMauData> _listMau = [];

  PhieuChamSocData initPhieuChamSoc(ChamSocMauData data) {
    String chanDoan = getChanDoan();
    return PhieuChamSocData(
        maphieu: '',
        ngaylap: DateTime.now(),
        nguoilap: '',
        chandoan: chanDoan,
        dienbien: data.dienbien,
        ylenh: data.ylenh,
        soluongChuky: '',
        soluongDaky: '');
  }

  String getChanDoan() {
    return '${widget.patient.chandoanTaikhoa ?? ''}(${widget.patient.icdTaikhoa ?? ''}), ${widget.patient.chandoanphuTaikhoa ?? ''}';
  }

  loadData() async {
    try {
      _listMau = await _chamSocMauController.getChamSocMau(selectedValue);

      setState(() {
        _listMau;
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
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          content: Container(
            width: 400,
            height: 600,
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                buildMenuKhoa(),
                Container(
                  height: 500,
                  child: _listMau.length == 0
                      ? EmptyList()
                      : ListView(
                          children: <Widget>[
                            for (int index = 0;
                                index < _listMau.length;
                                index++)
                              viewChamSocMau(_listMau[index]),
                          ],
                        ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Đóng',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  viewChamSocMau(ChamSocMauData data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          initPhieuChamSoc(data);
          PhieuChamSocData _pcs = initPhieuChamSoc(data);
          showDialog(
              context: context,
              builder: (context) => Table_PhieuChamSoc(
                    patient: widget.patient,
                    maPhieu: '',
                    pcs: _pcs,
                  )).then((val) {
            if (val == 1) Navigator.pop(context, 1);
          });
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(color: primaryColor),
              borderRadius: BorderRadius.circular(20),
              boxShadow: []),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(2, 7),
                            blurRadius: 5,
                            color: primaryColor.withOpacity(.2))
                      ]),
                  child: Text(
                    'Tên phiếu: ${checkString(data.tenphieumau)}',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: themeModeColor, fontSize: 15),
                  ),
                ),
              ),
              Divider(
                color: primaryColor,
              ),
              RowData('Diễn biến', 14, '${data.dienbien}', 15),
              Divider(
                color: primaryColor,
              ),
              RowData('Y lệnh', 14, '${data.ylenh}', 15)
            ],
          ),
        ),
      ),
    );
  }

  buildMenuKhoa() {
    return MyDropdown(
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
          loadData();
        });
      },
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Khoa Hồi sức cấp cứu"), value: "khoahscc"),
    DropdownMenuItem(child: Text("Khoa Cấp cứu"), value: "khoacapcuu"),
    DropdownMenuItem(child: Text("Khoa Nội"), value: "khoanoi"),
    DropdownMenuItem(child: Text("Khoa Ngoại"), value: "khoangoai"),
  ];
  return menuItems;
}
