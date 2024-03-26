import 'package:flutter/material.dart';

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    var width = size.width, height = size.height;
    path.lineTo(0, height);

    var firstStart = Offset(width / 7, height * 3 / 4);
    var firstEnd = Offset(width / 2.5, height * 7 / 8);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart = Offset(width - width / 3.25, height);
    var secondEnd = Offset(width - width / 3.76, height * 3 / 4.1);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    var thirdStart = Offset(width - width / 4, height * 0.65);
    var thirdEnd = Offset(width - width / 4.3, height * 0.57);
    path.quadraticBezierTo(
        thirdStart.dx, thirdStart.dy, thirdEnd.dx, thirdEnd.dy);

    var fourthStart = Offset(width - width / 5, height * 0.4);
    var fourthEnd = Offset(width, height * 0.4);
    path.quadraticBezierTo(
        fourthStart.dx, fourthStart.dy, fourthEnd.dx, fourthEnd.dy);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // Trả về true nếu bạn muốn clip path được vẽ lại khi có sự thay đổi
    return false;
  }
}


// Stack(
//           children: [
//             Opacity(
//               opacity: .5,
//               child: ClipPath(
//                 clipper: CurveClipper(),
//                 child: Container(
//                   // height: MediaQuery.of(context).size.height,
//                   width: 600,
//                   decoration: BoxDecoration(
//                       // color: Colors.deepOrange,
//                       image: DecorationImage(
//                           image: NetworkImage(
//                               "https://cdn.pixabay.com/photo/2020/05/04/10/21/background-5128586_1280.jpg"),
//                           fit: BoxFit.fill)),
//                 ),
//               ),
//             )
//           ],
//         ),