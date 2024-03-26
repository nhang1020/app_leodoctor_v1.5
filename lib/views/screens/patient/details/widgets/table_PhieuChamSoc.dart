import 'package:app_leohis/controllers/PhieuChamSocController.dart';
import 'package:app_leohis/controllers/SoTayGoTatController.dart';
import 'package:app_leohis/models/phieuChamSoc.dart';
import 'package:app_leohis/models/soTayGotat.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/components/rowData.dart';
import 'package:app_leohis/views/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unicons/unicons.dart';
import '../../../../../models/BenhNhan.dart';
import '../../../../components/speechDialog.dart';
import '../../../../utils/contants.dart';

// ignore: must_be_immutable
class Table_PhieuChamSoc extends StatefulWidget {
  BenhNhanData patient;
  String maPhieu;
  PhieuChamSocData? pcs;
  Table_PhieuChamSoc({
    super.key,
    required this.patient,
    required this.maPhieu,
    this.pcs,
  });

  @override
  State<Table_PhieuChamSoc> createState() => _Table_PhieuChamSocState();
}

class _Table_PhieuChamSocState extends State<Table_PhieuChamSoc> {
  final _dienBien = TextEditingController();
  final _yLenh = TextEditingController();
  bool isDienBien = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  PhieuChamSocController _chamSocController = PhieuChamSocController();
  OutputPhieuChamSoc _output = OutputPhieuChamSoc(success: false, message: '');

