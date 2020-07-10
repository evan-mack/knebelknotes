import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/med_profile_page.dart';

class AdjustmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        appBar: PlatformAppBar(
          title: Text('Adjustment Disorder'),
        ),
        body: Column(
          children: <Widget>[
            ListTile(title: Center(child: Text('Medications not recommended')))
          ],
        ));
  }
}
