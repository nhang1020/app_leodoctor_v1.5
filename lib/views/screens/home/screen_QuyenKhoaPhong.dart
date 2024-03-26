import 'package:app_leohis/controllers/QuyenKhoaPhongController.dart';
import 'package:app_leohis/models/quyenKhoaPhong.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/controllers/readQKPtoList.dart';

import 'package:flutter/material.dart';

class Screen_QuyenKhoaPhong extends StatefulWidget {
  const Screen_QuyenKhoaPhong({super.key});

  @override
  State<Screen_QuyenKhoaPhong> createState() => _Screen_QuyenKhoaPhongState();
}

class _Screen_QuyenKhoaPhongState extends State<Screen_QuyenKhoaPhong> {
  //String _username = '';
  List<DataQkp> lstQKP = [];
  List<dataKhuPhongKhoa> lstKhoa = [];
  List<dataKhuPhongKhoa> lstKhu = [];
  List<dataKhuPhongKhoa> lstPhong = [];
  int selectKhu = 0;
  int selectKhoa = 0;
  int selectPhong = 0;

  QuyenKhoaPhongController _conQuyenKhoaPhong = QuyenKhoaPhongController();

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  loadData() async {
    try {
      lstQKP = await _conQuyenKhoaPhong.getQuyenKhoaPhong();

      setState(() {
        lstQKP;
        lstKhu = readQKPtoList(data: lstQKP).readToListKhu();
        lstPhong = readQKPtoList(data: lstQKP).readToListPhong();
        lstKhoa = readQKPtoList(data: lstQKP).readToListKhoa();
      });
    } catch (e) {
      showMessage(context, message: "Lỗi kết nối", type: "error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            buildLocation(),
          ],
        ),
      ),
    );
  }

  buildLocation() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Vị trí làm việc",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
              ),
              SizedBox(height: 10),
              PositionRow(
                title: "Khoa:",
                name: lstKhoa.isNotEmpty
                    ? Text(lstKhoa[selectKhoa].tenkhoaphong)
                    : LoadingIcon(),
              ),
              PositionRow(title: "Trưởng khoa: ", name: Text('--')),
              PositionRow(
                title: "Khu:",
                name: lstKhu.isNotEmpty
                    ? Text(lstKhu[selectKhu].tenkhoaphong)
                    : LoadingIcon(),
              ),
              PositionRow(
                title: "Phòng:",
                name: lstPhong.isNotEmpty
                    ? Text(lstPhong[selectPhong].tenkhoaphong)
                    : LoadingIcon(),
              ),
              PositionRow(title: "Số giường KH:", name: Text('--')),
              PositionRow(title: "Số giường TT:", name: Text('--')),
              ElevatedButton(
                onPressed: () => showChooseLocation(),
                child: Text(
                  "Chọn vị trí làm việc",
                  style: TextStyle(color: themeModeColor),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.resolveWith((states) => 5),
                  shadowColor: MaterialStateColor.resolveWith(
                      (states) => primaryColor.withOpacity(0.4)),
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => primaryColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  buildTimeWork() {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              "Lịch làm việc",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  showChooseLocation() {
    return showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(),
            height: 350,
            child: ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.change_circle,
                      color: primaryColor,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Khoa: '),
                        Text(lstKhoa.isEmpty
                            ? '--'
                            : lstKhoa[selectKhoa].tenkhoaphong)
                      ],
                    ),
                    onTap: () {
                      buildListView(lstKhoa, 1);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.change_circle,
                      color: primaryColor,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Khu: '),
                        Text(lstKhu.isEmpty
                            ? '--'
                            : lstKhu[selectKhu].tenkhoaphong)
                      ],
                    ),
                    onTap: () {
                      buildListView(lstKhu, 2);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    leading: Icon(
                      Icons.change_circle,
                      color: primaryColor,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Phòng: '),
                        Text(lstPhong.isEmpty
                            ? '--'
                            : lstPhong[selectPhong].tenkhoaphong)
                      ],
                    ),
                    onTap: () {
                      buildListView(lstPhong, 3);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  buildListView(List<dataKhuPhongKhoa> data, int loai) {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 350,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: primaryColor,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                trailing: const Icon(
                  Icons.add_task_sharp,
                  size: 16,
                  color: Colors.green,
                ),
                title: Text("${data[index].tenkhoaphong}"),
                onTap: () {
                  setState(() {
                    if (loai == 1) {
                      //khoa
                      selectKhoa = index;
                    } else if (loai == 2) {
                      //khu
                      selectKhu = index;
                    } else if (loai == 3) {
                      //phong
                      selectPhong = index;
                    }
                  });
                  Navigator.pop(context);
                  showChooseLocation();
                },
              );
            },
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class PositionRow extends StatelessWidget {
  PositionRow({
    super.key,
    required this.title,
    required this.name,
  });
  String title;
  Widget name;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          name,
        ],
      ),
    );
  }
}

class LoadingIcon extends StatelessWidget {
  const LoadingIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 15,
        height: 15,
        child: CircularProgressIndicator(
          strokeWidth: 3,
        ));
  }
}
