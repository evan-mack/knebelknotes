import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:easy_rich_text/easy_rich_text.dart';

//Add on tap to drug profile
//ADd trade name column

class ADHDChart extends StatelessWidget {
  _buildColumns() {
    return [
      DataColumn(
          label: Text('Meds', style: TextStyle(fontStyle: FontStyle.italic))),
      DataColumn(
          label: Text('Indications',
              style: TextStyle(fontStyle: FontStyle.italic))),
      DataColumn(
          label:
              Text('Initial', style: TextStyle(fontStyle: FontStyle.italic))),
      DataColumn(
          label: Text('Range, Max(per day)',
              style: TextStyle(fontStyle: FontStyle.italic))),
      DataColumn(
          label:
              Text('Half Life', style: TextStyle(fontStyle: FontStyle.italic))),
      DataColumn(
          label:
              Text('Duration', style: TextStyle(fontStyle: FontStyle.italic))),
    ];
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

  _buildRows(BuildContext context) {
    return [];
  }

  _buildRow(BuildContext context, String med, String ind, String init,
      String range, String halflife, String duration) {
    return [
      DataCell(Text(med)),
      DataCell(Text(ind)),
      DataCell(Text(init)),
      DataCell(Text(range)),
      DataCell(Text(halflife)),
      DataCell(Text(duration))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(title: Text('ADHD Med Comparison')),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  DataTable(
                    horizontalMargin: 10,
                    columns: [
                      DataColumn(
                          label: Text('Med',
                              style: TextStyle(fontStyle: FontStyle.italic))),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(
                          Text('Amphetamines',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text('Racemic',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        )
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('Adderall')),
                        )
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('Adderall XR')),
                        ),
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text('Dextro',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        )
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('Sulfate / Spansule')),
                        ),
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('Lisdexamfetamine (Vyvanse)')),
                        ),
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Text('Methylphenidate (MPH)',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('IR (Ritalin)')),
                        ),
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('XR (Biphentin)')),
                        ),
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('ER OROS (Concerta')),
                        ),
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Text('Other',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        )
                      ]),
                      DataRow(cells: [
                        DataCell(
                          Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text('Modafinil (Alertec)')),
                        ),
                      ]),
                    ],
                  ),
                  Expanded(
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              DataTable(
                                //Indications and initial
                                columns: [
                                  DataColumn(
                                      label: Text('Indications',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic))),
                                  DataColumn(
                                      label: Text('Initial',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic))),
                                ],
                                rows: [
                                  DataRow(
                                      cells: [DataCell.empty, DataCell.empty]),
                                  DataRow(
                                      cells: [DataCell.empty, DataCell.empty]),
                                  DataRow(cells: [
                                    DataCell(
                                      Text('ADHD (2' +
                                          _getSuperScript('nd') +
                                          ' line), narcolepsy'),
                                    ),
                                    DataCell(Text('5' +
                                        _getSuperScript('1') +
                                        _getSuperScript('-') +
                                        _getSuperScript('2'))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(
                                      Text('ADHD (1' +
                                          _getSuperScript('st') +
                                          ' line)'),
                                    ),
                                    DataCell(Text('10' + _getSuperScript('1'))),
                                  ]),
                                  DataRow(
                                      cells: [DataCell.empty, DataCell.empty]),
                                  DataRow(cells: [
                                    DataCell(
                                      Text('ADHD (2' +
                                          _getSuperScript('nd') +
                                          ' line), narcolepsy'),
                                    ),
                                    DataCell(Text('[2.5]' +
                                        _getSuperScript('2') +
                                        _getSuperScript('-') +
                                        _getSuperScript('3'))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(
                                      Text('ADHD (1' +
                                          _getSuperScript('st') +
                                          ' line)'),
                                    ),
                                    DataCell(Text('10')),
                                  ]),
                                  DataRow(
                                      cells: [DataCell.empty, DataCell.empty]),
                                  DataRow(cells: [
                                    DataCell(
                                      Text('ADHD (2' +
                                          _getSuperScript('nd') +
                                          ' line)'),
                                    ),
                                    DataCell(Text('5' +
                                        _getSuperScript('2') +
                                        _getSuperScript('-') +
                                        _getSuperScript('3'))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(
                                      Text('ADHD (1' +
                                          _getSuperScript('st') +
                                          ' line)'),
                                    ),
                                    DataCell(Text('10')),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(
                                      Text('ADHD (1' +
                                          _getSuperScript('st') +
                                          ' line)'),
                                    ),
                                    DataCell(Text('18')),
                                  ]),
                                  DataRow(
                                      cells: [DataCell.empty, DataCell.empty]),
                                  DataRow(cells: [
                                    DataCell(
                                      Text('Narcolepsy, MDE (2' +
                                          _getSuperScript('nd') +
                                          ' line)'),
                                    ),
                                    DataCell(
                                        Text('200' + _getSuperScript('1'))),
                                  ]),
                                ],
                              ),
                              DataTable(
                                horizontalMargin: 10,
                                columns: [
                                  DataColumn(
                                    label: Text('Range, Max (per day)'),
                                  ),
                                ],
                                rows: [
                                  DataRow(cells: [DataCell.empty]),
                                  DataRow(cells: [
                                    DataCell(
                                        Center(child: Text('For Amphetamines')))
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Center(child: Text('5-40 (ADHD)')))
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Center(
                                        child: Text('5-60 (narcolepsy)')))
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Center(
                                        child:
                                            Text('\u2191' + ' by 5-10/week')))
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Center(child: Text('Max 60 [30]')))
                                  ]),
                                  DataRow(cells: [DataCell.empty]),
                                  DataRow(cells: [DataCell.empty]),
                                  DataRow(cells: [
                                    DataCell(
                                        Center(child: Text('Max 100 [60]'))),
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Center(child: Text('Max 80 [60]')))
                                  ]),
                                  DataRow(cells: [
                                    DataCell(
                                        Center(child: Text('Max 108 [72]')))
                                  ]),
                                  DataRow(cells: [DataCell.empty]),
                                  DataRow(cells: [
                                    DataCell(
                                        Center(child: Text('200-400 Max 800')))
                                  ]),
                                ],
                              ),
                              DataTable(
                                columns: [
                                  DataColumn(label: Text('\u03BB' + ' life')),
                                  DataColumn(label: Text('Duration'))
                                ],
                                rows: [
                                  DataRow(cells: [
                                    DataCell.empty,
                                    DataCell.empty,
                                  ]),
                                  DataRow(cells: [
                                    DataCell.empty,
                                    DataCell.empty,
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('4h ' + '\u03BB')),
                                    DataCell(Text('4-6h'))
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('4h ' + '\u03BB')),
                                    DataCell(Text('4-6h'))
                                  ]),
                                  DataRow(cells: [
                                    DataCell.empty,
                                    DataCell.empty,
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('4h / 8h ' + '\u03BB')),
                                    DataCell(Text('3-6h / 8h'))
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('9.5h ' + '\u03BB')),
                                    DataCell(Text('13-14h'))
                                  ]),
                                  
                                  DataRow(cells: [
                                    DataCell.empty,
                                    DataCell.empty,
                                  ]),
                                  
                                  DataRow(cells: [
                                    DataCell(Text('4h ' + '\u03BB')),
                                    DataCell(Text('3-4h'))
                                  ]),
                                  
                                  DataRow(cells: [
                                    DataCell(Text('5.1h ' + '\u03BB')),
                                    DataCell(Text('10-12h'))
                                  ]),
                                  
                                  DataRow(cells: [
                                    DataCell(Text('12h ' + '\u03BB')),
                                    DataCell(Text('10-12h'))
                                  ]),
                                  
                                  DataRow(cells: [
                                    DataCell.empty,
                                    DataCell.empty,
                                  ]),
                                  DataRow(cells: [
                                    DataCell(Text('13-14h ' + '\u03BB')),
                                    DataCell(Text('Up to 8h'))
                                  ]),
                                ],
                              )
                            ],
                          )))
                ],
              ),
            ])));
  }
}
