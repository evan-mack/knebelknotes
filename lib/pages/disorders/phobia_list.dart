import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/med_profile_page.dart';

class PhobiaList extends StatelessWidget {
  var medList = {
    'As Needed': [
      'No Routine Meds',
      'Oxazepam (Serax)',
      'Alprazolam (Xanax)',
      'Lorazepam (Ativan)',
      'Clonazepam (Rivotril)',
      'Chlordiazepoxide (Librium)',
      'Diazepam (Valium)',
    ],
    'Psychotherapy': [
      'Exposure Therapy'
    ]
  };

  _buildAgeTiles(BuildContext context) {
    return Column(
      children: <Widget>[
        for (MapEntry item in medList.entries)
          Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 10),
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    title: Text(item.key),
                    children: <Widget>[
                      for (String item2 in item.value)
                        if (item2 == 'No Routine Meds')
                          ListTile(title: Center(child: Text(item2)))
                        else
                          ListTile(
                            title: Text(item2),
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
                              MedicationDao.md.getMedByName(item2).then((med) {
                                if (med != null)
                                  Navigator.of(context).push(platformPageRoute(
                                      context: context,
                                      builder: (_) => MedProfilePage(med)));
                              })
                            },
                          )
                    ],
                  ))
            ],
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Phobia Disorder'),
        ),
        body: SingleChildScrollView(child: _buildAgeTiles(context)));
  }
}
