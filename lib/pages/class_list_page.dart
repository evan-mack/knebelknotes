import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/data/medication.dart';

import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/med_profile_page.dart';

class ClassList extends StatelessWidget {
  final String cat;
  ClassList(this.cat);

  _getTitle(String medName) {
    var title;
    if (medName.contains('(') && medName.contains(')')) {
      title = medName.split('(');
      if (title[1].length < 4) {
        title[0] = medName;
        title[1] = ' ';
      }
      return Center(
        child: Row(
          children: <Widget>[
            Text(title[0]),
            Spacer(),
            Text(title[1].substring(0, title[1].length - 1),
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14,
                ))
          ],
        ),
      );
    } else
      return Text(medName);
  }

  _buildMedBySubClassList(String item) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ExpansionTile(
          initiallyExpanded: true,
          title: Text(
            item,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.blue),
          ),
          children: <Widget>[
            FutureBuilder(
              future: MedicationDao.md.getMedBySubCategory(item),
              builder: (BuildContext context, AsyncSnapshot snapshot2) {
                if (!snapshot2.hasData) {
                  return Center(
                    child: PlatformCircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      for (int i = 0; i < snapshot2.data.length; i++)
                        Column(
                          children: <Widget>[
                            ListTile(
                              title: _getTitle(snapshot2.data[i].medName),
                              trailing: Icon(Icons.navigate_next),
                              onTap: () => Navigator.of(context).push(
                                platformPageRoute(
                                  context: context,
                                  builder: (_) =>
                                      MedProfilePage(snapshot2.data[i]),
                                ),
                              ),
                            ),
                          ],
                        )
                    ],
                  );
                }
              },
            )
          ],
        ),
      ],
    );
  }

  _buildMedBySubClass() {
    return FutureBuilder(
      future: MedicationDao.md.getAllSubCategories(cat),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: PlatformCircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (snapshot.data.length == 1)
                  _buildMedByClass()
                else
                  for (var item in snapshot.data) _buildMedBySubClassList(item)
              ],
            ),
          );
        }
      },
    );
  }

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
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: _getTitle(snapshot.data[index].medName),
                trailing: Icon(Icons.navigate_next),
                onTap: () => Navigator.of(context).push(
                  platformPageRoute(
                    context: context,
                    builder: (_) => MedProfilePage(snapshot.data[index]),
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
        title: cat == 'Addiction Med' ? Text('Mood Stabilizers') : Text(cat),
        material: (_, __) => MaterialAppBarData(
          centerTitle: true,
        ),
        cupertino: (_, __) =>
            CupertinoNavigationBarData(previousPageTitle: 'Drugs By Class'),
      ),
      body: _buildMedBySubClass(),
    );
  }
}
