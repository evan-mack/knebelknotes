import 'dart:io';

import 'package:flutter/material.dart';
import 'package:knebelknotes/models/user.dart';
import 'package:knebelknotes/models/userInfo.dart';
import 'package:knebelknotes/services/auth.dart';
import 'package:knebelknotes/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  //text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign in to Knebel Knotes'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 100.0),
              Image(
                  image: AssetImage('assets/KnebelKnotesV2.png'), height: 200),
              SizedBox(height: 20.0),
              Center(child: _getSignInButton()),

              //Center(child: _signInButton(userInfo: _userInfo, user: user)),
            ],
          ),
        ));
  }

  Widget _getSignInButton() {
    if (Platform.isAndroid) {
      return _signInGoogleButton();
    } else
      return FutureBuilder(
        future: AppleSignInAvailable.check(),
        builder: (context, snapshot){
          if(snapshot.data)
          return _signInIosButton();
          else
          return PlatformCircularProgressIndicator();
        },
      );
  }

  Widget _signInGoogleButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
        try {
          await _auth.signInWithGoogle();
        } catch (e) {
          print(e.toString());
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _signInIosButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () async {
        try {
          await _auth.signInWithApple();
        } catch (e) {
          print(e.toString());
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/apple_logo.png"), height: 40.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Apple',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
