import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/med_profile_page.dart';
import 'package:knebelknotes/pages/comparison_tables/custom_table.dart';

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
          : Container(constraints: BoxConstraints.expand(), child: sedation)),
      DataCell(kfWeight != null
          ? Container(
              constraints: BoxConstraints.expand(width: 36),
              color: Colors.yellow[300],
              child: weight)
          : Container(constraints: BoxConstraints.expand(), child: weight)),
      DataCell(
        kfDizz != null
            ? Container(
                constraints: BoxConstraints.expand(),
                color: Colors.yellow[300],
                child: dizziness)
            : Container(constraints: BoxConstraints.expand(), child: dizziness),
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
              kfThyroid: true)),
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

  Widget _backgroundColor() {
    return Container();
  }

  List<String> sideEffectColumns = [
    'GI (N/V)',
    'Sedation',
    'Weight',
    'Dizziness',
    'Other'
  ];

  List<String> rowTitles = [
    'Lithium',
    'Valproate (Divalproex)',
    'Carbamazepine (tegretol)',
    'Lamotrigine (Lamictal)',
  ];

  List<List<Widget>> sideEffectsRowData = [
    [
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.check)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.check)),
      Container(
          constraints: BoxConstraints.expand(),
          color: Colors.yellow[300],
          child: Icon(Icons.arrow_upward)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.clear)),
      Container(constraints: BoxConstraints.expand(), child: Text('Tremor'))
    ],
    [
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.check)),
      Container(
          constraints: BoxConstraints.expand(),
          color: Colors.yellow[300],
          child: Icon(Icons.check)),
      Container(
          constraints: BoxConstraints.expand(),
          color: Colors.yellow[300],
          child: Icon(Icons.arrow_upward)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.check)),
      Text(''),
    ],
    [
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.check)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.check)),
      Container(
          constraints: BoxConstraints.expand(),
          child: Icon(Icons.arrow_downward)),
      Container(
          constraints: BoxConstraints.expand(),
          color: Colors.yellow[300],
          child: Icon(Icons.check)),
      Text('CNS'),
    ],
    [
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.check)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.clear)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.clear)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.check)),
      Text('HA, diplopia'),
    ]
  ];

  List<List<Widget>> severeEffectsRowData = [
    [
      Container(
          constraints: BoxConstraints.expand(),
          color: Colors.yellow[300],
          child: Icon(Icons.check)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.clear)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.clear)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.clear)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.clear)),
      Container(
          constraints: BoxConstraints.expand(), child: Text('CRG, Li toxicity'))
    ],
    [
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.clear)),
      Container(
          constraints: BoxConstraints.expand(),
          decoration:
              BoxDecoration(color: Colors.yellow[300], border: Border.all()),
          child: Icon(Icons.check)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.check)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.check)),
      Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(border: Border.all()),
          child: Icon(Icons.check)),
      Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(border: Border.all()),
          child: Text('Neural tube defects'))
    ],
    [
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.check)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.clear)),
      Container(
          constraints: BoxConstraints.expand(),
          decoration:
              BoxDecoration(color: Colors.yellow[300], border: Border.all()),
          child: Icon(Icons.check)),
      Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(border: Border.all()),
          child: Icon(Icons.check)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.check)),
      Container(
          constraints: BoxConstraints.expand(),
          child: Text('Neural tube defects'))
    ],
    [
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.clear)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.clear)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.clear)),
      Container(
          constraints: BoxConstraints.expand(),
          decoration:
              BoxDecoration(color: Colors.yellow[300], border: Border.all()),
          child: Icon(Icons.check)),
      Container(constraints: BoxConstraints.expand(), child: Icon(Icons.clear)),
      Container(constraints: BoxConstraints.expand(), child: Text(''))
    ],
  ];

  List<String> severeEffectColumns = [
    '\u2193 thyroid',
    'Pancreatitis',
    '\u2193 WBC',
    'SJ Syndrome',
    'Hepatitis',
    'Other'
  ];
  _buildBody() {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Center(child: Text('Side Effects')),
            CustomTable(rowTitles, sideEffectColumns, sideEffectsRowData),
            Center(child: Text('Severe Effects')),
            CustomTable(rowTitles, severeEffectColumns, severeEffectsRowData),
            Container(
                height: 40,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.check),
                    Text('= Yes'),
                    VerticalDivider(),
                    Icon(Icons.clear),
                    Text('= No'),
                    VerticalDivider(),
                    Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Text('')),
                    Text('= Black Box Warning'),
                    VerticalDivider(),
                    Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(color: Colors.yellow[300]),
                        child: Text('')),
                    Divider(
                      thickness: 3,
                    ),
                    Text('= Known For'),
                  ],
                )),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(title: Text('Mood Stabilizer Table')),
      body: _buildBody(),
    );
  }
}
// SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Column(
//               children: <Widget>[
//                 Center(child: Text('Side Effects')),
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                     columns: [
//                       DataColumn(
//                           label: Text('Drug',
//                               style: TextStyle(fontStyle: FontStyle.italic))),
//                       DataColumn(
//                         label: Text('GI (N/V)',
//                             style: TextStyle(fontStyle: FontStyle.italic)),
//                       ),
//                       DataColumn(
//                         label: Text('Sedation',
//                             style: TextStyle(fontStyle: FontStyle.italic)),
//                       ),
//                       DataColumn(
//                         label: Text('Weight',
//                             style: TextStyle(fontStyle: FontStyle.italic)),
//                       ),
//                       DataColumn(
//                         label: Text('Dizziness',
//                             style: TextStyle(fontStyle: FontStyle.italic)),
//                       ),
//                       DataColumn(
//                         label: Text('Other',
//                             style: TextStyle(fontStyle: FontStyle.italic)),
//                       ),
//                     ],
//                     rows: _buildDataRows(context),
//                   ),
//                 ),
//                 Center(child: Text('Severe Effects')),
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                     columns: [
//                       DataColumn(
//                         label: Text(
//                           'Drug',
//                           style: TextStyle(fontStyle: FontStyle.italic),
//                         ),
//                       ),
//                       DataColumn(
//                           label: Row(children: <Widget>[
//                         Icon(
//                           Icons.arrow_downward,
//                           size: 15,
//                         ),
//                         Text(
//                           'Thyroid',
//                           style: TextStyle(fontStyle: FontStyle.italic),
//                         ),
//                       ])),
//                       DataColumn(
//                         label: Text('Pancreatitis',
//                             style: TextStyle(fontStyle: FontStyle.italic)),
//                       ),
//                       DataColumn(
//                           label: Row(children: <Widget>[
//                         Icon(
//                           Icons.arrow_downward,
//                           size: 15,
//                         ),
//                         Text(
//                           'WBC',
//                           style: TextStyle(fontStyle: FontStyle.italic),
//                         ),
//                       ])),
//                       DataColumn(
//                         label: Text('SJ Syndrome',
//                             style: TextStyle(fontStyle: FontStyle.italic)),
//                       ),
//                       DataColumn(
//                         label: Text('Hepatitis',
//                             style: TextStyle(fontStyle: FontStyle.italic)),
//                       ),
//                       DataColumn(
//                         label: Text('Other',
//                             style: TextStyle(fontStyle: FontStyle.italic)),
//                       ),
//                     ],
//                     rows: _buildDataRows2(context),
//                   ),
//                 ),
//               ],
//             ))
