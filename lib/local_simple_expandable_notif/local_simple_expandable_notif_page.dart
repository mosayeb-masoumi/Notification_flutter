
import 'package:flutter/material.dart';
import 'package:notification_flutter/local_simple_expandable_notif/local_expandable_notification_api.dart';
import 'package:notification_flutter/local_simple_expandable_notif/local_simple_notification_api.dart';


import '../second_page.dart';

class LocalSimpleExpandableNotifPage extends StatefulWidget {
  const LocalSimpleExpandableNotifPage({Key? key}) : super(key: key);

  @override
  _LocalSimpleExpandableNotifPageState createState() => _LocalSimpleExpandableNotifPageState();
}

class _LocalSimpleExpandableNotifPageState extends State<LocalSimpleExpandableNotifPage> {
  //https://www.youtube.com/watch?v=bRy5dmts3X8


  @override
  void initState() {
    super.initState();

    // for click notif
    LocalSimpleNotificationApi.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() {
    LocalSimpleNotificationApi.onNotifications.stream.listen(onclickNotification);
  }

  void onclickNotification(String? payload) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondPage(payload: payload)),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            RaisedButton(
                child: Text("Simple Local Notification"), onPressed: () {
              LocalSimpleNotificationApi.showNotification(
                title: "its title",
                body: "its body",
                payload: "its payload",
              );
            }),
            SizedBox(
              height: 10,
            ),

            RaisedButton(
                child: Text("Scheduled Notif after 12 sec"), onPressed: () {

              LocalSimpleNotificationApi.showScheduledNotification(
                title: "its Scheduled title",
                body: "its Scheduled body",
                payload: "its Scheduled payload",
                scheduledDate: DateTime.now().add(Duration(seconds: 12)),
              );


              final snackbar = SnackBar(
                content: Text(
                  "sceduled in 12 seconds",
                  style: TextStyle(fontSize: 16),
                ),
                backgroundColor: Colors.green,
              );

              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(snackbar);
            }),

            SizedBox(
              height: 10,
            ),


            RaisedButton(
                child: Text("Scheduled Notif Daily"), onPressed: () {

              LocalSimpleNotificationApi.showScheduledNotification(
                title: "its Scheduled title",
                body: "its Scheduled body",
                payload: "its Scheduled payload",
                scheduledDate: DateTime.now().add(Duration(seconds: 12)),
              );


              final snackbar = SnackBar(
                content: Text(
                  "sceduled in 12 seconds",
                  style: TextStyle(fontSize: 16),
                ),
                backgroundColor: Colors.green,
              );

              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(snackbar);
            }),


            SizedBox(
              height: 10,
            ),

            RaisedButton(
                child: Text("Local Expandable Notification"), onPressed: () {
              LocalExpandableNotificationApi.showNotification(
                title: "its title",
                body: "its body",
                image: "https://clipart-best.com/img/mario/mario-clip-art-5.png",
                payload: "its payload",
              );
            }),

          ],
        ),
      ),
    );
  }




}
