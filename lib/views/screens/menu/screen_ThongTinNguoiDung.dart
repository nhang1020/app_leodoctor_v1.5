import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/models/taiKhoan.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/screens/containBodyScreen.dart';
import 'package:app_leohis/views/screens/editAccountScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicons/unicons.dart';

class Screen_ThongTinNguoiDung extends StatefulWidget {
  const Screen_ThongTinNguoiDung({super.key});

  @override
  State<Screen_ThongTinNguoiDung> createState() =>
      _Screen_ThongTinNguoiDungState();
}

class _Screen_ThongTinNguoiDungState extends State<Screen_ThongTinNguoiDung> {
  LocalData _localData = LocalData();
  DataAccount? _account;
  loadData() async {
    _account = await _localData.Shared_getLocalDataAccount();
    setState(() {
      _account;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return _account == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_new),
                onPressed: () => Navigator.of(context).pop(),
              ),
              centerTitle: true,
              backgroundColor: themeModeColor,
              scrolledUnderElevation: 0.3,
              elevation: 0,
              shadowColor: Color.fromARGB(255, 254, 254, 254),
              iconTheme: IconThemeData(color: Colors.blueGrey),
              title: Text(
                "Thông tin tài khoản",
                style: TextStyle(color: Colors.blue),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                color: themeModeColor,
                height: screen(context).height,
                child: Column(
                  children: [
                    Container(
                      height: 160,
                      width: 500,
                      decoration: BoxDecoration(
                        color: themeModeColor,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Center(
                            child: Container(
                              alignment: Alignment.center,
                              height: 120,
                              width: 120,
                              margin: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: themeModeColor,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 7),
                                    blurRadius: 20,
                                    color: Color.fromARGB(255, 221, 224, 235),
                                  )
                                ],
                              ),
                              child: FaIcon(
                                FontAwesomeIcons.userDoctor,
                                size: 70,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            flex: 1,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _account!.tennguoidung,
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      // shadows: [
                                      //   BoxShadow(
                                      //     offset: Offset(2, 4),
                                      //     blurRadius: 10,
                                      //     color: Colors.black26,
                                      //   )
                                      // ],
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Icon(Icons.phone_android,
                                          size: 20, color: Colors.blue),
                                      SizedBox(width: 0),
                                      Text(
                                        " (+84) ${_account!.dienthoai}",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: Size(150, 40),
                                      elevation: 10,
                                      shadowColor:
                                          primaryColor.withOpacity(0.5),
                                      shape: StadiumBorder(),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ContainScreen(
                                                page: EditAccountScreen(),
                                                title:
                                                    "Sửa thông tin tài khoản"),
                                          ));
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Sửa thông tin"),
                                        SizedBox(width: 10),
                                        Icon(UniconsLine.file_edit_alt,
                                            size: 20),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Container(
                        // height: screen(context).height - 200,
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: themeModeColor,
                            boxShadow: [
                              BoxShadow(
                                // offset: Offset(0, 0),
                                blurRadius: 20,
                                color: Color.fromARGB(255, 221, 224, 235),
                              )
                            ]),

                        child: ListView(children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: themeModeColor,
                              child: Icon(
                                UniconsLine.user,
                                color: Colors.blue,
                              ),
                            ),
                            title: Text("Tên tài khoản"),
                            subtitle: Text(_account!.tendangnhap),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: themeModeColor,
                              child: Icon(
                                color: Colors.blue,
                                UniconsLine.toilet_paper,
                              ),
                            ),
                            title: Text("Họ tên "),
                            subtitle: Text(_account!.tennguoidung),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: themeModeColor,
                              child: Icon(
                                color: Colors.blue,
                                UniconsLine.calendar_alt,
                              ),
                            ),
                            title: Text("Ngày sinh"),
                            subtitle: Text(
                                '${_account!.ngaysinh.day}/${_account!.ngaysinh.month}/${_account!.ngaysinh.year}'),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: themeModeColor,
                              child: Icon(
                                  color: Colors.blue,
                                  _account!.gioitinh == "Nam"
                                      ? UniconsLine.mars
                                      : UniconsLine.venus),
                            ),
                            title: Text("Giới tính"),
                            subtitle: Text(_account!.gioitinh),
                          ),
                          Divider(height: 0),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: themeModeColor,
                              child: Icon(
                                color: Colors.blue,
                                UniconsLine.at,
                              ),
                            ),
                            title: Text("Email"),
                            subtitle: Text("leodevcode@gmail.com"),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: themeModeColor,
                              child: Icon(
                                color: Colors.blue,
                                UniconsLine.newspaper,
                              ),
                            ),
                            title: Text("Giấy phép hành nghề"),
                            subtitle: Text("Xem..."),
                          ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: themeModeColor,
                              child: Icon(
                                color: Colors.blue,
                                UniconsLine.code_branch,
                              ),
                            ),
                            title: Text("Trình độ"),
                            subtitle: Text("..."),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
