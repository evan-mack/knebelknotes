import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:knebelknotes/pages/launch_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: 'Knebel Knotes',
    debugShowCheckedModeBanner: false,
      home: LaunchPage(),
    );
  }
}

//Add favourites
//Filters

