import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AppData {
  static final AppData _appData = new AppData._internal();

  bool isPro;

  factory AppData() {
    return _appData;
  }
  AppData._internal();
}


final appData = AppData();

var kWelcomeAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  animationDuration: Duration(milliseconds: 450),
  //backgroundColor: kColorPrimaryLight,
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
  titleStyle: TextStyle(
    //color: kColorText,
    fontWeight: FontWeight.bold,
    fontSize: 30.0,
    letterSpacing: 1.5,
  ),
);

TextStyle kSendButtonTextStyle = TextStyle(
  //color: kColorText,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);