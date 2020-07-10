import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/med_profile_page.dart';

//Static column for generic names

class MoodChart extends StatelessWidget {
  _buildDataRow(BuildContext context, String med, Icon gi, Icon sedation,
      Icon weight, Icon dizziness, String other,
      {bool kfSedation, bool kfWeight, bool kfDizz}) {
    return [
      DataCell(Text(med), onTap: () {
        MedicationDao.md.getMedByName(med).then((drug) {
          Navigator.of(context).push(platformPageRoute(
              context: context, builder: (_) => MedProfilePage(drug)));
        });
      }),
      DataCell(gi),
      DataCell(kfSedation != null
          ? Container(
              constraints: BoxConstraints.expand(),
              color: Colors.yellow[300],
              child: sedation)
          : Container(child: sedation)),
      DataCell(kfWeight != null
          ? Container(
              constraints: BoxConstraints.expand(),
              color: Colors.yellow[300],
              child: weight)
          : Container(child: weight)),
      DataCell(
        kfDizz != null
            ? Container(
                constraints: BoxConstraints.expand(),
                color: Colors.yellow[300],
                child: dizziness)
            : Container(child: dizziness),
      ),
      DataCell(Text(other))
    ];
  }
  _buildDataRow2(BuildContext context, String med, Icon thyroid, Icon panc,
      Icon wbc, Icon sj, Icon hep, String other,
      {bool kfThyroid, bool kfPanc, bool kfWBC, bool kfSJ, bool kfHep}) {
    return [
      DataCell(Text(med), onTap: () {
        MedicationDao.md.getMedByName(med).then((drug) {
          Navigator.of(context).push(platformPageRoute(
              context: context, builder: (_) => MedProfilePage(drug)));
        });
      }), 
      DataCell(kfThyroid != null
          ? Container(
              constraints: BoxConstraints.expand(),
              color: Colors.yellow[300],
              child: thyroid)
          : Container(child: thyroid)),
          
      DataCell(kfPanc != null
          ? Container(
              constraints: BoxConstraints.expand(),
              color: Colors.yellow[300],
              child: panc)
          : Container(child: panc)),
      DataCell(kfWBC != null
          ? Container(
              constraints: BoxConstraints.expand(),
              color: Colors.yellow[300],
              child: wbc)
          : Container(child: wbc)),
      DataCell(kfSJ != null
          ? Container(
              constraints: BoxConstraints.expand(),
              color: Colors.yellow[300],
              child: sj)
          : Container(child: sj)),
      DataCell(
        kfHep != null
            ? Container(
                constraints: BoxConstraints.expand(),
                color: Colors.yellow[300],
                child: hep)
            : Container(child: hep),
      ),
      DataCell(Text(other))
    ];
  }

  _buildDataRows(BuildContext context) {
    return [
      DataRow(
          cells: _buildDataRow(
              context,
              'Lithium',
              Icon(Icons.check),
              Icon(Icons.check),
              Icon(Icons.arrow_upward),
              Icon(Icons.clear),
              'Tremor',
              kfWeight: true)),
      DataRow(
          cells: _buildDataRow(
              context,
              'Valproate (Divalproex)',
              Icon(Icons.check),
              Icon(Icons.check),
              Icon(Icons.arrow_upward),
              Icon(Icons.check),
              '',
              kfSedation: true,
              kfWeight: true)),
      DataRow(
          cells: _buildDataRow(
              context,
              'Carbamazepine (tegretol)',
              Icon(Icons.check),
              Icon(Icons.check),
              Icon(Icons.arrow_downward),
              Icon(Icons.clear),
              'CNS',
              kfDizz: true)),
      DataRow(
          cells: _buildDataRow(
        context,
        'Lamotrigine (Lamictal)',
        Icon(Icons.check),
        Icon(Icons.clear),
        Icon(Icons.clear),
        Icon(Icons.check),
        'HA, diplopia',
      ))
    ];
  }

  _buildDataRows2(BuildContext context) {
    return [
      DataRow(
          cells: _buildDataRow2(
              context,
              'Lithium',
              Icon(Icons.check),
              Icon(Icons.clear),
              Icon(Icons.clear),
              Icon(Icons.clear),
              Icon(Icons.clear),
              'CRF, Li toxicity',
              kfThyroid: true
              )),
      DataRow(
          cells: _buildDataRow2(
              context,
              'Valproate (Divalproex)',
              Icon(Icons.clear),
              Icon(Icons.check),
              Icon(Icons.check),
              Icon(Icons.check),
              Icon(Icons.check),
              'Neural tube defects',
              kfPanc: true)),
      DataRow(
          cells: _buildDataRow2(
              context,
              'Carbamazepine (tegretol)',
              Icon(Icons.check),
              Icon(Icons.clear),
              Icon(Icons.check),
              Icon(Icons.check),
              Icon(Icons.check),
              'Neural tube defects',
              kfWBC: true)),
      DataRow(
          cells: _buildDataRow2(
        context,
        'Lamotrigine (Lamictal)',
        Icon(Icons.clear),
        Icon(Icons.clear),
        Icon(Icons.clear),
        Icon(Icons.check),
        Icon(Icons.clear),
        '',
        kfSJ: true,
      ))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(title: Text('Mood Stabilizer Table')),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
          children: <Widget>[
            
            Center(child: Text('Side Effects')),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(
                      label: Text('Drug',
                          style: TextStyle(fontStyle: FontStyle.italic))),
                  DataColumn(
                    label: Text('GI (N/V)',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text('Sedation',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text('Weight',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text('Dizziness',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text('Other',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                ],
                rows: _buildDataRows(context),
              ),
            ),
            Center(child: Text('Severe Effects')),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(
                    label: Text(
                      'Drug',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ),
                  DataColumn(
                      label: Row(children: <Widget>[
                    Icon(Icons.arrow_downward, size: 15,),
                    Text(
                      'Thyroid',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ])),
                  DataColumn(
                    label: Text('Pancreatitis',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                  
                  DataColumn(
                      label: Row(children: <Widget>[
                    Icon(Icons.arrow_downward, size: 15,),
                    Text(
                      'WBC',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  ])),
                  DataColumn(
                    label: Text('SJ Syndrome',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text('Hepatitis',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                  DataColumn(
                    label: Text('Other',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                ],
                rows: _buildDataRows2(context),
              ),
            ),
          ],
        )));
  }
}
