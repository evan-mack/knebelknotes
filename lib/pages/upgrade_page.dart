import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:knebelknotes/data/medication.dart';
import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/launch_page.dart';
import 'package:knebelknotes/pages/med_profile_page.dart';
import 'package:knebelknotes/pages/subscription_page.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:knebelknotes/pages/subscription_info.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class UpgradePage extends StatefulWidget {
  final Offerings offerings;
  UpgradePage({Key key, @required this.offerings}) : super(key: key);

  @override
  createState() => UpgradePageState();
}

class UpgradePageState extends State<UpgradePage> {
  @override
  void initState() {
    super.initState();
  }

  Future<List<Medication>> _testMedication() async {
    final String meds =
        await rootBundle.loadString('assets/test_medication.json');

    MedicationDao.md.deleteAll();
    return (medicationFromJson(meds)).map((medication) {
      MedicationDao.md.insert(medication);
    }).toList();
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.offerings != null) {
      print('Offerings not null 1');
      final offering = widget.offerings.current;
      if (offering != null) {
        print('Offerings not null 2');
        final annual = offering.annual;
        if (annual != null) {
          print('Offerings not null 3');
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Thank you for your interest in',
                    textAlign: TextAlign.center,
                    style: kSendButtonTextStyle,
                  ),
                  Text(
                    'Knebel Knotes\n',
                    style: kSendButtonTextStyle.copyWith(
                        color: Colors.blue,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 8),
                    child: Text(
                      'Please purchase a subscription to gain full access.\n',
                      textAlign: TextAlign.center,
                      style: kSendButtonTextStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'This helps us to...',
                          textAlign: TextAlign.start,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text('\u2022 Maintain the app'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text('\u2022 Continue adding new features'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                              '\u2022 Update information as new medications and guidelines are released'),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PurchaseButton(package: annual),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                        onTap: () async {
                          try {
                            PurchaserInfo purchaserInfo =
                                await Purchases.getPurchaserInfo();
                            PurchaserInfo restoredInfo =
                                await Purchases.restoreTransactions();
                            if (purchaserInfo.entitlements.active
                                    .containsKey('all_features') ||
                                restoredInfo.entitlements.active
                                    .containsKey('all_features')) {
                              setState(() {
                                appData.isPro = true;
                              });
                            } else
                              setState(() {
                                appData.isPro = false;
                              });
                            print(appData.isPro);
                            if (appData.isPro) {
                              showPlatformDialog(
                                  context: context,
                                  builder: (_) => PlatformAlertDialog(
                                        content: Text('Account restored', textAlign: TextAlign.center,),
                                        actions: <Widget>[
                                          PlatformDialogAction(
                                            child: PlatformText('Continue'),
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                        platformPageRoute(
                                                            context: context,
                                                            builder: (_) =>
                                                                LaunchPage())),
                                          )
                                        ],
                                      ));
                            } else {
                              showPlatformDialog(
                                  context: context,
                                  builder: (_) => PlatformAlertDialog(
                                        content: Text(
                                            'No subscription found. Please purchase a subscription to continue. If you recently purchased a subscription, it may take a few minutes to grant access.', textAlign: TextAlign.center,),
                                        actions: <Widget>[
                                          PlatformDialogAction(
                                            child: PlatformText('Ok'),
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop()
                                          )
                                        ],
                                      ));
                            }
                          } on PlatformException catch (e) {
                            print(e);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            'Already have a subscription?',
                            style: kSendButtonTextStyle.copyWith(
                                fontSize: 16, color: Colors.white),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          _launchInBrowser('http://www.knebel.ca');
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            'Privacy Policy',
                            style: kSendButtonTextStyle.copyWith(
                                fontSize: 16, color: Colors.white),
                          ),
                        )),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          MedicationDao.md
                              .getMedByName('Mirtazapine (Remeron)')
                              .then((med) {
                            Navigator.of(context).push(platformPageRoute(
                                context: context,
                                builder: (_) => MedProfilePage(med)));
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text(
                            'Example Medication Profile',
                            style: kSendButtonTextStyle.copyWith(
                                fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ))
                  // Padding(
                  //   padding: const EdgeInsets.all(18.0),
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       _launchURLWebsite('https://yahoo.com');
                  //     },
                  //     child: Text(
                  //       'Term of Use (click to read)',
                  //       style: kSendButtonTextStyle.copyWith(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.normal,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              )),
            ),
          );
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Upgrade Screen'),
      ),
      // backgroundColor: kColorPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Icon(
                Icons.error,
                //color: kColorText,
                size: 44.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "There was an error. Please check that your device is allowed to make purchases and try again. Please contact us at xxx@xxx.com if the problem persists.",
                textAlign: TextAlign.center,
                style: kSendButtonTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PurchaseButton extends StatelessWidget {
  final Package package;

  PurchaseButton({Key key, @required this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Container(
        //color: kColorPrimaryLight,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: RaisedButton(
                onPressed: () async {
                  try {
                    print('now trying to purchase');
                    PurchaserInfo _purchaserInfo =
                        await Purchases.purchasePackage(package);
                    print('purchase completed');
                    

                    appData.isPro = _purchaserInfo
                        .entitlements.all["all_features"].isActive;

                    print('is user pro? ${appData.isPro}');

                    if (appData.isPro) {
                      return LaunchPage();
                    }
                  } on PlatformException catch (e) {
                    print('----xx-----');
                    var errorCode = PurchasesErrorHelper.getErrorCode(e);
                    if (errorCode ==
                        PurchasesErrorCode.purchaseCancelledError) {
                      print("User cancelled");
                    } else if (errorCode ==
                        PurchasesErrorCode.purchaseNotAllowedError) {
                      print("User not allowed to purchase");
                    } else {
                      print(errorCode);
                    }
                  }
                  return SubscriptionPage();
                },
                //textColor: kColorText,
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(color: Colors.blue),
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Purchase 1-Year Subscription\n${package.product.priceString}',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
