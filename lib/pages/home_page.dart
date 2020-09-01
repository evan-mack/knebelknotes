import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class HomePage extends StatefulWidget {
  //Route Name
  static const routeName = '/HomePage';
  HomePage(this.goToPage);
  final Function goToPage;
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
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
              content: Text('This app is intended for use by health care students and providers, and not the general public. The information included is abbreviated and serves as a practical reference guide. Information is not comprehensive and errors may exist. It is not meant to serve as a comprehensive drug monograph. Drug doses are based on clinical literature and experience, and may be different from manufacturers recommendations. Indications are based on Canadian psychiatric guidelines considered current as of September 2019'),
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
              content: Text('Sources Text Goes here'),
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
    return Scaffold(
        appBar: AppBar(
          title: Text('Knebel Knotes'),
          centerTitle: true,
        ),
        body: _buildBody());
  }
}
