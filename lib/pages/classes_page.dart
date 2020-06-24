import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter/material.dart';

import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/class_list_page.dart';

class ClassesPage extends StatelessWidget {
  _buildClassList() {
    return FutureBuilder(
        future: MedicationDao.md.getAllCategories(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: PlatformCircularProgressIndicator());
          } else {
            return ListView.separated(
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(snapshot.data[index]),
                  dense: true,
                  onTap: () {
                    Navigator.of(context).push(
                      platformPageRoute(
                        context: context,
                        builder: (_) => ClassList(
                          snapshot.data[index],
                        ),
                      ),
                    );
                  },
                  trailing: Icon(Icons.navigate_next),
                );
              },
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75),
          child: PlatformAppBar(
            title: Center(
              child: Text('Drugs By'),
            ),
            material: (_, __) => MaterialAppBarData(
              bottom: TabBar(tabs: [
                Text(
                  'Class',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  'Utility',
                  style: TextStyle(fontSize: 16),
                )
              ]),
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[_buildClassList(), Text('Utility')],
        ),
      ),
    );
  }
}
