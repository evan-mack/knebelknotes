import 'package:flutter/material.dart';

import 'package:knebelknotes/pages/launch_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knebel Knotes',
    debugShowCheckedModeBanner: false,
      home: LaunchPage(),
    );
  }
}