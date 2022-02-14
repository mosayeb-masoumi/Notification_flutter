
import 'package:flutter/material.dart';
import 'package:notification_flutter/home_page.dart';
import 'package:notification_flutter/local_notif/local_notif_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40,),
            RaisedButton(
                child: Text("firebase notif"),
                onPressed: (){
                  Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                }),

            SizedBox(height: 40,),
            RaisedButton(
                child: Text("local and schedule notif"),
                onPressed: (){

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  LocalNotifPage()),
                  );

                }),
          ],
        ),
      ),
    );
  }
}
