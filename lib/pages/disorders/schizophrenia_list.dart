import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/med_profile_page.dart';

class SchizophreniaList extends StatelessWidget {
  var medList = {
    'Monotherapy': [
      'Haloperidol (Haldol)',
      'Flupenthixol (Fluanxol)',
      'Fluphenazine (Prolixin)',
      'Perphenazine (Trilafon)',
      'Prochloperazine',
      'Pericyazine (Neuleptil)',
      'Zuclopenthixol (Clopixol)',
      'Loxapine (Loxapac)',
      'Methotrimeprazine (Nozinan)',
      'Thioridazine',
      'Chlorprothixene',
      'Chlorpromazine (Largactil)',
      'Risperidone (Risperdal)',
      'Paliperidone (Invega)',
      'Olanzapine (Zyprexa)',
      'Ziprazadone (Zeldox)',
      'Clozapine (Clozaril)',
      'Quetiapine (Seroquel)',
      'Aripiprazole (Abilify)',
      'Brexpiprazole (Rexulti)',
      'Lurasidone (Latuda)',
      'Asenapine (Saphris)',
    ],
    'Psychotherapy': [
      'Family Intervention',
      'Cognitive Behavioral Therapy',
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
          title: Text('Schizophrenia'),
        ),
        body: SingleChildScrollView(child: _buildAgeTiles(context)));
  }
}
