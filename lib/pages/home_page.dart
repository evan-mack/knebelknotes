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
        content: Text('Info About the App'),
        actions: <Widget>[
          PlatformDialogAction(
            child: PlatformText('Ok'),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          )
        ],
      )
    );
  }

  _disclaimer() {
    return showPlatformDialog(
      context: context,
      builder: (_) => PlatformAlertDialog(
        title: Text('Disclaimer'),
        content: Text('Disclaimer Text Goes here'),
        actions: <Widget>[
          PlatformDialogAction(
            child: PlatformText('I Accept'),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          )
        ],
      )
    );
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
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          )
        ],
      )
    );
  }
  _buildBody() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.content_copy,
              color: Colors.blue[200],
            ),
            title: Text('Treatment Guidelines'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => widget.goToPage(1),
          ),
          ListTile(
            leading: Icon(Icons.local_pharmacy, color: Colors.blue[200]),
            title: Text('Browse Drug Classes'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => widget.goToPage(2),
          ),
          ListTile(
            leading: Icon(Icons.compare_arrows, color: Colors.blue[200]),
            title: Text('View Comparison Charts'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => widget.goToPage(3),
          ),
          ListTile(
            leading: Icon(Icons.search, color: Colors.blue[200]),
            title: Text('Search Medications'),
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
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Center(
          child: Text('Knebel Knotes'),
        ),
      ),
      body: _buildBody()
    );
  }
}
