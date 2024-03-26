import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/controllers/QuyenKhoaPhongController.dart';
import 'package:app_leohis/controllers/readQKPtoList.dart';
import 'package:app_leohis/models/HienDien.dart';
import 'package:app_leohis/models/quyenKhoaPhong.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/loadingPage.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../../../../controllers/HienDienController.dart';

class Chart_HienDien extends StatefulWidget {
  @override
  State<Chart_HienDien> createState() => _Chart_HienDienState();
}

class _Chart_HienDienState extends State<Chart_HienDien> {
  List<DataQkp> lstQKP = [];
  List<dataKhuPhongKhoa> lstKhoa = [];
  QuyenKhoaPhongController _conQuyenKhoaPhong = QuyenKhoaPhongController();
  LocalData localData = LocalData();
  String? khoa;
  bool load = false;
  HienDienController _conThongKe = HienDienController();
  HienDienData _thongKeData = HienDienData(
      hiendien: 0,
      nam: 0,
      nu: 0,
      bsDieutri: 0,
      hosoNgoaitru: 0,
      benhNang: 0,
      bhyt: 0,
      thuphi: 0,
      treem: 0,
      bvsk: 0,
      mienphi: 0);
  List<ChartData> datachart = [];

  List<ChartData2>? chartData2 = [];

  String selectKhoa = 'khoahscc';

