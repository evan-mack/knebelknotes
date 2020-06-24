import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/med_profile_page.dart';

class ClassList extends StatelessWidget {
  final String cat;
  ClassList(this.cat);

  _buildMedByClass() {
    return FutureBuilder(
      future: MedicationDao.md.getMedByClass(cat),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: PlatformCircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(snapshot.data[index].medName),
                  trailing: Icon(Icons.navigate_next),
                  dense: true,
                  onTap: () => Navigator.of(context).push(
                    platformPageRoute(
                      context: context,
                      builder: (_) => MedProfilePage(snapshot.data[index]),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text(cat),
        material: (_, __) => MaterialAppBarData(
          centerTitle: true,
        ),
        cupertino: (_, __) =>
            CupertinoNavigationBarData(previousPageTitle: 'Drugs By Class'),
      ),
      body: _buildMedByClass(),
    );
  }
}
