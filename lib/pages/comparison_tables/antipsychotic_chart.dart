import 'package:flutter/material.dart';
import 'package:knebelknotes/data/medication_dao.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/pages/med_profile_page.dart';

class AntipsychoticChart extends StatelessWidget {
  _buildLeftSide() {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.arrow_upward),
              Icon(Icons.arrow_upward),
              Icon(Icons.arrow_upward),
            ],
          ),
          Text(''),
          Text(''),
          Text('Side Effect'),
          Text('Spectrum From'),
          Text('High to Low'),
          Text('Potency'),
          Text(''),
          Text(''),
          Row(
            children: <Widget>[
              Icon(Icons.arrow_downward),
              Icon(Icons.arrow_downward),
              Icon(Icons.arrow_downward),
            ],
          ),
        ],
      ),
    );
  }

  _buildRigtSide(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ListTile(
            title: Text('Haloperidol (Haldol)'),
            trailing: Icon(Icons.navigate_next),
            dense: true,
            onTap: () {
              MedicationDao.md.getMedByName('Haloperidol (Haldol)').then((med) {
                Navigator.of(context).push(platformPageRoute(
                    context: context, builder: (_) => MedProfilePage(med)));
              });
            }),
        ListTile(
            title: Text('Flupenthixol (Fluanxol)'),
            trailing: Icon(Icons.navigate_next),
            dense: true,
            onTap: () {
              MedicationDao.md
                  .getMedByName('Flupenthixol (Fluanxol)')
                  .then((med) {
                Navigator.of(context).push(platformPageRoute(
                    context: context, builder: (_) => MedProfilePage(med)));
              });
            }),
        ListTile(
            title: Text('Fluphenazine (Prolixin)'),
            trailing: Icon(Icons.navigate_next),
            dense: true,
            onTap: () {
              MedicationDao.md
                  .getMedByName('Fluphenazine (Prolixin)')
                  .then((med) {
                Navigator.of(context).push(platformPageRoute(
                    context: context, builder: (_) => MedProfilePage(med)));
              });
            }),
        ListTile(
            title: Text('Perphenazine (Trilafon)'),
            trailing: Icon(Icons.navigate_next),
            dense: true,
            onTap: () {
              MedicationDao.md
                  .getMedByName('Perphenazine (Trilafon)')
                  .then((med) {
                Navigator.of(context).push(platformPageRoute(
                    context: context, builder: (_) => MedProfilePage(med)));
              });
            }),
        ListTile(
            title: Text('Prochloperazine'),
            trailing: Icon(Icons.navigate_next),
            dense: true,
            onTap: () {
              MedicationDao.md.getMedByName('Prochloperazine').then((med) {
                Navigator.of(context).push(platformPageRoute(
                    context: context, builder: (_) => MedProfilePage(med)));
              });
            }),
        ListTile(
            title: Text('Pericyazine (Neuleptil)'),
            trailing: Icon(Icons.navigate_next),
            dense: true,
            onTap: () {
              MedicationDao.md
                  .getMedByName('Pericyazine (Neuleptil)')
                  .then((med) {
                Navigator.of(context).push(platformPageRoute(
                    context: context, builder: (_) => MedProfilePage(med)));
              });
            }),
        ListTile(
            title: Text('Zuclopenthixol (Clopixol)'),
            trailing: Icon(Icons.navigate_next),
            dense: true,
            onTap: () {
              MedicationDao.md
                  .getMedByName('Zuclopenthixol (Clopixol)')
                  .then((med) {
                Navigator.of(context).push(platformPageRoute(
                    context: context, builder: (_) => MedProfilePage(med)));
              });
            }),
        ListTile(
            title: Text('Loxapine (Loxapac)'),
            trailing: Icon(Icons.navigate_next),
            dense: true,
            onTap: () {
              MedicationDao.md.getMedByName('Loxapine (Loxapac)').then((med) {
                Navigator.of(context).push(platformPageRoute(
                    context: context, builder: (_) => MedProfilePage(med)));
              });
            }),
        ListTile(
            title: Text('Methotrimeprazine (Nozinan)'),
            trailing: Icon(Icons.navigate_next),
            dense: true,
            onTap: () {
              MedicationDao.md
                  .getMedByName('Methotrimeprazine (Nozinan)')
                  .then((med) {
                Navigator.of(context).push(platformPageRoute(
                    context: context, builder: (_) => MedProfilePage(med)));
              });
            }),
        ListTile(
            title: Text('Chlorpromazine (Largactil)'),
            trailing: Icon(Icons.navigate_next),
            dense: true,
            onTap: () {
              MedicationDao.md
                  .getMedByName('Chlorpromazine (Largactil)')
                  .then((med) {
                Navigator.of(context).push(platformPageRoute(
                    context: context, builder: (_) => MedProfilePage(med)));
              });
            }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: Text('Antiphsycotic Comparison'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[300],
                border: Border(
                  bottom: BorderSide(width: 1),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'EPS: acute dystonia, parkinsonism, akithisia, tardive dyskiniesia',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue[300], Colors.yellow[300]],
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    _buildLeftSide(),
                    VerticalDivider(),
                    Expanded(child: _buildRigtSide(context))
                  ],
                )),
            Container(
              decoration: BoxDecoration(
                color: Colors.yellow[300],
                border: Border(
                  top: BorderSide(width: 1),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'Anti-cholinergic, Anti-adrenergic, Anti-histamine',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