  List<Color> chartColumnColors = [
    Color.fromARGB(255, 255, 245, 153),
    Color.fromARGB(255, 150, 239, 250),
    Color.fromARGB(255, 255, 198, 194),
    Color.fromARGB(255, 156, 208, 250),
    Color.fromARGB(255, 149, 255, 199),
    Color.fromARGB(255, 226, 180, 255),
    Color.fromARGB(255, 255, 192, 148),
    Color.fromARGB(255, 253, 162, 232),
  ];
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Khoa Hồi sức cấp cứu"), value: "khoahscc"),
      DropdownMenuItem(child: Text("Khoa Cấp cứu"), value: "khoacapcuu"),
      DropdownMenuItem(child: Text("Khoa Nội"), value: "khoanoi"),
      DropdownMenuItem(child: Text("Khoa Ngoại"), value: "khoangoai"),
      // for (var item in lstKhoa)
      //   DropdownMenuItem(
      //       child: Text("${item.tenkhoaphong}"), value: "${item.makhoaphong}"),
    ];
    return menuItems;
  }

  loadData() async {
    try {
      _thongKeData = await _conThongKe.getHienDien(selectKhoa);

      setState(() {
        _thongKeData;
      });
      datachart = [
        ChartData('BS điều trị', _thongKeData.bsDieutri, chartColumnColors[0]),
        ChartData(
            'HS ngoại trú', _thongKeData.hosoNgoaitru, chartColumnColors[1]),
        ChartData('Bệnh nặng', _thongKeData.benhNang, chartColumnColors[2]),
        ChartData('BHYT', _thongKeData.bhyt, chartColumnColors[3]),
        ChartData('Thu phí', _thongKeData.thuphi, chartColumnColors[4]),
        ChartData('Trẻ em', _thongKeData.treem, chartColumnColors[5]),
        ChartData('BVSK', _thongKeData.bvsk, chartColumnColors[6]),
        ChartData('Miễn phí', _thongKeData.mienphi, chartColumnColors[7]),
      ];

      chartData2 = [
        ChartData2('Nữ', _thongKeData.nu, Colors.blue.shade50),
        ChartData2('Nam', _thongKeData.nam, Colors.lightBlue.shade600),
      ];
    } catch (e) {}
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Loại HS', style: TextStyle(color: primaryColor))),
      DataColumn(
          numeric: false,
          label: Text('Tỉ lệ', style: TextStyle(color: primaryColor))),
      DataColumn(label: Text('SL', style: TextStyle(color: primaryColor)))
    ];
  }

  List<DataRow> _createRows() {
    double total = datachart.fold(0, (sum, item) => sum + item.soLuong);
    return datachart.map((item) {
      return DataRow(cells: [
        DataCell(
            Text("${item.loai}", maxLines: 1, overflow: TextOverflow.ellipsis)),
        DataCell(AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: 10,
          width: total != 0 ? item.soLuong / total * 170 + 2 : 0,
          decoration: BoxDecoration(
            color: chartColumnColors[datachart.indexOf(item)],
            borderRadius: BorderRadius.circular(5),
          ),
        )),
        DataCell(Text("${item.soLuong.toStringAsFixed(0)}",
            overflow: TextOverflow.ellipsis, maxLines: 1)),
      ]);
    }).toList();
  }

  readKhoa() async {
    setState(() {
      load = true;
    });
    try {
      loadKhoa();
      khoa = await localData.Shared_getKhoa();
      if (khoa != null) selectKhoa = khoa!;
      if (khoa == null) await localData.Shared_saveKhoa('khoahscc');
    } catch (e) {
    } finally {
      setState(() {
        load = false;
      });
    }
  }

  loadKhoa() async {
    try {
      lstQKP = await _conQuyenKhoaPhong.getQuyenKhoaPhong();

      setState(() {
        lstQKP;
        lstKhoa = readQKPtoList(data: lstQKP).readToListKhoa();
      });
    } catch (e) {
      showMessage(context, message: "Lỗi kết nối", type: "error");
    }
  }

  @override
  void initState() {
    super.initState();
    readKhoa();
    loadData();
  }

  Widget build(BuildContext context) {
    return load
        ? Loading()
        : Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: primaryColor),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        // MyDropdown(
                        //     items: dropdownItems,
                        //     selectted: khoa,
                        //     onChanged: (value) {
                        //       setState(() {
                        //         selectKhoa = value!;
                        //         loadData();
                        //       });

                        //       localData.Shared_saveKhoa(selectKhoa);
                        //     },
                        //   ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Thống kê hiện diện',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    width: isSmallScreen(context)
                        ? screen(context).width
                        : screen(context).width / 2,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: primaryColor,
                                width: 2,
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Hiện diện",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${_thongKeData.hiendien.toString()}",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(.3),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        width: _thongKeData.hiendien != 0
                                            ? 150 *
                                                (_thongKeData.nam /
                                                    _thongKeData.hiendien)
                                            : 0,
                                        height: 20,
                                        duration: Duration(milliseconds: 300),
                                        decoration: BoxDecoration(
                                          color: Colors.blueAccent.shade400,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Icon(UniconsLine.mars,
                                            color: themeModeColor, size: 20),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 3),
                                  Text("${_thongKeData.nam} nam",
                                      style: TextStyle(
                                          color: Colors.blueAccent.shade400,
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.pink.shade50
                                              .withOpacity(.2),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        width: _thongKeData.hiendien != 0
                                            ? 150 *
                                                (_thongKeData.nu /
                                                    _thongKeData.hiendien)
                                            : 0,
                                        height: 20,
                                        duration: Duration(milliseconds: 300),
                                        decoration: BoxDecoration(
                                          color: Colors.pink.shade200,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Icon(UniconsLine.venus,
                                            color: Colors.black87, size: 20),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 3),
                                  Text("${_thongKeData.nu} nữ",
                                      style: TextStyle(
                                          color: Colors.pink.shade200,
                                          fontWeight: FontWeight.w700))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  margin: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Container(
                    width: isSmallScreen(context)
                        ? screen(context).width
                        : screen(context).width / 2,
                    padding: EdgeInsets.all(10),
                    child: DataTable(
                      // headingRowColor: MaterialStatePropertyAll(primaryColor),
                      // dataTextStyle: TextStyle(fontWeight: FontWeight.w600),

                      columns: _createColumns(),
                      rows: _createRows(),
                    ),
                  ),
                ),
                Container(height: 30),
              ],
            ),
          );
  }
}

// ignore: must_be_immutable
class PresentCart extends StatelessWidget {
  PresentCart({
    super.key,
    required this.name,
    required this.quanlity,
    required this.color,
  });

  String name;
  int quanlity;
  Color color;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(maxWidth: 150),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          // color: themeModeColor,
          ),
      child: Row(
        children: [
          // Icon(icon, color: color),

          Icon(Icons.circle, color: color, size: 15),
          SizedBox(width: 3),
          Text(
            "$name ($quanlity)",
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey),
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.loai, this.soLuong, this.color);
  final String loai;
  final int soLuong;
  final Color color;
}

class ChartData2 {
  ChartData2(this.loai, this.soLuong, this.color);
  final String loai;
  final int soLuong;
  final Color color;
}
