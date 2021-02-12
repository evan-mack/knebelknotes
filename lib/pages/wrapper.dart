import 'package:flutter/material.dart';
import 'package:knebelknotes/models/user.dart';
import 'package:knebelknotes/models/userInfo.dart';
import 'package:knebelknotes/pages/authenticate/authenticate.dart';
import 'package:knebelknotes/pages/authenticate/sign_in.dart';
import 'package:knebelknotes/pages/authenticate/subscribe.dart';
import 'package:knebelknotes/pages/launch_page.dart';
import 'package:knebelknotes/pages/subscription_page.dart';
import 'package:knebelknotes/services/auth.dart';
import 'package:knebelknotes/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return StreamProvider<UserInfo>(
          create: (_) =>
              DatabaseService(uid: user.uid, email: user.email).users,
          builder: (context, widget) {
            return Subscribe(user: user);
          }
          // print(user.uid);
          //  return LaunchPage();
          );
    }
  }
}
