// import 'package:app_leohis/views/utils/contants.dart';
// import 'package:flutter/material.dart';

// class MySnackbar {
//   String title;
//   Color? titleColor;
//   String? subtitle;
//   Color? subtitleColor;
//   Color? backgroundColor;
//   IconData? icon;
//   MySnackbar({
//     required this.title,
//     this.titleColor,
//     this.subtitle,
//     this.subtitleColor,
//     this.backgroundColor,
//     this.icon,
//   });

//   show(BuildContext context) {
//     var snackbar = SnackBar(
//       margin: EdgeInsets.only(
//         bottom: 65,
//       ),
//       backgroundColor: Colors.transparent,
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       elevation: 0,
//       behavior: SnackBarBehavior.floating,
//       dismissDirection: DismissDirection.horizontal,
//       content: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: backgroundColor ?? primaryColor,
//         ),
//         child: ListTile(
//           leading: icon != null
//               ? Icon(icon, size: 20, color: Theme.of(context).canvasColor)
//               : Icon(
//                   Icons.notifications,
//                   color: Theme.of(context).canvasColor,
//                   size: 20,
//                 ),
//           title: Text(
//             '${title}',
//             style:
//                 TextStyle(color: titleColor ?? Theme.of(context).canvasColor),
//           ),
//           subtitle: subtitle != null
//               ? Text(
//                   '${subtitle}',
//                   style: TextStyle(
//                       color: subtitleColor ?? Theme.of(context).canvasColor),
//                 )
//               : null,
//         ),
//       ),
//       showCloseIcon: true,
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackbar);
//   }
// }
