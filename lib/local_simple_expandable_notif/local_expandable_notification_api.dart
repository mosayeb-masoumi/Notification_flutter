
import 'dart:typed_data';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'package:http/http.dart' as http;



class LocalExpandableNotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails(String? title , String? body,String? image) async {

    final  ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(await _getByteArrayFromUrl(image));
    final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(await _getByteArrayFromUrl(image));

    final BigPictureStyleInformation bigPictureStyleInformation =
    BigPictureStyleInformation(bigPicture,
        largeIcon: largeIcon,
        contentTitle: title,
        htmlFormatContentTitle: true,
        summaryText: body,
        htmlFormatSummaryText: true);



    return NotificationDetails (


      android: AndroidNotificationDetails(
        "channel id",
        "channel name",
        importance: Importance.max,
        styleInformation: bigPictureStyleInformation,
        channelShowBadge: true,
        icon: '@mipmap/apple',
        // largeIcon: DrawableResourceAndroidBitmap('@mipmap/apple'),  /**ftom asset**/
        largeIcon: largeIcon,    /**ftom url**/



      ),
      iOS: IOSNotificationDetails(),
    );
  }

  // onClick
  static Future init({bool initScheduled = false}) async {

    final android = AndroidInitializationSettings("@mipmap/ic_launcher");
    final iOS = IOSInitializationSettings();
    final settings = InitializationSettings(android: android , iOS: iOS);

    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );


    if(initScheduled){
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }

  }



  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? image,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(title , body , image),
        payload: payload,
      );




  static Future<Uint8List> _getByteArrayFromUrl(String? url) async {
    final http.Response response = await http.get(Uri.parse(url!));
    return response.bodyBytes;
  }






}