  LuuPhieuChamSoc _phieuChamSoc = LuuPhieuChamSoc(
      mahs: '',
      mabn: '',
      manhapvien: '',
      manamvien: '',
      makhoa: '',
      maphong: '',
      chandoanicd: '',
      chandoan: '',
      maphieu: '',
      ngaylap: DateTime.now(),
      dienbien: '',
      ylenh: '');
  List<SoTayGoTatData> _sotay = [];
  SoTayGoTatController _soTayGoTatController = SoTayGoTatController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      locale: Locale('vi', 'VN'),
      context: context,
      initialDate: selectedDate,
      firstDate: widget.patient.ngayvaovien,
      lastDate: DateTime.now().add(Duration(days: 1)),
      confirmText: 'Chọn',
      cancelText: 'Hủy',
      errorInvalidText: 'Chọn ngày không hợp lệ',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
              // This uses the _timePickerTheme defined above
              // timePickerTheme: _timePickerTheme,
              datePickerTheme: DatePickerThemeData()),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      helpText: 'Chọn giờ đo',
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
      confirmText: 'Chọn',
      cancelText: 'Hủy',
      errorInvalidText: 'Chọn sai định dạng thời gian',
      hourLabelText: 'giờ',
      minuteLabelText: 'phút',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: timePickerThemeData(context),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  String getChanDoan() {
    return '${widget.patient.chandoanTaikhoa ?? ''}(${widget.patient.icdTaikhoa ?? ''}), ${widget.patient.chandoanphuTaikhoa ?? ''}';
  }

  initPhieuChamSoc(PhieuChamSocData? data) {
    DateTime now = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectedTime.hour, selectedTime.minute);
    String chanDoan = getChanDoan();
    _phieuChamSoc = LuuPhieuChamSoc(
      mahs: widget.patient.mahs,
      mabn: widget.patient.mabn,
      manhapvien: widget.patient.manhapvien,
      manamvien: widget.patient.manamvien,
      makhoa: widget.patient.makhoa,
      maphong: widget.patient.maphong,
      chandoanicd: widget.patient.icdTaikhoa,
      chandoan: chanDoan,
      maphieu: widget.maPhieu,
      ngaylap: now,
      dienbien: data == null ? '' : data.dienbien,
      ylenh: data == null ? '' : data.ylenh,
    );
    _dienBien.text = _phieuChamSoc.dienbien ?? '';
    _yLenh.text = _phieuChamSoc.ylenh ?? '';
  }

  LuuPhieuChamSoc getPhieuChamSoc(String? maphieu) {
    DateTime now = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectedTime.hour, selectedTime.minute);
    String chanDoan = getChanDoan();

    LuuPhieuChamSoc newphieuCS = LuuPhieuChamSoc(
      mahs: widget.patient.mahs,
      mabn: widget.patient.mabn,
      manhapvien: widget.patient.manhapvien,
      manamvien: widget.patient.manamvien,
      makhoa: widget.patient.makhoa,
      maphong: widget.patient.maphong,
      chandoanicd: widget.patient.icdTaikhoa,
      chandoan: chanDoan,
      maphieu: maphieu,
      ngaylap: now,
      dienbien: _dienBien.text,
      ylenh: _yLenh.text,
    );
    return newphieuCS;
  }

  getSotayGoTat() async {
    try {
      _sotay = await _soTayGoTatController.getSoTayGoTat();

      setState(() {
        _sotay;
      });
    } catch (e) {}
    return true;
  }

  String getNoiDungGoTat(String text) {
    String noidung = '';
    for (var item in _sotay) {
      if (item.tugotat == text) {
        noidung = item.noidung;
      }
    }
    return noidung;
  }

  String GoTat(String str) {
    var arr_str = str.split(' ');

    if (arr_str.last != '') {
      var nd = getNoiDungGoTat(arr_str.last);
      if (arr_str.last.indexOf('\n') != -1) {
        var arr = arr_str.last.split('\n');
        nd = getNoiDungGoTat(arr.last);
        if (nd != '') {
          arr.last = nd;
          String last = arr.join('\n');
          arr_str.removeLast();
          arr_str.add(last);
        }
      } else {
        if (nd != '') {
          arr_str.last = nd;
        }
      }
      str = arr_str.join(' ');
    }
    return str;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPhieuChamSoc(widget.pcs);
    getSotayGoTat();
  }

  String textVoice = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          // elevation: 0,
          content: Container(
            padding: EdgeInsets.all(20),
            constraints: BoxConstraints(minWidth: 500),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    // width: screen.width,
                    height: 50,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 20,
                          color: Colors.black12,
                        ),
                      ],
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.elliptical(70, 80),
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "PHIẾU CHĂM SÓC",
                          style: TextStyle(
                              color: Theme.of(context).cardColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          UniconsLine.heart,
                          color: Theme.of(context).cardColor,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(width: 100, child: Text("Thời gian")),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                formatDate(selectedDate),
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () {
                              _selectTime(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // RowData(
                  //     'ICD: ', 14, checkString(widget.patient.icdTaikhoa), 16),
                  RowData('Chẩn đoán: ', 14, checkString(getChanDoan()), 15),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Diễn biến: '),
                        IconButton(
                          onPressed: () async {
                            final result = await showDialog(
                              context: context,
                              builder: (context) => SpeechDialog(),
                            );
                            if (result != null) {
                              setState(() {
                                _dienBien.text += result;
                              });
                            }
                          },
                          icon: Icon(Icons.mic, color: primaryColor),
                        )
                      ],
                    ),
                  ),
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: screen(context).width - 100),
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      autofocus: true,
                      onKey: (event) {
                        if (event.isKeyPressed(LogicalKeyboardKey.space)) {
                          String text = GoTat(_dienBien.text);
                          setState(() {
                            _dienBien.text = text;
                          });
                        }
                      },
                      child: TextFormField(
                        controller: _dienBien,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            setState(() {
                              isDienBien = true;
                            });
                            return 'Diễn biến trống';
                          }
                          setState(() {
                            isDienBien = false;
                          });
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Y lệnh: '),
                        IconButton(
                          onPressed: () async {
                            final result = await showDialog(
                              context: context,
                              builder: (context) => SpeechDialog(),
                            );
                            if (result != null) {
                              setState(() {
                                _yLenh.text = result;
                              });
                            }
                          },
                          icon: Icon(Icons.mic, color: primaryColor),
                        )
                      ],
                    ),
                  ),
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: screen(context).width - 100),
                    child: RawKeyboardListener(
                      focusNode: FocusNode(),
                      autofocus: true,
                      onKey: (event) {
                        if (event.isKeyPressed(LogicalKeyboardKey.space)) {
                          String text = GoTat(_yLenh.text);
                          setState(() {
                            _yLenh.text = text;
                          });
                        }
                      },
                      child: TextFormField(
                        controller: _yLenh,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                        keyboardType: TextInputType.multiline,
                        minLines: 3,
                        maxLines: 5,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      MyButton(
                        width: 100,
                        label: "Mới",

                        onPressed: () {
                          _dienBien.clear();
                          _yLenh.clear();
                          selectedDate = DateTime.now();
                          selectedTime = TimeOfDay.now();
                          _phieuChamSoc = getPhieuChamSoc('');
                          setState(() {
                            _phieuChamSoc;
                          });
                        },
                        // kiểm tra > hơn ngày vào viện
                        subfixIcon: Icon(UniconsLine.plus_circle,
                            color: Theme.of(context).cardColor),
                      ),
                      SizedBox(width: 10),
                      MyButton(
                        width: 100,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        label: "Hủy",
                        color: primaryColor.withOpacity(.1),
                        textColor: primaryColor,
                        subfixIcon:
                            Icon(UniconsLine.cancel, color: primaryColor),
                      ),
                      SizedBox(width: 10),
                      MyButton(
                        width: 100,
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            _phieuChamSoc = getPhieuChamSoc(widget.maPhieu);

                            _output =
                                await _chamSocController.post_PhieuChamSoc(
                                    _phieuChamSoc, widget.maPhieu);

                            // Notifications(
                            //         body: 'Hệ thống',
                            //         title:
                            //             'Bạn vừa thêm mới phiếu chăm sóc thành công.')
                            //     .Nomal();

                            Navigator.pop(context, 1);
                            _output.success == true
                                ? showMessage(context,
                                    message: '${_output.message}',
                                    type: "success")
                                : showMessage(context,
                                    message: '${_output.message}',
                                    type: "error");
                          }
                        },
                        subfixIcon: Icon(UniconsLine.save,
                            color: Theme.of(context).cardColor),
                        label: "Lưu",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
