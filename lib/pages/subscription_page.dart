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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kColorPrimary,
      appBar: AppBar(
        title: Text('Knebel Knotes'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(bottom: 18.0),
                child: Center(
                  child: Text(
                    'Welcome',
                    style: kSendButtonTextStyle.copyWith(fontSize: 40),
                    textAlign: TextAlign.center,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: RaisedButton(
                  color: Colors.blue[200],
                  textColor: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Purchase a subscription',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                  onPressed: () {
                    if (appData.isPro) {
                      Navigator.of(context).push(platformPageRoute(
                          context: context, builder: (_) => LaunchPage()));
                    } else {
                      Navigator.of(context).push(platformPageRoute(
                          context: context, builder: (_) => UpgradePage()));
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    appData.isPro = false;

    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup('RBthtoxcpSfRcjHPXEkcyrXCUBQIcfIt');

    PurchaserInfo purchaserInfo;
    try {
      purchaserInfo = await Purchases.getPurchaserInfo();
      print(purchaserInfo.toString());
      if (purchaserInfo.entitlements.all['all_features'] != null) {
        appData.isPro = purchaserInfo.entitlements.all['all_features'].isActive;
      } else {
        appData.isPro = false;
      }
    } on PlatformException catch (e) {
      print(e);
    }

    print('#### is user pro? ${appData.isPro}');
  }
}
