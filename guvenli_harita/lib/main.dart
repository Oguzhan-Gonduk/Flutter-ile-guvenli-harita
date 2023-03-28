import 'package:flutter/material.dart';
import 'package:guvenli_harita/views/services_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key }) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body:SafeArea(
          child:Container(
            width: double.infinity,
            child: Services(),
              ),
      ),
      )
      );
  }
}