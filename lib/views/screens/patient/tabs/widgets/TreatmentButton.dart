import 'package:app_leohis/views/utils/contants.dart';
import 'package:app_leohis/views/screens/containBodyScreen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:badges/badges.dart' as badges;

// ignore: must_be_immutable
class TreatmentButton extends StatelessWidget {
  TreatmentButton({
    super.key,
    required this.imageUrl,
    required this.title,
    this.line,
    this.badgeNumber,
    required this.page,
    required this.icon,
  });
  String imageUrl;
  String title;
  int? line;
  String? badgeNumber;
  Widget page;
  String icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageTransition(
                child: ContainScreen(page: page, title: title),
                type: PageTransitionType.rightToLeft));
      },
      child: Column(
        children: [
          badgeNumber != null
              ? badges.Badge(
                  badgeContent: Text(badgeNumber.toString(),
                      style: TextStyle(color: themeModeColor)),
                  badgeStyle: badges.BadgeStyle(
                    badgeColor: Colors.red.shade300,
                    shape: badges.BadgeShape.circle,
                  ),
                  child: Container(
                    width: 50,
                    height: 50,
                    // padding: EdgeInsets.all(10),
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //   image: AssetImage(imageUrl),
                    // )),
                    child: Image.asset(icon, color: primaryColor, width: 40),
                  ),
                )
              : Container(
                  width: 50,
                  height: 50,
                  // padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeModeColor,
                    // shape: BoxShape.circle,
                  ),
                  // child: Image.asset(imageUrl,),
                ),
          SizedBox(height: 5),
          Container(
              alignment: Alignment.center,
              width: screen(context).width / 4 - 20,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: line == null ? 2 : line,
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }
}
