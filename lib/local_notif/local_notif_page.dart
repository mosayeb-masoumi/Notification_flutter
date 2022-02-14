import 'package:flutter/material.dart';
import 'package:notification_flutter/local_notif/notification_api.dart';
import 'package:notification_flutter/second_page.dart';

class LocalNotifPage extends StatefulWidget {
  const LocalNotifPage({Key? key}) : super(key: key);

  @override
  _LocalNotifPageState createState() => _LocalNotifPageState();
}

class _LocalNotifPageState extends State<LocalNotifPage> {

  //https://www.youtube.com/watch?v=bRy5dmts3X8


  @override
  void initState() {
    super.initState();

    // for click notif
    NotificationApi.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() {
    NotificationApi.onNotifications.stream.listen(onclickNotification);
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
                  NotificationApi.showNotification(
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

              NotificationApi.showScheduledNotification(
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

              NotificationApi.showScheduledNotification(
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


          ],
        ),
      ),
    );
  }




}
