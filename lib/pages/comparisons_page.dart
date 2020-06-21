import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class ComparisonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: PlatformAppBar(
            title: Center(
              child: Text('Comparisons By'),
            ),
            material: (_, __) => MaterialAppBarData(
              bottom: TabBar(tabs: [
                Text(
                  'Side Effects',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Equivalency',
                  style: TextStyle(fontSize: 16),
                )
              ]),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[Text('SideEffects'), Text('Equivalency')],
        ),
      ),
    );
  }
}
