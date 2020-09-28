import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:knebelknotes/pages/subscription_page.dart';
import 'package:knebelknotes/pages/launch_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return MaterialApp(
      title: 'Knebel Knotes',
    debugShowCheckedModeBanner: false,
      //home: SubscriptionPage()
      home: LaunchPage(),
    );
  }
}