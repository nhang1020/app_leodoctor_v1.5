import 'package:app_leohis/controllers/LocalData.dart';
import 'package:app_leohis/controllers/SinhHieuController.dart';
import 'package:app_leohis/models/BenhNhan.dart';
import 'package:app_leohis/models/sinhHieu.dart';
import 'package:app_leohis/views/components/button.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

// ignore: must_be_immutable
class Table_DoSinhHieu extends StatefulWidget {
  Table_DoSinhHieu(
      {super.key, required this.patient, this.mash, this.sinhHieu});
  BenhNhanData patient;
  SinhHieuData? sinhHieu;
  String? mash;
  @override
  State<Table_DoSinhHieu> createState() => _Table_DoSinhHieuState();
}

class _Table_DoSinhHieuState extends State<Table_DoSinhHieu> {
  SinhHieuController _sinhHieuController = SinhHieuController();
  TextEditingController _mach = TextEditingController();
  TextEditingController _huyetAp1 = TextEditingController();
  TextEditingController _huyetAp2 = TextEditingController();
  TextEditingController _huyetApXL = TextEditingController();
  TextEditingController _nhietDo = TextEditingController();
  TextEditingController _nhipTho = TextEditingController();
  TextEditingController _spo2 = TextEditingController();
  TextEditingController _luongNuocTieu = TextEditingController();
  TextEditingController _luongPhan = TextEditingController();
  String selectedHA = "hat";
  bool quyenBacSi = true;
  bool Haxl = false;
  LuuSinhHieu _luuSinhHieu = LuuSinhHieu(
    mahs: '',
    mabn: '',
    manhapvien: '',
    makhoa: '',
    makhu: '',
    maphong: '',
    mash: '',
    ngaydo: DateTime.now(),
  );

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      locale: Locale('vi', 'VN'),
      context: context,
      initialDate: selectedDate,
      firstDate: widget.patient.ngayvaovien,
      lastDate: DateTime.now().add(Duration(days: 1)),
      helpText: "Chọn ngày đo",
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

