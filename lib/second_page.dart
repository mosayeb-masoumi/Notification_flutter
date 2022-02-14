
import 'package:flutter/material.dart';

class SecondPage extends StatefulWidget {
  final String? payload;
  SecondPage({Key? key, required this.payload}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.pinkAccent,
      child: Center(
        child: Text(widget.payload?? "" , )
      ),
    );
  }
}
