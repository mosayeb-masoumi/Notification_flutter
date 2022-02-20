import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notification_flutter/firebase_simple_expandable_notif/firebase_expandable_notification_api.dart';
import 'package:notification_flutter/firebase_simple_expandable_notif/firebase_simple_notification_api.dart';
import 'package:notification_flutter/local_simple_expandable_notif/local_simple_expandable_notif_page.dart';
import 'package:notification_flutter/second_page.dart';

class FirebaseSimpleExpandableNotifPage extends StatefulWidget {
  const FirebaseSimpleExpandableNotifPage({Key? key}) : super(key: key);

  @override
  _FirebaseSimpleExpandableNotifPageState createState() =>
      _FirebaseSimpleExpandableNotifPageState();
}

class _FirebaseSimpleExpandableNotifPageState
    extends State<FirebaseSimpleExpandableNotifPage> {
  @override
  void initState() {
    super.initState();

    _handleFirebaseNotif(); // handle firebase notif here

    // for click notif
    FirebaseSimpleNotificationApi.init(initScheduled: true);
    FirebaseExpandableNotificationApi.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() {
    FirebaseSimpleNotificationApi.onNotifications.stream.listen(onclickNotification);
    FirebaseExpandableNotificationApi.onNotifications.stream.listen(onclickNotification);
  }

  void onclickNotification(String? payload) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondPage(payload: payload)),
    );
  }



  // hangle firebase notif
  void _handleFirebaseNotif() async {
    var message = FirebaseMessaging.instance;
    var token = await message.getToken();
    print("user token is $token");

    FirebaseMessaging.onMessage.listen((event) {
      print("message received ${event.data} ${event.notification!.title}");
      // showExpandableNotif();

      /***********************firebase expandable notif****************************/
      // FirebaseExpandableNotificationApi.showNotification(
      //   title: "firebase expandable title",
      //   body: "firebase expandable body",
      //   image: "https://clipart-best.com/img/mario/mario-clip-art-5.png",
      //   payload: "its firebase expandable payload",
      // );


      /***********************firebase simple notif****************************/
      FirebaseSimpleNotificationApi.showNotification(
        title: "firebase simple title",
        body: "firebase simple body",
        payload: "its firebase simple payload",
      );

    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            RaisedButton(
                child: Text("local notif expandable notif"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LocalSimpleExpandableNotifPage()),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
