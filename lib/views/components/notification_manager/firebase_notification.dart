import 'package:app_leohis/main.dart';
import 'package:app_leohis/views/components/notification_manager/notification_helper.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

var deviceToken;

class FirebaseMessageApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

// @pragma('vm:entry-point')
  static Future<void> handleOnBackgroundMessage(RemoteMessage message) async {
    print("Title: ${message.notification?.title}");
    print("Body: ${message.notification?.body}");
    print("Payload: ${message.data}");
  }

  void hanldeMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    }
    MyApp.navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message.toString(),
              ),
            ],
          )),
        ),
      ),
    );
  }

  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(hanldeMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(hanldeMessage);
    FirebaseMessaging.onBackgroundMessage(handleOnBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      NotificationHelper.simpleNotification(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        showImage: true,
      );
    });
  }

  //

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    // deviceToken = await _firebaseMessaging.getToken();
    print(deviceToken);
    initPushNotification();
    await NotificationHelper().initNotification();
  }
}
