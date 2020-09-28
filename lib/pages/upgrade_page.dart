import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:knebelknotes/pages/launch_page.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:knebelknotes/pages/subscription_info.dart';

PurchaserInfo _purchaserInfo;

class UpgradePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UpgradeScreenState();
}

class _UpgradeScreenState extends State<UpgradePage> {
  Offerings _offerings;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    PurchaserInfo purchaserInfo;
    try {
      purchaserInfo = await Purchases.getPurchaserInfo();
    } on PlatformException catch (e) {
      print(e);
    }

    Offerings offerings;
    try {
      offerings = await Purchases.getOfferings();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _purchaserInfo = purchaserInfo;
      _offerings = offerings;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_purchaserInfo == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Buy Subscription'),
        ),
            //backgroundColor: kColorPrimary,
            body: Center(
                child: Text(
              "Loading...",
            )),
      );
    } else {
      if (_purchaserInfo.entitlements.all.isNotEmpty && _purchaserInfo.entitlements.all['all_features'].isActive != null) {
        appData.isPro = _purchaserInfo.entitlements.all['all_features'].isActive;
      } else {
        appData.isPro = false;
      }
      if (appData.isPro) {
        return LaunchPage();
      } else {
      return Text("Test");/*UpsellScreen(
        offerings: _offerings,
      );*/
      }
    }
  }
}