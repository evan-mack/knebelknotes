import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/med_profile_page.dart';

class MDDList extends StatelessWidget {
  var medList = {
    'Adults': [
      {
        'Monotherapy': [
          //SSRIs
          'Escitalopram (Cipralex)',
          'Citalopram (Celexa)',
          'Fluoxetine (Prozac)',
          'Paroxetine (Paxil)',
          'Sertaline (Zoloft)',
          'Fluvoxamine (Luvox)',
          'Venlafaxine (Effexor)',
          //SNRIs
          'Duloxetine (Cymbalta)',
          'Desvenlafaxine (Prestiq)',
          'Levomilnacipran (Fetzima)',
          //Others
          'Bupropion (Wellbutrin XR)',
          'Vortioxetine (Trintellix)',
          'Mirtazapine (Remeron)',
          //Does not appear
          'Agomelatine'
        ],
        'Adjunct/Combo': [
          'Risperidone (Risperdal)',
          'Aripiprazole (Abilify)',
          'Quetiapine (Seroquel)'
        ],
        'Psychotherapy': [
          'Cognitive Behavioral Therapy',
          'Interpersonal Therapy',
          'Behavioral Activation'
        ]
      }
    ],
    'Children': [
      {
        'Monotherapy': [
          'Fluoxetine (Prozac)',
          'Sertaline (Zoloft)',
          'Escitalopram (Cipralex)'
        ],
        'Adjunct/Combo': ['Add med to Psychotherapy'],
        'Psychotherapy': [
          'Mild to Moderate try Psychotherapy first (Cognitive Behavioral Therapy or Interpersonal Therapy)'
        ]
      }
    ],
    'Elderly': [
      {
        'Monotherapy': [
          'Duloxetine (Cymbalta)',
          'Mirtazapine (Remeron)',
          'Nortriptyline (Aventyl)',
          'Bupropion (Wellbutrin XR)',
          'Escitalopram (Cipralex)',
          'Sertaline (Zoloft)',
          'Venlafaxine (Effexor)',
          'Vortioxetine (Trintellix)'
        ],
        'Psychotherapy': [
          'Mild to Moderate try Psychotherapy first (Cognitive Behavioral Therapy or Interpersonal Therapy)'
        ]
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
                              ListTile(
                                title: Text(item3),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Text('1st Line',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
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
          title: Text('MDD'),
        ),
        body: SingleChildScrollView(child: _buildAgeTiles(context)));
  }
}
