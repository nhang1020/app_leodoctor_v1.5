import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_styled_toast/flutter_styled_toast.dart';

/* contants function */
//Gap SizedBox
class Contants {
  Widget gap(double? height, double? width) =>
      SizedBox(height: height, width: width);
  Widget gapY(double? height) => SizedBox(height: height);
  Widget gapX(double? width) => SizedBox(width: width);
}

/* contants variable */

//Default color
Future<int> getTheme() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? indexTheme = prefs.getInt('theme') ?? 0;

  primaryColor = lightThemes[indexTheme];
  return indexTheme;
}

Color primaryColor = Color(0xff2d70e2);
// Color themeModeColor = Color(0xff0b1328);
Color themeModeColor = Colors.white;
List<Color> lightThemes = [
  Color(0xff2d70e2),
  Color.fromARGB(255, 201, 163, 113),
  Colors.teal,
  Colors.pink.shade300,
  Color(0xFF674AEF),
];
List<Color> darkThemes = [
  Color.fromARGB(255, 122, 196, 252),
  Color.fromARGB(255, 218, 183, 136),
  Colors.tealAccent.shade400,
  Colors.pink.shade200,
  Color.fromARGB(255, 249, 238, 110),
];

List<Color> colorsList = [
  Color.fromARGB(255, 169, 200, 255),
  const Color.fromARGB(255, 255, 206, 133),
  const Color.fromARGB(255, 103, 224, 212),
  const Color.fromARGB(255, 251, 184, 206),
  Color.fromARGB(255, 180, 164, 252),
  const Color.fromARGB(255, 245, 252, 185),
  const Color.fromARGB(255, 156, 222, 159),
  const Color.fromARGB(255, 243, 178, 173),
  const Color.fromARGB(255, 243, 178, 173),
  const Color.fromARGB(255, 243, 178, 173),
];
//Default box(shadow
final boxShadows = [
  BoxShadow(color: Colors.transparent),
  BoxShadow(color: Colors.black54, spreadRadius: 2, blurRadius: 4),
  BoxShadow(
    offset: Offset(2, 4),
    blurRadius: 5,
    color: Colors.black.withOpacity(0.3),
  ),
  BoxShadow(
    offset: Offset(0, 10),
    blurRadius: 50,
    color: primaryColor.withOpacity(0.23),
  ),
  BoxShadow(
    offset: Offset(0, 10),
    blurRadius: 30,
    color: Colors.black.withOpacity(0.3),
  ),
  BoxShadow(
      color: Colors.black54.withOpacity(0.13),
      blurRadius: 30,
      offset: Offset(2, 15)),
  BoxShadow(
    blurRadius: 20,
    offset: Offset(0, 7),
    color: Color.fromARGB(255, 223, 234, 247),
  ),
  BoxShadow(
    blurRadius: 20,
    offset: Offset(0, 7),
    color: primaryColor.withOpacity(.2),
  ),
  BoxShadow(
      spreadRadius: 2, blurRadius: 3, color: Colors.black.withOpacity(.05))
];

void showMessage(BuildContext context,
    {String message = "",
    String type = "normal",
    StyledToastPosition position = StyledToastPosition.bottom}) {
  showToastWidget(
    position: position,
    Container(
      padding: EdgeInsets.only(top: 10, left: 10, bottom: 10, right: 15),
      constraints: BoxConstraints(maxWidth: 300),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline, color: Theme.of(context).cardColor),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "${message}",
              // textAlign: TextAlign.center,
              style:
                  TextStyle(color: Theme.of(context).cardColor, fontSize: 15),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "assets/images/backgrounds/notification.png",
            ),
            fit: BoxFit.cover,
            opacity: .2),
        borderRadius: BorderRadius.circular(10),
        color: type == "error"
            ? Colors.red.shade300
            : (type == "success"
                ? const Color.fromARGB(255, 25, 162, 82)
                : (type == "warning"
                    ? const Color.fromARGB(255, 198, 173, 44)
                    : primaryColor)),
      ),
    ),
    context: context,
    animation: StyledToastAnimation.fade,
    alignment: Alignment.topCenter,
    axis: Axis.horizontal,
    reverseAnimation: StyledToastAnimation.fade,
  );
}

formatTimeOfDay(TimeOfDay time) {
  return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}";
}

formatTime(DateTime? time) {
  String formattedTime = DateFormat('hh:mm a').format(time!);
  return formattedTime;
}

formatTimeNotAP(DateTime? time) {
  String formattedTime = DateFormat('hh:mm').format(time!);
  return formattedTime;
}

formatDate(DateTime? time) {
  String formatedDate = DateFormat('dd/MM/yyyy').format(time!);
  return formatedDate;
}

formatDateVi(DateTime? time) {
  return "${time!.day} tháng ${time.month}  ${time.year}";
}

formatDateVi2(DateTime? time) {
  return "${time!.day} thg ${time.month} ${time.year}";
}

String checkString(String? value) {
  return value == null || value == "" ? "--" : value;
}

Size screen(BuildContext context) {
  return MediaQuery.of(context).size;
}

bool isSmallScreen(BuildContext context) {
  return MediaQuery.of(context).copyWith().size.width < 720;
}

String checkGender(String gt) {
  return gt == '1' ? "Nam" : "Nữ";
}

String checkLoaiHoSo(String maloai) {
  return maloai == 'BH' ? "Bảo hiểm" : "Dịch vụ";
}

double convertDouble(String number) {
  try {
    return double.parse(number);
  } catch (e) {
    return 0;
  }
}

String formatString(String text) => removeDiacritics(text).toLowerCase();

// ignore: must_be_immutable
class DividerTitle extends StatelessWidget {
  DividerTitle({super.key, required this.title, this.dividerColor});
  String title;
  Color? dividerColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Divider(
              height: 20,
              thickness: 2,
              color: dividerColor ?? primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
