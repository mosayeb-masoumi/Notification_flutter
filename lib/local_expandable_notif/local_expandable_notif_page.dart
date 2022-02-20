import 'package:flutter/material.dart';
import 'package:notification_flutter/local_expandable_notif/notification_api_expandable.dart';
import 'package:notification_flutter/second_page.dart';

class LocalExpandableNotifPage extends StatefulWidget {
  const LocalExpandableNotifPage({Key? key}) : super(key: key);

  @override
  _LocalExpandableNotifPageState createState() =>
      _LocalExpandableNotifPageState();
}

class _LocalExpandableNotifPageState extends State<LocalExpandableNotifPage> {


  @override
  void initState() {
    super.initState();

    // for click notif
    NotificationExpandableApi.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() {
    NotificationExpandableApi.onNotifications.stream.listen(onclickNotification);
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            RaisedButton(
                child: Text("expandabe local notif clickable"), onPressed: () {

                  showExpandableClickNotif();
            })
          ],
        ),
      ),
    );
  }

  void showExpandableClickNotif() {

    NotificationExpandableApi.showNotification(
      title: "expandable title",
      body: "expandable body",
      image: "https://clipart-best.com/img/mario/mario-clip-art-5.png",
      payload: "its expandable payload",
    );

  }
}
