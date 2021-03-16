import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/models/userInfo.dart';
import 'package:knebelknotes/pages/admin_page.dart';
import 'package:knebelknotes/services/auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final AuthService _auth = AuthService();

  //Route Name
  static const routeName = '/HomePage';
  HomePage(this.goToPage);
  final Function goToPage;
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<void> _launched;

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  _aboutTheApp() {
    return showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
              title: Text('About the App'),
              content: Text(
                  'Knebel Knotes provides a quick reference for prescribing most psychiatric medications. It focuses on key information each medication is known for, to help support clinical practice and facilitate learning. Drug classes included are: antipsychotics (typical and atypical), antidepressants (SSRIs, SNRIs, TCAs, MAOIs, and atypicals), mood stabilizers, anxiolytics/sedatives, ADHD medications, cognitive enhancers, addictions medications, side effect medications). Key information provided includes: indications, dosing (initial, range, max), side effects, severe effects, black box warnings, and drug class comparisons (for example equivalencies). Additional references include short-acting injectables, long-acting injectables, and common PRNs.'),
              actions: <Widget>[
                PlatformDialogAction(
                  child: PlatformText('Ok'),
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                )
              ],
            ));
  }

  _disclaimer() {
    return showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
              title: Text('Disclaimer'),
              content: Text(
                  'This app is intended for use by health care students and providers, and not the general public. The information included is abbreviated and serves as a practical reference guide. Information is not comprehensive and errors may exist. It is not meant to serve as a comprehensive drug monograph. Drug doses are based on clinical literature and experience, and may be different from manufacturers recommendations. Indications are based on Canadian psychiatric guidelines considered current as of September 2019'),
              actions: <Widget>[
                PlatformDialogAction(
                  child: PlatformText('I Accept'),
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                )
              ],
            ));
  }

  _sources() {
    return showPlatformDialog(
        context: context,
        builder: (_) => PlatformAlertDialog(
              title: Text('Sources'),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                      width: double.maxFinite,
                      child: PlatformButton(
                          onPressed: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.amazon.ca/Prescribers-Guide-Stahls-Essential-Psychopharmacology/dp/1107675022');
                              }),
                          child: Text(
                              'Stahl’s Essential Psychopharmacology – Prescriber’s Guide',
                              textAlign: TextAlign.center))),
                  SizedBox(
                      width: double.maxFinite,
                      child: PlatformButton(
                          onPressed: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.pharmacists.ca/products-services/rxtxmobile/');
                              }),
                          child: Text(
                              'RxTx by Canadian Pharmacists Association',
                              textAlign: TextAlign.center))),
                  SizedBox(
                      width: double.maxFinite,
                      child: PlatformButton(
                          onPressed: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.accessdata.fda.gov/scripts/cder/daf/');
                              }),
                          child: Text('Drug Monographs from FDA',
                              textAlign: TextAlign.center))),
                  SizedBox(
                      width: double.maxFinite,
                      child: PlatformButton(
                          onPressed: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.canada.ca/en/health-canada/services/drugs-health-products/drug-products/drug-product-database.html');
                              }),
                          child: Text(
                              'Drug Monographs from Health Canada database',
                              textAlign: TextAlign.center))),
                  SizedBox(
                      width: double.maxFinite,
                      child: PlatformButton(
                          onPressed: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4994790/');
                              }),
                          child: Text(
                            'CANMAT 2016 Depression Guidelines',
                            textAlign: TextAlign.center,
                          ))),
                  SizedBox(
                      width: double.maxFinite,
                      child: PlatformButton(
                          onPressed: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5947163/');
                              }),
                          child: Text(
                            'CANMAT 2018 Bipolar Guidelines ',
                            textAlign: TextAlign.center,
                          ))),
                  SizedBox(
                      width: double.maxFinite,
                      child: PlatformButton(
                          onPressed: () => setState(() {
                                _launched = _launchInBrowser(
                                    'https://bmcpsychiatry.biomedcentral.com/articles/10.1186/1471-244X-14-S1-S1');
                              }),
                          child: Text(
                            '2014 Canadian clinical practice guidelines for the management of anxiety, posttraumatic stress and obsessive-compulsive disorders',
                            textAlign: TextAlign.center,
                          ))),
                ],
              ),
              actions: <Widget>[
                PlatformDialogAction(
                  child: PlatformText('Ok'),
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                )
              ],
            ));
  }

  _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            width: double.infinity,
            child: Text('Browse By...', style: TextStyle(fontSize: 20)),
          ),
        ),
        ListTile(
          leading: Icon(Icons.local_pharmacy, color: Colors.blue[200]),
          title: Text('Drug Classes'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () => widget.goToPage(1),
        ),
        ListTile(
          leading: Icon(
            Icons.content_copy,
            color: Colors.blue[200],
          ),
          title: Text('Treatment Guidelines'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () => widget.goToPage(2),
        ),
        ListTile(
          leading: Icon(Icons.compare_arrows, color: Colors.blue[200]),
          title: Text('Comparison Charts'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () => widget.goToPage(3),
        ),
        ListTile(
          leading: Icon(Icons.search, color: Colors.blue[200]),
          title: Text('Medication List (Search)'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () => widget.goToPage(4),
        ),
        Card(
          color: Colors.blueAccent[400],
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Center(
                  child: Text(
                    'ABOUT THE APP',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () => _aboutTheApp(),
              ),
              Container(
                color: Colors.white,
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 50),
              ),
              ListTile(
                title: Center(
                  child: Text(
                    'DISCLAIMER',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () => _disclaimer(),
              ),
              Container(
                color: Colors.white,
                height: 1,
                margin: EdgeInsets.symmetric(horizontal: 50),
              ),
              ListTile(
                title: Center(
                  child: Text(
                    'SOURCES',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () => _sources(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(context) {
    UserInfo _userInfo = Provider.of<UserInfo>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Knebel Knotes'),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton(
              offset: Offset(0, 50),
              itemBuilder: (context) => <PopupMenuEntry>[
                if (_userInfo.isAdmin)
                  PopupMenuItem(
                    height: 20,
                    child: FlatButton.icon(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(platformPageRoute(
                            context: context, builder: (_) => AdminPage()));
                      },
                      label: Text('Admin'),
                    ),
                  ),
                PopupMenuItem(
                  height: 20,
                  child: FlatButton.icon(
                    icon: Icon(Icons.person),
                    onPressed: () async {
                      await widget._auth.signOut();
                    },
                    label: Text('Log Out'),
                  ),
                )
              ],
            ),
          ],
        ),
        body: _buildBody());
  }
}
