import 'package:flutter/material.dart';
import 'package:knebelknotes/pages/launch_page.dart';
import 'package:knebelknotes/pages/subscription_info.dart';
import 'package:knebelknotes/pages/upgrade_page.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/services.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SubscriptionPageState();
}

class SubscriptionPageState extends State<SubscriptionPage> {
  PurchaserInfo _purchaserInfo;
  Offerings _offerings;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    appData.isPro = null;

    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup('RBthtoxcpSfRcjHPXEkcyrXCUBQIcfIt');

    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    Offerings offerings = await Purchases.getOfferings();
    Purchases.addPurchaserInfoUpdateListener((purchaserInfo) {
      setState(() {
        appData.isPro =
            purchaserInfo.entitlements.active.containsKey('all_features');
      });
    });

    setState(() {
      _purchaserInfo = purchaserInfo;
      _offerings = offerings;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_purchaserInfo);
    if (_purchaserInfo == null) {
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
    } else {
      var isPro =
          _purchaserInfo.entitlements.active.containsKey('all_features');
      print('isPro = {$isPro}');
      if (isPro){
        return UpgradePage(offerings: _offerings);
        //return LaunchPage();
      }else
        return UpgradePage(
          offerings: _offerings,
        );
    }
  }
}
