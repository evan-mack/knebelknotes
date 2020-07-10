import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/med_profile_page.dart';

class Bipolar2List extends StatelessWidget {
  var medList = {
    'MDD': [
      {
        'Monotherapy': [
          'Quetiapine (Seroquel)',
        ],
      }
    ],
    'BPI Maintenance': [
      {
        'Monotherapy': [
          'Quetiapine (Seroquel)',
          'Lithium',
          'Lamotrigine (Lamictal)',
        ],
      }
    ]
  };

  _buildAgeTiles(BuildContext context) {
    return Column(children: <Widget>[
      for (var ageGroup in medList.entries)
        ExpansionTile(
          initiallyExpanded: true,
          title: Text(ageGroup.key),
          children: <Widget>[
            for (Map item in ageGroup.value)
              for (MapEntry item2 in item.entries)
                Column(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(left: 10),
                        child: ExpansionTile(
                          title: Text(item2.key),
                          children: <Widget>[
                            for (String item3 in item2.value)
                              if (item3 == '+')
                                ListTile(title: Center(child: Text(item3)))
                              else
                                ListTile(
                                  title: Text(item3),
                                  leading: item3 !=
                                          'Cognitive Behavioral Therapy'
                                      ? CircleAvatar(
                                          backgroundColor: Colors.green,
                                          child: Text('1st Line',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              )),
                                        )
                                      : CircleAvatar(
                                          backgroundColor: Colors.yellow[300],
                                          child: Text('2nd Line',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                              )),
                                        ),
                                  onTap: () => {
                                    MedicationDao.md
                                        .getMedByName(item3)
                                        .then((med) {
                                      if (med != null)
                                        Navigator.of(context).push(
                                            platformPageRoute(
                                                context: context,
                                                builder: (_) =>
                                                    MedProfilePage(med)));
                                    })
                                  },
                                )
                          ],
                        ))
                  ],
                )
          ],
        )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('Bipolar I Disorder'),
        ),
        body: SingleChildScrollView(child: _buildAgeTiles(context)));
  }
}
