
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:toast/toast.dart';

class NotificationUtil {
  final notifications = FlutterLocalNotificationsPlugin();
  final int checkOutNotifyId = 0;

  NotificationUtil(BuildContext context) {
    // final settingsAndroid = AndroidInitializationSettings('assets/images/apple.png');
    final settingsAndroid = AndroidInitializationSettings("@mipmap/apple");
    final settingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: (id, title, body, payload) => onSelectNotification(context));
    notifications.initialize(InitializationSettings(android: settingsAndroid, iOS: settingsIOS),
        onSelectNotification: (context) async => onSelectNotification);
  }


  Future onSelectNotification(BuildContext context) async {

    final int ss = 0;

  }

  // Future<void> showCheckOutNotify([int? maximumCheckoutHours]) async {
  //   await notifications.periodicallyShow(
  //       checkOutNotifyId,
  //       "title",
  //       "body" + '$maximumCheckoutHours Hour/s of your attendance',
  //       RepeatInterval.hourly,
  //       _ongoing);
  // }
  //
  // NotificationDetails get _ongoing {
  //   final androidChannelSpecifics = AndroidNotificationDetails(
  //     'your channel id',
  //     'your channel description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     ongoing: true,
  //     styleInformation: BigTextStyleInformation(''),
  //   );
  //   final iOSChannelSpecifics = IOSNotificationDetails();
  //   return NotificationDetails(android: androidChannelSpecifics, iOS: iOSChannelSpecifics);
  // }
}