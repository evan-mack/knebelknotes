import 'package:flutter/material.dart';
import 'package:knebelknotes/models/user.dart';
import 'package:knebelknotes/pages/subscription_page.dart';
import 'package:knebelknotes/services/database.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class Subscribe extends StatefulWidget {
  CustomUser user;
  Subscribe({this.user});
  @override
  _SubscribeState createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseService(uid: widget.user.uid, email: widget.user.email)
            .getUserInfo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (!snapshot.data.exists)
              DatabaseService(uid: widget.user.uid, email: widget.user.email)
                  .updateUserData(false, true, DateTime.now().add(new Duration(days: 7)).toString());

            return SubscriptionPage();
          }
          return Scaffold(
            //backgroundColor: kColorPrimary,

            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Center(
                        child: Text(
                          'Loading Account...',
                          textAlign: TextAlign.center,
                        ),
                      )),
                  Center(child: PlatformCircularProgressIndicator())
                ],
              ),
            ),
          );
        });
  }
}