  initSinhHieu(String? mash, SinhHieuData? data) {
    DateTime now = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectedTime.hour, selectedTime.minute);
    _luuSinhHieu = LuuSinhHieu(
      mahs: widget.patient.mahs,
      mabn: widget.patient.mabn,
      manhapvien: widget.patient.manhapvien,
      makhoa: widget.patient.makhoa,
      makhu: widget.patient.makhu == null ? '' : widget.patient.makhu,
      maphong: widget.patient.maphong,
      mash: mash == null ? '' : mash,
      ngaydo: now,
      mach: data == null ? '' : data.mach,
      huyetap1: data == null ? '' : data.huyetap1,
      huyetap2: data == null ? '' : data.huyetap2,
      nhietdo: data == null ? '' : data.nhietdo,
      nhiptho: data == null ? '' : data.nhiptho,
      spo2: data == null ? '' : data.spo2,
      luongnuoctieu: data == null ? '' : data.luongnuoctieu,
      luongphan: data == null ? '' : data.luongphan,
    );
    _huyetAp1.text = _luuSinhHieu.huyetap1 ?? '';
    _huyetAp2.text = _luuSinhHieu.huyetap2 ?? '';
    _nhipTho.text = _luuSinhHieu.nhiptho ?? '';
    _nhietDo.text = _luuSinhHieu.nhietdo ?? '';
    _spo2.text = _luuSinhHieu.spo2 ?? '';
    _luongNuocTieu.text = _luuSinhHieu.luongnuoctieu ?? '';
    _luongPhan.text = _luuSinhHieu.luongphan ?? '';
    _mach.text = _luuSinhHieu.mach ?? '';
  }

  LuuSinhHieu getSinhHieu(String? mash) {
    DateTime now = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectedTime.hour, selectedTime.minute);
    LuuSinhHieu sinhHieuMoi = LuuSinhHieu(
      mahs: widget.patient.mahs,
      mabn: widget.patient.mabn,
      manhapvien: widget.patient.manhapvien,
      makhoa: widget.patient.makhoa,
      makhu: widget.patient.makhu ?? '1',
      maphong: widget.patient.maphong,
      mash: mash == null ? '' : mash,
      ngaydo: now,
      mach: _mach.text,
      huyetap1: _huyetAp1.text,
      huyetap2: _huyetAp2.text,
      haXamlan: _huyetApXL.text == '' ? '0' : _huyetApXL.text,
      nhietdo: _nhietDo.text,
      nhiptho: _nhipTho.text,
      spo2: _spo2.text,
      luongnuoctieu: _luongNuocTieu.text,
      luongphan: _luongPhan.text,
    );
    return sinhHieuMoi;
  }

  getQuyenBacSi() async {
    LocalData localData = LocalData();
    quyenBacSi = await localData.Shared_getQuyenBacSi();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSinhHieu(widget.mash, widget.sinhHieu);
    getQuyenBacSi();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            // elevation: 0,
            content: Container(
              width: 400,
              height: 650,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    margin: EdgeInsets.only(bottom: 20),
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(70, 80),
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    )),
                    child: Container(
                      alignment: Alignment.center,
                      // width: screen.width,
                      height: 50,

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ĐO SINH HIỆU",
                            style: TextStyle(
                                color: Theme.of(context).cardColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            UniconsLine.stethoscope_alt,
                            color: Theme.of(context).cardColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
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
                  RowField(textField: _mach, title: "Mạch", unit: "lần/phút"),
                  Row(
                    children: [
                      Container(width: 120, child: Text('Huyết áp')),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: _huyetAp1,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.w500),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      Text(" / "),
                      Container(
                        child: Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: _huyetAp2,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w500),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          width: 60,
                          child: Text(
                            "mmHg",
                            style: TextStyle(fontSize: 13, color: primaryColor),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 150,
                            child: Row(
                              children: [
                                Text('HA xâm lấn'),
                                Checkbox(
                                  checkColor: primaryColor,
                                  activeColor: Colors.transparent,
                                  value: Haxl,
                                  onChanged: (value) {
                                    setState(() {
                                      Haxl = !Haxl;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Expanded(
                          flex: 1,
                          child: Haxl == true
                              ? TextFormField(
                                  controller: _huyetApXL,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                )
                              : Container(),
                        ),
                      ),
                      Container(
                        width: 60,
                        child: Haxl == true
                            ? Text(
                                "mmHg",
                                style: TextStyle(
                                    fontSize: 13, color: primaryColor),
                              )
                            : Text(''),
                      ),
                    ],
                  ),
                  RowField(textField: _nhietDo, title: "Nhiệt độ", unit: "°C"),
                  RowField(
                      textField: _nhipTho, title: "Nhịp thở", unit: "lần/phút"),
                  RowField(textField: _spo2, title: "SPO₂", unit: "%"),
                  RowField(
                      textField: _luongNuocTieu,
                      title: "Lượng n.tiểu",
                      unit: ""),
                  RowField(
                      textField: _luongPhan, title: "Lượng phân", unit: ""),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: MyButton(
                          onPressed: () {
                            _huyetAp1.clear();
                            _huyetAp2.clear();
                            _nhipTho.clear();
                            _nhietDo.clear();
                            _spo2.clear();
                            _luongNuocTieu.clear();
                            _luongPhan.clear();
                            _mach.clear();
                            selectedDate = DateTime.now();
                            selectedTime = TimeOfDay.now();
                            _luuSinhHieu = getSinhHieu(widget.mash);
                            setState(() {
                              _luuSinhHieu;
                            });
                          },
                          // kiểm tra > hơn ngày vào viện
                          label: "Mới",
                          icon: Icon(Icons.add_circle_outline,
                              color: Theme.of(context).cardColor),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: MyButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          label: "Hủy",
                          color: primaryColor.withOpacity(.1),
                          textColor: primaryColor,
                          icon: Icon(UniconsLine.cancel, color: primaryColor),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: MyButton(
                          onPressed: () async {
                            if (quyenBacSi == true) {
                              showMessage(context,
                                  message:
                                      'Tài khoản bác sĩ không thể lưu sinh hiệu.',
                                  type: "error");
                            } else {
                              _luuSinhHieu = getSinhHieu(widget.mash);
                              setState(() {
                                _luuSinhHieu;
                              });

                              PostSinhHieu post = await _sinhHieuController
                                  .post_SinhHieu(_luuSinhHieu);
                              print(_luuSinhHieu.toJson());
                              Navigator.pop(context, 1);

                              post.success == true
                                  ? showMessage(context,
                                      message: '${post.message}',
                                      type: "success")
                                  : showMessage(context,
                                      message: '${post.message}',
                                      type: "warning");
                            }
                          },
                          label: "Lưu lại",
                          icon: Icon(Icons.save,
                              color: Theme.of(context).cardColor),
                        ),
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

// ignore: must_be_immutable
class RowField extends StatelessWidget {
  RowField({
    super.key,
    required this.textField,
    required this.title,
    required this.unit,
  });
  String title;
  TextEditingController textField;
  String unit;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(width: 120, child: Text(title)),
        Expanded(
          flex: 1,
          child: TextFormField(
            controller: textField,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        Container(
            width: 60,
            margin: EdgeInsets.only(left: 10),
            child: Text(
              unit,
              style: TextStyle(fontSize: 13, color: primaryColor),
            )),
      ],
    );
  }
}
