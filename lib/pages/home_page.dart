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
  @override
  @override
  Widget build(context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
          title: Center(
        child: Text('Knebel Knotes'),
      )),
      body: Column(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
