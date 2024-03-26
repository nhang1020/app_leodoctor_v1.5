import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class Screen_GioiThieuHeThong extends StatelessWidget {
  const Screen_GioiThieuHeThong({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            DividerTitle(title: "Thông tin chi tiết hệ thống"),
            Card(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                              backgroundColor: Theme.of(context).canvasColor,
                              child: Icon(
                                UniconsLine.document_layout_center,
                                color: primaryColor,
                              )),
                          SizedBox(width: 10),
                          Text(
                            "Giới thiệu về hệ thống",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Theme.of(context).cardColor),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Hệ thống quản lý thông tin điều trị nội trú trên nền tảng di động được xây dựng và phát triển theo nhu cầu thực tế của bệnh viện đi kèm kết nối trực tiếp vào Hệ thống quản lý bệnh viện (LEO-HIS), nhằm hỗ trợ chuyên môn và cung cấp các thông tin kịp thời tới y bác sĩ điều trị nội trú.",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                children: [
                  CardInfo(
                    title: "Tên ứng dụng",
                    content:
                        "Hệ thống quản lý thông tin điều trị nội trú Inpatient Infomation System (IIS-CD)",
                    iconName: Icon(
                      UniconsLine.grip_horizontal_line,
                      size: 22,
                      color: primaryColor,
                    ),
                  ),
                  CardInfo(
                    title: "Bản quyền",
                    content: "Bệnh viện Đa Khoa Khu Vực Tỉnh An Giang",
                    iconName: Icon(
                      UniconsLine.award,
                      size: 22,
                      color: primaryColor,
                    ),
                  ),
                  CardInfo(
                    title: "Phiên bản",
                    content: "Version app: 2.0.1, Android 9 → 13",
                    iconName: Icon(
                      UniconsLine.android_alt,
                      size: 22,
                      color: primaryColor,
                    ),
                  ),
                  CardInfo(
                    title: "Phát triển",
                    content: "Công ty cổ phần Leopard (Leopard JSC)",
                    iconName: Icon(
                      UniconsLine.arrow,
                      size: 22,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CardInfo extends StatelessWidget {
  CardInfo({
    super.key,
    required this.title,
    required this.content,
    required this.iconName,
  });

  String title;
  String content;
  Icon iconName;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                      backgroundColor: Theme.of(context).canvasColor,
                      child: iconName),
                  SizedBox(width: 10),
                  Text(
                    '${title}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Theme.of(context).cardColor),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              '${content}',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
//Tên ứng dụng: Hệ thống quản lý thông tin điều trị nội trú Inpatient Infomation System (IIS-CD)
