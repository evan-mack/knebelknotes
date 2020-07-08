import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:knebelknotes/pages/med_profile_page.dart';
import 'package:knebelknotes/data/medication_dao.dart';


class BenzoComparison extends StatelessWidget {
  List<String> titleColumn = [
    'Equiv.',
    'Avg. Range',
    'Max / Day',
    'Onset',
    'Half Life (Duration)'
  ];
  List<String> titleRow = [
    'Oxazepam (Serax)',
    'Alprazolam (Xanax)',
    'Lorazepam (Ativan)',
    'Clonazepam (Rivotril)',
    'Chlordiazepoxide (Librium)',
    'Diazepam (Valium)'
  ];
  List<List<String>> tableData = [
    ['15', '0.5', '1', '0.25', '10', '5'],
    [
      '15-60 Divided',
      '0.5-4 Divided',
      '0.5-6 Divided',
      '0.5-6 HS-BID',
      '5-40 Divided',
      '5-40 Divided'
    ],
    ['120', '10', '10', '-', '100', '100'],
    [
      'slow',
      'intermediate',
      'intermediate',
      'intermediate',
      'intermediate',
      'fast'
    ],
    [
      '4-15 (short)',
      '12-15 (short)',
      '10-20 (intermediate)',
      '20-50 (long)',
      '100 (long)',
      '100 (long)'
    ]
  ];
/*StickyHeadersTable(
        columnsLength: titleColumn.length,
        rowsLength: titleRow.length,
        columnsTitleBuilder: (i) => Text(titleColumn[i]),
        rowsTitleBuilder: (i) => Text(titleRow[i]),
        contentCellBuilder: (i, j) => Text(tableData[i][j]),
        legendCell: Text('Drug'),
      )*/
  _buildDataColumn() {
    return [
      DataColumn(
        label: Text(
          'Equiv.',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Avg. Range',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Max Dose/Day',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Onset',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Half Life (Duration)',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      )
    ];
  }

  _buildDataRow(BuildContext context) {
    return [
      DataRow(cells: [
        DataCell(Text('15')),
        DataCell(Text('15-60 Divided')),
        DataCell(Text('120')),
        DataCell(Text('slow')),
        DataCell(Text('4-15 (short)')),
      ]),
      DataRow(cells: [
        DataCell(Text('0.5')),
        DataCell(Text('0.5-4 Divided')),
        DataCell(Text('10')),
        DataCell(Text('intermediate')),
        DataCell(Text('12-15 (short)')),
      ]),
      DataRow(cells: [
        DataCell(Text('1')),
        DataCell(Text('0.5-6 Divided')),
        DataCell(Text('10')),
        DataCell(Text('intermediate')),
        DataCell(Text('10-15 (intermediate)')),
      ]),
      DataRow(cells: [
        DataCell(Text('0.25')),
        DataCell(Text('0.5-6 HS-BID')),
        DataCell(Text('-')),
        DataCell(Text('intermediate')),
        DataCell(Text('20-50 (long)')),
      ]),
      DataRow(cells: [
        DataCell(Text('10')),
        DataCell(Text('5-40 Divided')),
        DataCell(Text('100')),
        DataCell(Text('intermediate')),
        DataCell(Text('100 (long)')),
      ]),
      DataRow(cells: [
        DataCell(Text('5')),
        DataCell(Text('5-40 Divided')),
        DataCell(Text('100')),
        DataCell(Text('fast')),
        DataCell(Text('100 (long)')),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(title: Text('Benzodiazpines Table')),
      body: Row(
        children: <Widget>[
          DataTable(columns: [
            DataColumn(
              label: Text(
                'Drug',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ], rows: [
            DataRow(cells: [
              DataCell(Text('Oxazepam (Serax)'), onTap: () {
                MedicationDao.md.getMedByName('Oxazepam (Serax)').then((med) {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => MedProfilePage(med)));
                });
              }),
            ]),
            DataRow(cells: [
              DataCell(Text('Alprazolam (Xanax)'), onTap: () {
                MedicationDao.md.getMedByName('Alprazolam (Xanax)').then((med) {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => MedProfilePage(med)));
                });
              }),
            ]),
            DataRow(cells: [
              DataCell(Text('Lorazepam (Ativan)'), onTap: () {
                MedicationDao.md.getMedByName('Lorazepam (Ativan)').then((med) {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => MedProfilePage(med)));
                });
              }),
            ]),
            DataRow(cells: [
              DataCell(Text('Clonazepam (Rivotril)'), onTap: () {
                MedicationDao.md
                    .getMedByName('Clonazepam (Rivotril)')
                    .then((med) {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => MedProfilePage(med)));
                });
              }),
            ]),
            DataRow(cells: [
              DataCell(Text('Chlordiazepoxide (Librium)'), onTap: () {
                MedicationDao.md
                    .getMedByName('Chlordiazepoxide (Librium)')
                    .then((med) {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => MedProfilePage(med)));
                });
              }),
            ]),
            DataRow(cells: [
              DataCell(Text('Diazepam (Valium)'), onTap: () {
                MedicationDao.md.getMedByName('Diazepam (Valium)').then((med) {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => MedProfilePage(med)));
                });
              }),
            ]),
          ]),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: _buildDataColumn(),
                rows: _buildDataRow(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
