import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:knebelknotes/pages/med_profile_page2.dart';
import 'package:knebelknotes/data/medication_dao.dart';

class CustomTable extends StatelessWidget {
  final List<String> rowTitles;
  final List<String> columns;
  final List<List<Widget>> rows;
  final Function navigate;

  final ScrollController _scrollController = ScrollController(initialScrollOffset: 50);
  CustomTable(this.rowTitles, this.columns, this.rows, {this.navigate});

  _buildMedNameRow(String med) {
    return DataRow(cells: [
      DataCell(Align(
          alignment: Alignment.topLeft,
          child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[300],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(med,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white))))))
    ]);
  }

  _getMedNames() {
    return IgnorePointer(
        child: DataTable(
      horizontalMargin: 10,
      dividerThickness: 0,
      dataRowHeight: 50,
      headingRowHeight: 30,
      columns: [
        DataColumn(label: Text('')),
      ],
      rows: [for (var title in rowTitles) _buildMedNameRow(title)],
    ));
  }

  DataRow _buildTableRow(BuildContext context, List<Widget> items, int currentRow) {
    List<DataCell> result = [];
    for (int i = 0; i < items.length; i++) {
      result.add(DataCell(
          Padding(padding: EdgeInsets.only(top: 15), child: items[i]),
          onTap: () {
                      MedicationDao.md
                          .getMedByName(rowTitles[currentRow])
                          .then((med) {
                        Navigator.of(context).push(platformPageRoute(
                            context: context,
                            builder: (_) => MedProfilePage(med)));
                      });
                    }),);
    }
    return DataRow(cells: result);
  }

  _getTableData(BuildContext context) {
    List<DataRow> result = [];
    for (int i = 0; i < rows.length; i++) {
      result.add(_buildTableRow(context, rows[i], i));
    }
    return result;
  }

  _tableBody(BuildContext context) {
    return Scrollbar(
        controller: _scrollController,
        child: DataTable(
            columnSpacing: 20,
            dividerThickness: 0,
            dataRowHeight: 50,
            horizontalMargin: 36,
            headingRowHeight: 30,
            columns: [
              for (var column in columns) DataColumn(label: Text(column))
            ],
            rows: _getTableData(context)));
  }

  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Stack(
          children: <Widget>[
            SingleChildScrollView(
                scrollDirection: Axis.horizontal, child: _tableBody(context)),
            _getMedNames(),
          ],
        ))
      ],
    );
  }
}
