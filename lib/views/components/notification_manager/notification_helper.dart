// import 'package:app_leohis/views/components/notification_manager/utils.dart';
import 'package:app_leohis/views/utils/contants.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tZ;

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();
  Future<void> initNotification() async {
    tZ.initializeTimeZones();
    AndroidInitializationSettings android =
        const AndroidInitializationSettings('launcher_icon');
    DarwinInitializationSettings iOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // MyApp.navigatorKey.currentState?.push(MaterialPageRoute(
        //   builder: (context) => LoginScreen(),
        // ));
      },
    );
  }

  static Future _notificationDetails({bool showImage = false}) async {
    // var bigPicturePath = await Utils.convertToBase64("assets/image001.png");
    // final largeIconPath = await Utils.convertToVase64("");

    // final styleInformation = BigPictureStyleInformation(
    //   ByteArrayAndroidBitmap.fromBase64String(bigPicturePath),

      // largeIcon: FilePathAndroidBitmap(largeIconPath),
    // );

    return NotificationDetails(
      android: AndroidNotificationDetails(
        'Channel_id',
        'Channel_title',
        priority: Priority.high,
        importance: Importance.max,
        channelShowBadge: true,
        largeIcon: DrawableResourceAndroidBitmap('launcher_icon'),
        color: primaryColor,
        colorized: true,
        // styleInformation: showImage ? styleInformation : null,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future<void> simpleNotification(
      {int id = 0, String? title, String? body, bool showImage = false}) async {
    await notificationsPlugin.show(
        id, title, body, await _notificationDetails(showImage: showImage));
  }

  static Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required DateTime date,
      required TimeOfDay time}) async {
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'Channel_id',
      'Channel_title',
      priority: Priority.high,
      importance: Importance.max,
      icon: 'launcher_icon',
      channelShowBadge: true,
      largeIcon: DrawableResourceAndroidBitmap('launcher_icon'),
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    DateTime _dateTime = DateTime(
        date.year, date.month, date.day, time.hour, time.minute, date.second);

    return notificationsPlugin.zonedSchedule(id, title, body,
        tz.TZDateTime.from(_dateTime, tz.local), notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  static Future cancelAll() async => await notificationsPlugin.cancelAll();
  static Future cancel({required int id}) async =>
      await notificationsPlugin.cancel(id);
}
