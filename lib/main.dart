import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:knebelknotes/pages/subscription_page.dart';
import 'package:knebelknotes/pages/launch_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:knebelknotes/pages/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:knebelknotes/services/auth.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp2());
}

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
        home: SubscriptionPage()
        //home: LaunchPage(),
        );
  }
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return StreamProvider<CustomUser>.value(
      value: AuthService().user,
      child: MaterialApp(
          title: 'Knebel Knotes',
          debugShowCheckedModeBanner: false,
          home: Wrapper()),
    );
    
  }
}
