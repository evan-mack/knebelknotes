import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/med_profile_page2.dart';

class AntipsychoticEquiv extends StatelessWidget {
  _buildDataColumn(int i) {
    return [
      DataColumn(
        label: Text(
          i == 0 ?
          'Typical' : 'ATypical',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      DataColumn(
        label: Text(
          'Equivalency',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
    ];
  }

  _buildDataRow(BuildContext context, String med, String equiv) {
    return [
      DataCell(Text(med), onTap: () {
        MedicationDao.md.getMedByName(med).then((drug) {
          Navigator.of(context).push(platformPageRoute(
              context: context, builder: (_) => MedProfilePage(drug)));
        });
      }),
      DataCell(Text(equiv))
    ];
  }

  _buildDataRows(BuildContext context) {
    return [
      DataRow(cells: _buildDataRow(context, 'Haloperidol (Haldol)', '2.5')),
      DataRow(cells: _buildDataRow(context, 'Flupenthixol (Fluanxol)', '2.5')),
      DataRow(cells: _buildDataRow(context, 'Fluphenazine (Prolixin)', '3')),
      DataRow(cells: _buildDataRow(context, 'Perphenazine (Trilafon)', '7.5')),
      DataRow(cells: _buildDataRow(context, 'Prochloperazine', '15')),
      DataRow(cells: _buildDataRow(context, 'Pericyazine (Neuleptil)', '12.5')),
      DataRow(
          cells: _buildDataRow(context, 'Zuclopenthixol (Clopixol)', '12.5')),
      DataRow(cells: _buildDataRow(context, 'Loxapine (Loxapac)', '15')),
      DataRow(
          cells: _buildDataRow(context, 'Methotrimeprazine (Nozinan)', '75')),
      DataRow(
          cells: _buildDataRow(context, 'Chlorpromazine (Largactil)', '150')),
    ];
  }

_buildDataRows2(BuildContext context) {
    return [
      DataRow(cells: _buildDataRow(context, 'Risperidone (Risperdal)', '1.5')),
      DataRow(cells: _buildDataRow(context, 'Paliperidone (Invega)', '2')),
      DataRow(cells: _buildDataRow(context, 'Olanzapine (Zyprexa)', '5')),
      DataRow(cells: _buildDataRow(context, 'Ziprazadone (Zeldox)', '60')),
      DataRow(cells: _buildDataRow(context, 'Clozapine (Clozaril)', '100')),
      DataRow(cells: _buildDataRow(context, 'Quetiapine (Seroquel)', '75')),
      DataRow(
          cells: _buildDataRow(context, 'Aripiprazole (Abilify)', '7.5')),
      DataRow(cells: _buildDataRow(context, 'Brexpiprazole (Rexulti)', '-')),
      DataRow(
          cells: _buildDataRow(context, 'Lurasidone (Latuda)', '20')),
      DataRow(
          cells: _buildDataRow(context, 'Asenapine (Saphris)', '5')),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Antipsychotics Equiv. Comparison'), centerTitle: true,),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DataTable(
                columns: _buildDataColumn(0),
                rows: _buildDataRows(context),
              ),
              DataTable(
                columns: _buildDataColumn(1),
                rows: _buildDataRows2(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
