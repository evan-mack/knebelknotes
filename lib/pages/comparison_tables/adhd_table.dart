import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:easy_rich_text/easy_rich_text.dart';

//Add on tap to drug profile
//ADd trade name column

class ADHDChart extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    if (_scrollController.hasClients) _scrollController.jumpTo(50.0);
  }

  _getSuperScript(String ss) {
    switch (ss) {
      case 'nd':
        return '\u207f\u1d48';
        break;
      case 'st':
        return '\u02e2\u1d57';
        break;
      case '1':
        return '\u00b9';
        break;
      case '-':
        return '\u207b';
        break;
      case '2':
        return '\u00B2';
        break;
      case '3':
        return '\u00B3';
        break;
      default:
    }
  }

  _getColumns3() {
    return DataTable(
        dividerThickness: 0,
        dataRowHeight: 50,
        horizontalMargin: 36,
        headingRowHeight: 30,
        columns: [
          DataColumn(label: Text('\u03BB' + ' life')),
          DataColumn(label: Text('Duration'))
        ],
        rows: [
          _buildTableRow([Text('4h ' + '\u03BB'), Text('4-6h')]),
          _buildTableRow([Text('4h ' + '\u03BB'), Text('4-6h')]),
          _buildTableRow([Text('4h / 8h ' + '\u03BB'), Text('3-6h / 8h')]),
          _buildTableRow([Text('9.5h ' + '\u03BB'), Text('13-14h')]),
          _buildTableRow([Text('4h ' + '\u03BB'), Text('3-4h')]),
          _buildTableRow([Text('5.1h ' + '\u03BB'), Text('10-12h')]),
          _buildTableRow([Text('12h ' + '\u03BB'), Text('10-12h')]),
          _buildTableRow([Text('13-14h ' + '\u03BB'), Text('Up to 8h')]),
        ]);
  }

  _getColumns2() {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        DataTable(
          dividerThickness: 0,
          headingRowHeight: 30,
          dataRowHeight: 200,
          columns: [
            DataColumn(label: Text('Range, Max (Per Day)')),
          ],
          rows: [
            DataRow(cells: [
              DataCell(
                Container(
                  decoration: BoxDecoration(border: Border.all(width: 0.2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text('5-40 (ADHD)'),
                      ),
                      Center(
                        child: Text('5-60 (narcolepsy)'),
                      ),
                      Center(
                        child: Text(' by 5-10/week'),
                      ),
                      Center(
                        child: Text('Max 60 [30]'),
                      )
                    ],
                  ),
                ),
              )
            ])
          ],
        ),
        DataTable(
            dividerThickness: 0,
            headingRowHeight: 230,
            dataRowHeight: 50,
            columns: [
              DataColumn(label: Text('')),
            ],
            rows: [
              _buildTableRow([Text('max 100 [60]')]),
              _buildTableRow([Text('max 80 [60]')]),
              _buildTableRow([Text('max 108 [72]')]),
              _buildTableRow([Text('200-400 -- Max 800')])
            ])
      ],
    );
  }

  _getColumns1() {
    return DataTable(
        dividerThickness: 0,
        dataRowHeight: 50,
        horizontalMargin: 36,
        headingRowHeight: 30,
        columns: [
          DataColumn(label: Text('Indications')),
          DataColumn(label: Text('Initial')),
        ],
        rows: _getTableIndications());
  }

  _buildMedNameRow(String med) {
    return DataRow(cells: [
      DataCell(Align(
          alignment: Alignment.topLeft,
          child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
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
      rows: [
        _buildMedNameRow('Adderall'),
        _buildMedNameRow('Adderall XR'),
        _buildMedNameRow('Sulfate/Spansule'),
        _buildMedNameRow('Lisdexamfetamine (Vyvanse)'),
        _buildMedNameRow('IR (Ritalin)'),
        _buildMedNameRow('XR (Biphentin)'),
        _buildMedNameRow('ER OROS (Concerta)'),
        _buildMedNameRow('Modafinil (Alertec)'),
      ],
    ));
  }

  _getTableGrouping() {
    double rowHeight = 50;
    double ampHeight = rowHeight * 4;
    double mphHeight = rowHeight * 3;
    double otherheight = rowHeight;

    return [
      Container(
        height: 30,
      ),
      Row(
        children: <Widget>[
          Container(
            height: ampHeight,
            width: 25,
            decoration: BoxDecoration(border: Border.all()),
            child: RotatedBox(
              quarterTurns: 3,
              child: Center(
                child: Text('Amphetamines'),
              ),
            ),
          ),
          Column(children: [
            Container(
              height: ampHeight / 2,
              width: 25,
              decoration: BoxDecoration(border: Border.all()),
              child: RotatedBox(
                quarterTurns: 3,
                child: Center(
                  child: Text('Racemic'),
                ),
              ),
            ),
            Container(
              height: ampHeight / 2,
              width: 25,
              decoration: BoxDecoration(border: Border.all()),
              child: RotatedBox(
                quarterTurns: 3,
                child: Center(
                  child: Text('Dextro'),
                ),
              ),
            ),
          ])
        ],
      ),
      Container(
        height: mphHeight,
        width: 50,
        decoration: BoxDecoration(border: Border.all()),
        child: RotatedBox(
          quarterTurns: 3,
          child: Center(
            child: Text(
              'Methylphenidate (MPH)',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      Container(
        height: otherheight,
        width: 50,
        decoration: BoxDecoration(border: Border.all()),
        child: RotatedBox(
          quarterTurns: 3,
          child: Center(
            child: Text('Other'),
          ),
        ),
      ),
    ];
  }

  DataRow _buildTableRow(List<Widget> items) {
    List<DataCell> result = [];
    for (int i = 0; i < items.length; i++) {
      result.add(DataCell(
          Padding(padding: EdgeInsets.only(top: 15), child: items[i])));
    }
    return DataRow(cells: result);
  }

  _getTableIndications() {
    return [
      _buildTableRow([
        Text('ADHD (2' + _getSuperScript('nd') + ' line), narcolepsy'),
        Text('5' +
            _getSuperScript('1') +
            _getSuperScript('-') +
            _getSuperScript('2'))
      ]),
      _buildTableRow([
        Text('ADHD (1' + _getSuperScript('st') + ' line)'),
        Text('10' + _getSuperScript('1'))
      ]),
      _buildTableRow([
        Text('ADHD (2' + _getSuperScript('nd') + ' line), narcolepsy'),
        Text('[2.5]' +
            _getSuperScript('2') +
            _getSuperScript('-') +
            _getSuperScript('3'))
      ]),
      _buildTableRow(
          [Text('ADHD (1' + _getSuperScript('st') + ' line)'), Text('10')]),
      _buildTableRow([
        Text('ADHD (2' + _getSuperScript('nd') + ' line)'),
        Text('5' +
            _getSuperScript('2') +
            _getSuperScript('-') +
            _getSuperScript('3'))
      ]),
      _buildTableRow(
          [Text('ADHD (1' + _getSuperScript('st') + ' line)'), Text('10')]),
      _buildTableRow(
          [Text('ADHD (1' + _getSuperScript('st') + ' line)'), Text('18')]),
      _buildTableRow([
        Text('Narcolepsy, MDE (2' + _getSuperScript('nd') + ' line)'),
        Text('200' + _getSuperScript('1'))
      ])
    ];
  }

  _table() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          children: _getTableGrouping(),
        ),
        Expanded(
            child: Stack(
          children: <Widget>[
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    _getColumns1(),
                    _getColumns2(),
                    _getColumns3()
                  ],
                )),
            _getMedNames(),
          ],
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ADHD Med Comparison'),centerTitle: true, ),
        body: Scrollbar(
            isAlwaysShown: true,
            controller: _scrollController,
            child: _table()));
  }
}
