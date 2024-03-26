import 'package:app_leohis/models/quyenKhoaPhong.dart';
import 'package:flutter/material.dart';

class readQKPtoList {
  List<DataQkp> data;
  readQKPtoList({required this.data});

  List<dataKhuPhongKhoa> _lstKhoa = [];
  List<dataKhuPhongKhoa> _lstKhu = [];
  List<dataKhuPhongKhoa> _lstPhong = [];

  List<dataKhuPhongKhoa> readToListPhong() {
    data.forEach(
      (index) {
        if (index.loai.toString() == 'PHONG') {
          dataKhuPhongKhoa temp = dataKhuPhongKhoa(
              makhoaphong: index.makhoaphong,
              tenkhoaphong: index.tenkhoaphong,
              thutu: index.thutu);
          _lstPhong.add(temp);
        }
      },
    );
    return _lstPhong;
  }

  List<dataKhuPhongKhoa> readToListKhoa() {
    data.forEach(
      (index) {
        if (index.loai.toString() == 'KHOA') {
          dataKhuPhongKhoa temp = dataKhuPhongKhoa(
              makhoaphong: index.makhoaphong,
              tenkhoaphong: index.tenkhoaphong,
              thutu: index.thutu);
          _lstKhoa.add(temp);
        }
      },
    );
    return _lstKhoa;
  }

  List<dataKhuPhongKhoa> readToListKhu() {
    data.forEach(
      (index) {
        if (index.loai.toString() == 'KHU') {
          dataKhuPhongKhoa temp = dataKhuPhongKhoa(
              makhoaphong: index.makhoaphong,
              tenkhoaphong: index.tenkhoaphong,
              thutu: index.thutu);
          _lstKhu.add(temp);
        }
      },
    );
    return _lstKhu;
  }

  buildListView(BuildContext context, List<dataKhuPhongKhoa> data) {
    return showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                trailing: const Icon(
                  Icons.search,
                  size: 16,
                  color: Colors.green,
                ),
                title: Text("${data[index].tenkhoaphong}"),
              );
            },
          ),
        );
      },
    );
  }
}

class dataKhuPhongKhoa {
  dynamic makhoaphong;
  dynamic tenkhoaphong;
  dynamic thutu;
  dataKhuPhongKhoa({
    required this.makhoaphong,
    required this.tenkhoaphong,
    required this.thutu,
  });
}
