import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:knebelknotes/pages/med_profile_page.dart';
import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/comparison_tables/custom_table.dart';

class BenzoComparison extends StatelessWidget {
  List<String> rowTitle = [
    'Oxazepam (Serax)',
    'Alprazolam (Xanax)',
    'Lorazepam (Ativan)',
    'Clonazepam (Rivotril)',
    'Chlordiazepoxide (Librium)',
    'Diazepam (Valium)'
  ];

  List<String> columns = [
    'Equiv.',
    'Avg. Range',
    'Max / Day',
    'Onset',
    'Half Life (Duration)'
  ];

  List<List<Widget>> rows = [
    [
      Text('15'),
      Text('15-60 Divided'),
      Text('120'),
      Text('slow'),
      Text('4-15 (short)'),
    ],
    [
      Text('0.5'),
      Text('0.5-4 Divided'),
      Text('10'),
      Text('intermediate'),
      Text('12-15 (short)'),
    ],
    [
      Text('1'),
      Text('0.5-6 Divided'),
      Text('10'),
      Text('intermediate'),
      Text('10-20 (intermediate)'),
    ],
    [
      Text('0.25'),
      Text('0.5-6 HS-BID'),
      Text('-'),
      Text('intermediate'),
      Text('20-50 (long)'),
    ],
    [
      Text('10'),
      Text('5-40 Divided'),
      Text('100'),
      Text('intermediate'),
      Text('100 (long)'),
    ],
    [
      Text('5'),
      Text('5-40 Divided'),
      Text('100'),
      Text('fast'),
      Text('100 (long)'),
    ]
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Benzodiazpines Table'), centerTitle: true,),
        body: CustomTable(rowTitle, columns, rows));
  }
}
