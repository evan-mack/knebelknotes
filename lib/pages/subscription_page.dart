import 'package:flutter/material.dart';
import 'package:knebelknotes/models/userInfo.dart';
import 'package:knebelknotes/pages/launch_page.dart';
import 'package:knebelknotes/pages/subscription_info.dart';
import 'package:knebelknotes/pages/upgrade_page.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/services/auth.dart';

import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:flutter/services.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SubscriptionPageState();
}

class SubscriptionPageState extends State<SubscriptionPage> {
  PurchaserInfo _purchaserInfo;
  PurchaserInfo _restoreInfo;
  Offerings _offerings;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    appData.isPro = null;

    //await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup('RBthtoxcpSfRcjHPXEkcyrXCUBQIcfIt');

    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    Offerings offerings = await Purchases.getOfferings();
    PurchaserInfo restoreInfo = await Purchases.restoreTransactions();

    Purchases.addPurchaserInfoUpdateListener((purchaserInfo) {
      setState(() {
        appData.isPro =
            purchaserInfo.entitlements.active.containsKey('all_features');
      });
    });

    Purchases.addPurchaserInfoUpdateListener((restoreInfo) {
      setState((){
        appData.isPro = restoreInfo.entitlements.active.containsKey('all_features');
      });
     });

    setState(() {
      _restoreInfo = restoreInfo;
      _purchaserInfo = purchaserInfo;
      _offerings = offerings;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserInfo _userInfo = Provider.of<UserInfo>(context);
    if (_userInfo == null) {
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
    } else if (_userInfo.isAdmin)
      return LaunchPage();
    else if (_userInfo.isStudent &&
        DateTime.parse(_userInfo.accessExpires).isAfter(DateTime.now()))
      return LaunchPage();
    else if (_purchaserInfo == null) {
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
      var isPro = _restoreInfo.entitlements.active.containsKey('all_features');
      appData.isPro =
          _purchaserInfo.entitlements.active.containsKey('all_features');
      //print('isPro = {$isPro}');
      if (appData.isPro || isPro) {
        
        return LaunchPage();
      } else
        return UpgradePage(
          offerings: _offerings,
        );
    }
  }
}
