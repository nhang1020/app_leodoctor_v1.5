// import 'package:app_leohis/main.dart';
// import 'package:app_leohis/views/components/rootWidget.dart';
// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';

// class NotificationService {
//   static Future<void> initializeNotification() async {
//     await AwesomeNotifications().initialize(
//       null,
//       [
//         NotificationChannel(
//             channelKey: 'high_importance_channel',
//             channelName: 'high_importance_channel',
//             channelDescription: "Hello",
//             defaultColor: Colors.deepPurple,
//             ledColor: Colors.white,
//             playSound: true,
//             criticalAlerts: true,
//             importance: NotificationImportance.Max,
//             channelShowBadge: true)
//       ],
//       channelGroups: [
//         NotificationChannelGroup(
//             channelGroupKey: 'high_importance_channel_group',
//             channelGroupName: 'group1')
//       ],
//       debug: false,
//     );
//     await AwesomeNotifications()
//         .isNotificationAllowed()
//         .then((isAllowed) async {
//       if (!isAllowed) {
//         await AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });

//     await AwesomeNotifications().setListeners(
//       onActionReceivedMethod: onActionReceivedMethod,
//       onNotificationCreatedMethod: onNotificationCreatedMethod,
//       onNotificationDisplayedMethod: onNotificationDisplayedMethod,
//       onDismissActionReceivedMethod: onDismissActionReceivedMethod,
//     );
//   }

//   static Future<void> onNotificationCreatedMethod(
//       ReceivedNotification receivedNotification) async {
//     // debugPrint("onNotificationCreatedMethod");
//   }

//   static Future<void> onNotificationDisplayedMethod(
//       ReceivedNotification receivedNotification) async {
//     // debugPrint("onNotificationDisplayedMethod");
//   }

//   static Future<void> onDismissActionReceivedMethod(
//       ReceivedAction receivedNotification) async {
//     // debugPrint("onDismissActionReceivedMethod");
//   }

//   static Future<void> onActionReceivedMethod(
//       ReceivedAction receivedNotification) async {
//     final payload = receivedNotification.payload ?? {};

//     if (payload["navigate"] == "true") {
//       debugPrint("onActionReceivedMethod");
//       MyApp.navigatorKey.currentState?.push(MaterialPageRoute(
//         builder: (_) => NavBars(),
//       ));
//     }
//   }

//   static Future<void> cancelSchedule(int id) async {
//     try {
//       AwesomeNotifications().cancel(id);
//     } catch (e) {
//       print(e);
//     }
//   }

//   static Future<void> showNotification({
//     required final String title,
//     required final String body,
//     final String? sumary,
//     final Map<String, String>? payload,
//     final ActionType actionType = ActionType.Default,
//     final NotificationLayout notificationLayout = NotificationLayout.Default,
//     final NotificationCategory? category,
//     final String? bigPicture,
//     final List<NotificationActionButton>? actionButtons,
//     final bool scheduled = false,
//     final int? interval,
//     final TimeOfDay? time,
//     final DateTime? date,
//   }) async {
//     assert(!scheduled || (scheduled && time != null && date != null));
//     await AwesomeNotifications().createNotification(
//         content: NotificationContent(
//           id: -1,
//           channelKey: 'high_importance_channel',
//           title: title,
//           body: body,
//           actionType: actionType,
//           notificationLayout: notificationLayout,
//           summary: sumary,
//           category: category,
//           payload: payload,
//           bigPicture: bigPicture,
//         ),
//         actionButtons: actionButtons,
//         schedule: scheduled
//             ? NotificationCalendar(
//                 day: date!.day,
//                 month: date.month,
//                 year: date.year,
//                 hour: time!.hour,
//                 minute: time.minute,
//                 second: date.add(Duration(seconds: 5)).second,
//                 repeats: false)
//             : null);
//     // ? NotificationInterval(
//     //     interval: interval,
//     //     timeZone:
//     //         await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//     //     preciseAlarm: true)
//     // : null);
//   }
// }
