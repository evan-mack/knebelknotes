import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/data/medication.dart';

class MedProfilePage extends StatefulWidget {
  final Medication med;
  MedProfilePage(this.med);
  createState() => MedProfilePageState();
}

class MedProfilePageState extends State<MedProfilePage> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        material: (_,__) => MaterialAppBarData(
          centerTitle: true
        ),
        cupertino: (_,__) => CupertinoNavigationBarData( 
          previousPageTitle: 'Meds'
        ),
        title: Column(
          children: <Widget>[
            Text(widget.med.medName),
            widget.med.subCat != ""
                ? Text(
                    widget.med.subCat + ' ' + widget.med.cat,
                    style: TextStyle(fontSize: 14),
                  )
                : Text(widget.med.cat)
          ],
        ),
      ),
    );
  }
}
