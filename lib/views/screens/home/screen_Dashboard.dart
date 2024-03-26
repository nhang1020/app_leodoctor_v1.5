import 'package:app_leohis/controllers/HienDienController.dart';
import 'package:app_leohis/controllers/LichTrucController.dart';
import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/controllers/readQKPtoList.dart';
import 'package:app_leohis/models/HienDien.dart';
import 'package:app_leohis/models/LichTruc.dart';
import 'package:app_leohis/views/screens/home/widgets/lichTruc_Container.dart';
import 'package:app_leohis/views/screens/home/widgets/thongKe_Container.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Screen_Dashboard extends StatefulWidget {
  const Screen_Dashboard({super.key});

  @override
  State<Screen_Dashboard> createState() => _Screen_DashboardState();
}

class _Screen_DashboardState extends State<Screen_Dashboard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  String _selectKhoa = "";
  dynamic khoa;
  LocalData localData = LocalData();
  List<String> _lstBacSi = [];
  List<String> _lstDieuDuong = [];
  List<String> _lstHoLy = [];
  List<dataKhuPhongKhoa> _lstKhoa = [];
  LichTrucData _scheduleData =
      LichTrucData(tenbophan: '', mabophanCha: '', nhom: 0);
  LichTrucController _conSchedule = LichTrucController();
  HienDienController _hienDienController = HienDienController();
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
  List<ChartData> _datachart = [];
  List<ChartData> _chart = [];

  ScrollController _scrollController = ScrollController();

  loadKhoa() async {
    try {
      var provider = Provider.of<KhoaProvider>(context, listen: false);
      if (provider.token == '') {
        await provider.getKhoa().then((_) async {
          await provider.getBenhNhan();
          _lstKhoa = provider.lstKhoa;
        });
      } else {
        _lstKhoa = provider.lstKhoa;
      }
      setState(() {
        _lstKhoa;
        if (_lstKhoa.length > 0) {
          _selectKhoa = _lstKhoa.first.makhoaphong;
        }
      });
      khoa = await localData.Shared_getKhoa();
      if (khoa == '' || khoa == null) {
        khoa = _lstKhoa.first.makhoaphong;
      }
      _selectKhoa = khoa;
    } catch (e) {}
  }

  loadThongKe() async {
    try {
      _thongKeData = await _hienDienController.getHienDien(_selectKhoa);
      setState(() {
        _thongKeData;
      });
      _thongKeData = await _hienDienController.getHienDien(_selectKhoa);
      setState(() {
        _thongKeData;
      });
      _datachart = [
        ChartData('BS điều trị', _thongKeData.bsDieutri),
        ChartData('HS ngoại trú', _thongKeData.hosoNgoaitru),
        ChartData('Bệnh nặng', _thongKeData.benhNang),
        ChartData('BHYT', _thongKeData.bhyt),
        ChartData('Thu phí', _thongKeData.thuphi),
        ChartData('Trẻ em', _thongKeData.treem),
        ChartData('BVSK', _thongKeData.bvsk),
        ChartData('Miễn phí', _thongKeData.mienphi),
      ];
      _chart.clear();
      for (var item in _datachart) {
        if (item.soLuong > 0) _chart.add(item);
      }
    } catch (e) {
      print(e);
    }
  }

  loadLichTruc() async {
    _scheduleData = await _conSchedule.getLichTruc(_selectKhoa);
    setState(() {
      _lstBacSi.clear();
      _lstDieuDuong.clear();
      _lstHoLy.clear();
      if (_scheduleData.bacsi != null) {
        _lstBacSi = _scheduleData.bacsi!.split(';');
      }

      if (_scheduleData.holy != null) {
        _lstHoLy = _scheduleData.holy!.split(';');
      }
      if (_scheduleData.dieuduong != null) {
        _lstDieuDuong = _scheduleData.dieuduong!.split(';');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadKhoa().then((value) => scrollToSelectedIndex());
    loadThongKe();
    loadLichTruc();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screen(context).height,
          constraints: BoxConstraints(minHeight: 1000),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  "CHỌN KHOA LÀM VIỆC",
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                height: 120,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    children: _lstKhoa.map(_cardDepartmentItem).toList(),
                  ),
                ),
              ),
              ThongKe_Container(
                thongKeData: _thongKeData,
                chart: _chart,
                datachart: _datachart,
              ),
              LichTruc_Container(
                  lstBacSi: _lstBacSi,
                  lstDieuDuong: _lstDieuDuong,
                  lstHoLy: _lstHoLy),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardDepartmentItem(dataKhuPhongKhoa data) => Container(
        height: 90,
        margin: EdgeInsets.only(bottom: 25),
        child: Stack(
          children: [
            Card(
              elevation: _selectKhoa == data.makhoaphong ? 18 : .5,
              shadowColor: Theme.of(context).bannerTheme.shadowColor,
              color: _selectKhoa == data.makhoaphong ? primaryColor : null,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: InkWell(
                onTap: () async {
                  _selectKhoa = data.makhoaphong;
                  setState(() {
                    _selectKhoa;
                  });
                  loadThongKe();
                  loadLichTruc();

                  await localData.Shared_saveKhoa(_selectKhoa);
                  var _khoaProvider =
                      Provider.of<KhoaProvider>(context, listen: false);
                  _khoaProvider.updateKhoa(_selectKhoa);
                  _khoaProvider.getBenhNhan();
                  scrollToSelectedIndex();
                },
                child: Badge(
                  largeSize: 20,
                  offset: Offset(-10, -1),
                  backgroundColor: Colors.transparent,
                  label: _selectKhoa == data.makhoaphong
                      ? Icon(
                          Icons.abc,
                          size: 20,
                          color: Theme.of(context).canvasColor,
                        )
                      : null,
                  child: Container(
                    width: 150,
                    decoration: _selectKhoa == data.makhoaphong
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/backgrounds/drawer.jpg"),
                                fit: BoxFit.fill,
                                opacity: .5,
                                colorFilter: ColorFilter.mode(
                                    primaryColor, BlendMode.color)),
                          )
                        : BoxDecoration(),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.tenkhoaphong,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: _selectKhoa == data.makhoaphong
                                ? Colors.white
                                : primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  void scrollToSelectedIndex() async {
    try {
      int viTri = timViTriKhoa(_lstKhoa, _selectKhoa);
      final double itemWidth = 160;
      _scrollController.animateTo(
        viTri * itemWidth,
        duration: Duration(milliseconds: 700),
        curve: Curves.easeIn,
      );
    } catch (e) {}
  }
}

class Khoa {
  final String maKhoa;
  final String tenKhoa;
  Khoa(
    this.maKhoa,
    this.tenKhoa,
  );
}

int timViTriKhoa(List<dataKhuPhongKhoa> danhSachKhoa, String makhoaCanTim) {
  for (int i = 0; i < danhSachKhoa.length; i++) {
    if (danhSachKhoa[i].makhoaphong == makhoaCanTim) {
      return i; // Trả về vị trí nếu tìm thấy
    }
  }
  return 1;
}
