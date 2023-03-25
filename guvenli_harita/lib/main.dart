import 'package:flutter/material.dart';
import 'package:guvenli_harita/views/current_locati%C4%B1n_screen.dart';
import 'package:guvenli_harita/views/services_screen.dart';
import 'package:guvenli_harita/views/community_center_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Güvenli Harita'),
        ),
        body:SafeArea(
        child: Column(
        children: [
           Container(
              width: 500,
              height: 50,
              color: Colors.blue,
              child: Services(),
            ),
           Container(
                width: 500,
                height: 50,
                child: Community(),
              ),
           Container(
              width: 500,
              height: 500,
              child: CurrentLocationScreen(),
            )
        ],
      ),
      )
      )
    );
  }
}