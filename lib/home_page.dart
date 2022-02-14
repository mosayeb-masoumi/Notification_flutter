import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:http/http.dart' as http;
import 'package:notification_flutter/notif_util.dart';
import 'package:notification_flutter/second_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key,}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();          /// add globalKey

  @override
  void initState() {
    super.initState();
    _handleFirebaseNotif();// handle firebase notif here

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      key: _scaffoldKey,                   /// add the key


      appBar: AppBar(
        title: Text("title"),
      ),
      body: Center(
        child: Container(
          color: Colors.lightBlueAccent,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [

              SizedBox(height: 50,),
              RaisedButton(
                  child: Text("local notif"),
                  onPressed: () async {
                    showSimpleNotification();
                  }),



              /**expandable notification**/
              SizedBox(height: 10,),
              RaisedButton(
                  child: Text("expandable image"),
                  onPressed: () async {
                    showExpandableNotif();
                  }),


              SizedBox(height: 50,),
              RaisedButton(
                  child: Text("second page"),
                  onPressed: () {

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) =>  SecondPage()),
                    // );

                  }),

            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }





  // hangle firebase notif
  void _handleFirebaseNotif() async {

    var message   = FirebaseMessaging.instance;
    var token = await message.getToken();
    print("user token is $token");

    FirebaseMessaging.onMessage.listen((event) {
      // _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Container(
      //     child: Text(event.data["message"]),
      // )));

      print("message received ${event.data} ${event.notification!.title}");
      showExpandableNotif();

    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("message clicked");
    });


  }




  Future<Uint8List> _getByteArrayFromUrl(String url) async {
    final http.Response response = await http.get(Uri.parse(url));
    return response.bodyBytes;
  }

  void showExpandableNotif() async {
    final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
      // await _getByteArrayFromUrl('https://via.placeholder.com/48x48'));
        await _getByteArrayFromUrl('https://clipart-best.com/img/mario/mario-clip-art-5.png'));
    final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
      // await _getByteArrayFromUrl('https://via.placeholder.com/400x800'));
        await _getByteArrayFromUrl('https://clipart-best.com/img/mario/mario-clip-art-5.png'));

    final BigPictureStyleInformation bigPictureStyleInformation =
    BigPictureStyleInformation(bigPicture,
        largeIcon: largeIcon,
        contentTitle: 'تایتل',
        htmlFormatContentTitle: true,
        summaryText: 'بادی',
        htmlFormatSummaryText: true);


    // showLocalNotification();
    var android  =new AndroidNotificationDetails(
      "channelId"
      , "channelName"
      ,priority: Priority.high
      , importance: Importance.max,
      styleInformation: bigPictureStyleInformation,
      channelShowBadge: true,
      icon: '@mipmap/apple',
      // largeIcon: DrawableResourceAndroidBitmap('@mipmap/apple'),  /**ftom asset**/
      largeIcon: largeIcon,    /**ftom url**/

    );
    var ios= new IOSNotificationDetails();
    var notificationDetails = new NotificationDetails(android: android ,iOS: ios);
    NotificationUtil(context).notifications.show(0, "تایتل", "بادی", notificationDetails ,payload:"pay load");
  }



  void showSimpleNotification() async{

    // showLocalNotification();
    var android  =new AndroidNotificationDetails(
      "channelId"
      , "channelName"
      ,priority: Priority.high
      , importance: Importance.max,

      channelShowBadge: true,
      icon: '@mipmap/apple',
      largeIcon: DrawableResourceAndroidBitmap('@mipmap/apple'),

    );
    var ios= new IOSNotificationDetails();
    var notificationDetails = new NotificationDetails(android: android ,iOS: ios);
    NotificationUtil(context).notifications.show(0, "تایتل", "بادی", notificationDetails ,payload: "pay load");
  }
}