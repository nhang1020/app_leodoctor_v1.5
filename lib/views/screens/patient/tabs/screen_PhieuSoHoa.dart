import 'dart:convert';
import 'dart:typed_data';
import 'package:app_leohis/controllers/PhieuSoHoaController.dart';
import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/screens/containBodyScreen.dart';
import 'package:app_leohis/views/components/dropDown.dart';
import 'package:app_leohis/views/screens/patient/details/widgets/webViewPage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:unicons/unicons.dart';
import '../../../../models/phieuSoHoa.dart';
import '../../../utils/contants.dart';
import '../details/widgets/line_TenChucNang.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Screen_PhieuSoHoa extends StatefulWidget {
  BenhNhanData patient;
  Screen_PhieuSoHoa({super.key, required this.patient});

  @override
  State<Screen_PhieuSoHoa> createState() => _Screen_PhieuSoHoaState();
}

class _Screen_PhieuSoHoaState extends State<Screen_PhieuSoHoa>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<PhieuSoHoaData> _lstPhieuSo = [];
  PhieuSoHoaController _soHoaController = PhieuSoHoaController();
  bool loading = false;
  String? selectedLoai;
  ImagePicker _picker = ImagePicker();
  String base64string = '';
  UpPhieuSoHoa _upPhieuSoHoa =
      UpPhieuSoHoa(mahs: '', mabn: '', idEmr: '', fileName: '', base64: '');
  OutUpPhieuSoHoaData outputPSH =
      OutUpPhieuSoHoaData(idPhieu: '', tenphieu: '', urlHtml: '');

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      for (var item in _lstPhieuSo)
        DropdownMenuItem(
            child: Text(
              "${item.tenphieu}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            value: "${item.idEmr}"),
    ];
    return menuItems;
  }

  loadData() async {
    setState(() {
      loading = true;
    });
    try {
      _lstPhieuSo = await _soHoaController.getPhieuSoHoa();
      setState(() {
        _lstPhieuSo;
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

  Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.cover,
    );
  }

  UpPhieuSoHoa initUpPhieuSoHoa() {
    return UpPhieuSoHoa(
        mahs: widget.patient.mahs,
        mabn: widget.patient.mabn,
        idEmr: '',
        fileName: '',
        base64: '');
  }

  bool checkDataUPload() {
    if (_upPhieuSoHoa.mahs != '' &&
        _upPhieuSoHoa.mabn != '' &&
        _upPhieuSoHoa.idEmr != '' &&
        _upPhieuSoHoa.fileName != '' &&
        _upPhieuSoHoa.base64 != '') {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    _upPhieuSoHoa = initUpPhieuSoHoa();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        Line_TitleName(name: 'Phiếu số hóa'),
        Card(
          margin: const EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: primaryColor),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topCard(),
                bottomCard(),
              ],
            ),
          ),
        ),
        menuOption(),
      ],
    );
  }

  Widget topCard() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Loại: ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${selectedLoai ?? '(Chưa chọn loại phiếu)'}',
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Text(
                          "Chọn ảnh:  ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${_upPhieuSoHoa.fileName == '' ? '(Chưa chọn ảnh)' : checkString(_upPhieuSoHoa.fileName)}',
                          ),
                        ),
                      ],
                    )),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1, color: Colors.grey)),
                child: base64string == ''
                    ? Icon(Icons.image, color: primaryColor)
                    : imageFromBase64String(base64string),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyButton(
                icon: Icon(UniconsLine.image_upload,
                    color: Theme.of(context).cardColor),
                label: "Đăng ảnh",
                onPressed: () async {
                  OutUpPhieuSoHoaData output =
                      await _soHoaController.uploadPhieuSoHoa(_upPhieuSoHoa);
                  setState(() {
                    outputPSH = output;
                  });
                },
                enabled: checkDataUPload(),
              )
            ],
          ),
        ],
      ),
    );
  }

  bottomCard() {
    return outputPSH.idPhieu == '' &&
            outputPSH.tenphieu == '' &&
            outputPSH.urlHtml == ''
        ? Container()
        : Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: primaryColor, thickness: 2),
                Card(
                  child: ListTile(
                    horizontalTitleGap: 0,
                    leading: Icon(Icons.check_circle,
                        color: Color.fromARGB(255, 25, 162, 82)),
                    title: Text(
                      'Đăng phiếu số hóa thành công.',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 25, 162, 82)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Tên phiếu: ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${checkString(outputPSH.tenphieu)}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          size: 20,
                          color: themeModeColor,
                        ),
                        label: "Xem kết quả",
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: ContainScreen(
                                    page: WebView_Page(
                                      url: outputPSH.urlHtml,
                                    ),
                                    title: "Xem phiếu số hóa",
                                  ),
                                  type: PageTransitionType.rightToLeft));
                        }),
                  ],
                )
              ],
            ),
          );
  }

  Widget menuOption() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chọn loại phiếu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: MyDropdown(
                items: dropdownItems,
                onChanged: (value) {
                  setState(() {
                    selectedLoai = value!;
                    _upPhieuSoHoa.idEmr = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chọn ảnh',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      try {
                        final XFile? image =
                            await _picker.pickImage(source: ImageSource.camera);

                        if (image != null) {
                          Uint8List imagebytes =
                              await image.readAsBytes(); //convert to bytes
                          String string64 = base64.encode(imagebytes);
                          setState(() {
                            base64string = string64;
                            _upPhieuSoHoa.fileName = image.name;
                            _upPhieuSoHoa.base64 = base64string;
                          });
                        }
                      } catch (e) {
                        showMessage(context,
                            message: "Thiết bị không hỗ trợ", type: "error");
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: primaryColor),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera,
                            color: primaryColor,
                            size: 22,
                          ),
                          Text(
                            'Chụp ảnh',
                            style: TextStyle(fontSize: 18, color: primaryColor),
                          )
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);

                      if (image != null) {
                        Uint8List imagebytes =
                            await image.readAsBytes(); //convert to bytes
                        String string64 = base64.encode(imagebytes);
                        setState(() {
                          base64string = string64;
                          _upPhieuSoHoa.fileName = image.name;
                          _upPhieuSoHoa.base64 = base64string;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: primaryColor),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            color: primaryColor,
                            size: 22,
                          ),
                          Text(
                            'Chọn ảnh',
                            style: TextStyle(fontSize: 18, color: primaryColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget viewPhieuSoHoa(PhieuSoHoaData data, int index) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.all(2),
      width: isSmallScreen(context)
          ? screen(context).width
          : screen(context).width / 2 - 5,
      child: InkWell(
        onTap: () {
          // showDetail(data);
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: themeModeColor,
            boxShadow: [],
          ),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.code, color: Colors.blue, size: 20),
                title: Text(
                  "ID erm: ${checkString(data.idEmr)}",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ListTile(
                leading:
                    Icon(Icons.article_outlined, color: Colors.blue, size: 17),
                title: Text(
                  "Tên phiếu: ${checkString(data.tenphieu)}",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
