import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/data/medication.dart';
import 'package:knebelknotes/pages/comparison_tables/adhd_table.dart';
import 'package:knebelknotes/pages/comparison_tables/antipsychotic_chart.dart';
import 'package:knebelknotes/pages/comparison_tables/antipsychotic_equiv_table.dart';
import 'package:knebelknotes/pages/comparison_tables/benzo_comparison.dart';
import 'package:knebelknotes/pages/comparison_tables/mood_stabilizertable.dart';

//TODO
//Add links to comparison charts

class MedProfilePage extends StatefulWidget {
  final Medication med;
  MedProfilePage(this.med);
  createState() => MedProfilePageState();
}

class MedProfilePageState extends State<MedProfilePage> {
  doseProfile2(String title, String content) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black))),
      child: ListTile(
        title: Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 4,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Text(
              content,
              textAlign: TextAlign.center,
            )
          ],
        ),
        dense: true,
      ),
    );
  }

  doseProfile(String title, String content, int size, {String comment}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: (MediaQuery.of(context).size.width - 30) / size,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(9),
                    topRight: Radius.circular(9),
                  ),
                ),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 40,
                ),
                child: Center(
                  child: Text(
                    content,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getADHDChart() {
    return ListTile(
      title: Text('Comparison Chart'),
      trailing: Icon(Icons.navigate_next),
      onTap: () => Navigator.of(context).push(
        platformPageRoute(context: context, builder: (_) => ADHDChart()),
      ),
    );
  }

  _getMoodChart() {
    return ListTile(
      title: Text('Comparison Chart'),
      trailing: Icon(Icons.navigate_next),
      onTap: () => Navigator.of(context).push(
        platformPageRoute(context: context, builder: (_) => MoodChart()),
      ),
    );
  }

  _getBenzoChart() {
    return ListTile(
      title: Text('Comparison Chart'),
      trailing: Icon(Icons.navigate_next),
      onTap: () => Navigator.of(context).push(
        platformPageRoute(context: context, builder: (_) => BenzoComparison()),
      ),
    );
  }

  _getAntipsychoticChart() {
    return ListTile(
      title: Text('Comparison Chart'),
      trailing: Icon(Icons.navigate_next),
      onTap: () => Navigator.of(context).push(
        platformPageRoute(
            context: context, builder: (_) => AntipsychoticChart()),
      ),
    );
  }

  _getEquivChart() {
    return ListTile(
      title: Text('Equivalency Chart'),
      trailing: Icon(Icons.navigate_next),
      onTap: () => Navigator.of(context).push(
        platformPageRoute(
            context: context, builder: (_) => AntipsychoticEquiv()),
      ),
    );
  }

  _getBlackBoxWarning() {
    return ExpansionTile(
      title: Text('Black Box Warning', style: TextStyle(color: Colors.red)),
      children: <Widget>[
        ListTile(
          title: Text(
            widget.med.blackBoxWarning,
          ),
        ),
      ],
    );
  }

  _getWorkup() {
    return ExpansionTile(
      title: Text('Work Up'),
      children: <Widget>[
        ListTile(
          title: widget.med.mphWorkUp != ''
              ? Text(widget.med.mphWorkUp)
              : Text(widget.med.amphWorkUp),
        )
      ],
    );
  }

  _getMisc() {
    return ExpansionTile(
      title: Text('Miscellaneous'),
      children: <Widget>[
        ListTile(
          title: Text(widget.med.misc),
          subtitle: widget.med.miscComment != ''
              ? Text(widget.med.miscComment)
              : null,
        )
      ],
    );
  }

  _getDoseComments() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(height: 15),
            child: Text('Additional Information:'),
          ),
          if (widget.med.doseInitComment != "")
            Text(
              'Initial: ' + widget.med.doseInitComment,
              style: TextStyle(fontSize: 12, color: Colors.grey[800]),
            ),
          if (widget.med.doseRangeComment != "")
            Text(
              'Range: ' + widget.med.doseRangeComment,
              style: TextStyle(fontSize: 12, color: Colors.grey[800]),
            ),
        ],
      ),
    );
  }

  _buildDoseInfo(int count) {
    List<String> info = [
      widget.med.doseInit,
      widget.med.doseRange,
      widget.med.maxDose,
      widget.med.maxDoseForKids,
      widget.med.frequency,
      widget.med.equiv
    ];
    List<String> name = [
      'Initial',
      'Range',
      'Max',
      'Max For Kids',
      'Frequency',
      'Equivalency'
    ];
    List<Widget> result = [];

    int current = 0;
    if (count <= 3) {
      for (int i = 0; i < info.length; i++) {
        if (info[i] != "") {
          result.add(doseProfile(name[i], info[i], count));
        }
      }
    } else {
      for (int i = 0; i < info.length; i++) {
        if (info[i] != "") {
          if (current < 3) {
            result.add(doseProfile(name[i], info[i], 3));
          } else {
            result.add(doseProfile(name[i], info[i], count - 3));
          }
          current++;
        }
      }
    }
    return result;
  }

  _getDoseInfo() {
    int count = 0;

    if (widget.med.doseInit != "") count++;
    if (widget.med.doseRange != "") count++;
    if (widget.med.maxDose != "") count++;
    if (widget.med.maxDoseForKids != "") count++;
    if (widget.med.frequency != "") count++;
    if (widget.med.equiv != "") count++;

    return ExpansionTile(
      title: Text('Dose Information'),
      initiallyExpanded: true,
      children: <Widget>[
        Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: _buildDoseInfo(count)),
        if (widget.med.doseInitComment != "" ||
            widget.med.doseRangeComment != "")
          _getDoseComments()
      ],
    );
  }

  _getIconColor(int modifier) {
    switch (modifier) {
      case 1:
        return Icon(Icons.done, color: Colors.green);
        break;
      case -1:
        return Icon(Icons.priority_high, color: Colors.red);
        break;
      case 0:
        return Text('');
        break;
    }
  }

  _customListTile(Widget leading, String drugName, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 0),
      child: SizedBox(
        height: 35,
        child: InkWell(
          onTap: () {},
          child: Container(
            child: Row(
              children: <Widget>[
                SizedBox(width: 50, child: leading),
                Expanded(
                  child: Text(drugName),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getIndAvatar(modifier) {
    switch (modifier) {
      case 1:
        return CircleAvatar(
          radius: 10,
          backgroundColor: Colors.green,
          child: Text('1',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
        );
        break;
      case 2:
        return CircleAvatar(
          radius: 10,
          backgroundColor: Colors.yellow,
          child: Text('2',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
        );
        break;
      case 3:
        return CircleAvatar(
          radius: 10,
          backgroundColor: Colors.orange,
          child: Text('3',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
        );
      case 4:
        return Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.yellow,
              child: Text('2',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.orange,
              child: Text('3',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            )
          ],
        );
        break;
      case 5:
        return Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.green,
              child: Text('1',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.yellow,
              child: Text('2',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            )
          ],
        );
        break;
        case 6:
         return Row(
          children: [
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.green,
              child: Text('1',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            ),
            CircleAvatar(
              radius: 10,
              backgroundColor: Colors.orange,
              child: Text('3',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
            )
          ],
        );

        break;
    }
  }

  _buildCustomTile(Indication ind) {
    var modifier;
    if (ind.indication.contains('1st line') &&
        ind.indication.contains('2nd line'))
      modifier = 5;
    else if (ind.indication.contains('3rd line') &&
        ind.indication.contains('1st line'))
      modifier = 6;
    else if (ind.indication.contains('1st line') ||
        ind.indication.contains('first line'))
      modifier = 1;
    else if (ind.indication.contains('3rd line') &&
        ind.indication.contains('2nd line'))
      modifier = 4;
    else if (ind.indication.contains('2nd line'))
      modifier = 2;
    else if (ind.indication.contains('3rd line'))
      modifier = 3;
    else
      modifier = 0;
    print(modifier);
    return _customListTile(_getIndAvatar(modifier), ind.indication, context);
  }

  _buildIndications() {
    String title =
        widget.med.indications.length > 1 ? 'Indications' : 'Indication';
    return ExpansionTile(
      title: Row(
        children: [
          SizedBox(width: 110, child: Text(title)),
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.blue,
            child: Text(
              '${widget.med.indications.length}',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
      children: <Widget>[
        for (var ind in widget.med.indications) _buildCustomTile(ind)
      ],
    );
  }

  _buildSideEffects() {
    String title =
        widget.med.sideEffects.length > 1 ? 'Side Effects' : 'Side Effect';
    return ExpansionTile(
      title: Row(
        children: [
          SizedBox(width: 110, child: Text(title)),
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.blue,
            child: Text(
              '${widget.med.sideEffects.length}',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
      children: <Widget>[
        for (var sideEffect in widget.med.sideEffects)
          _customListTile(_getIconColor(sideEffect.modifier),
              sideEffect.sideEffect, context)
      ],
    );
  }

  _buildSevereEffects() {
    String title = widget.med.severeEffects.length > 1
        ? 'Severe Effects'
        : 'Severe Effect';
    return ExpansionTile(
      title: Row(
        children: [
          SizedBox(width: 110, child: Text(title)),
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.blue,
            child: Text(
              '${widget.med.severeEffects.length}',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
      children: <Widget>[
        for (var severeEffect in widget.med.severeEffects)
          _customListTile(_getIconColor(severeEffect.modifier),
              severeEffect.severeEffect, context)
      ],
    );
  }

  _medProfileAppBar() {
    return AppBar(
      title: Column(
        children: <Widget>[
          Text(widget.med.medName),
          widget.med.subCat != ""
              ? Text(
                  widget.med.subCat + ' ' + widget.med.cat,
                  style: TextStyle(fontSize: 12),
                )
              : Text(
                  widget.med.cat,
                  style: TextStyle(fontSize: 12),
                )
        ],
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        IconButton(
          icon: Icon(Icons.info),
          onPressed: () {
            showPlatformDialog(
                context: context,
                builder: (_) => PlatformAlertDialog(
                      title: Text('Information'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                              'For Indications, Side Effects and Severe Effects:'),
                          Divider(),
                          Row(
                            children: <Widget>[
                              Icon(Icons.done, color: Colors.green),
                              Text('Advantage, Known For')
                            ],
                          ),
                          Divider(),
                          Row(
                            children: <Widget>[
                              Icon(Icons.priority_high, color: Colors.red),
                              Text('Disadvantage, Known For')
                            ],
                          )
                        ],
                      ),
                      actions: <Widget>[
                        PlatformDialogAction(
                          child: PlatformText('Ok'),
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                        )
                      ],
                    ));
          },
        )
      ],
    );
  }

  List<Widget> _medProfileBody() {
    return [
      _getDoseInfo(),
      if (widget.med.blackBoxWarning != '') _getBlackBoxWarning(),
      if (widget.med.indications.length != 0) _buildIndications(),
      if (widget.med.sideEffects.length != 0) _buildSideEffects(),
      if (widget.med.severeEffects.length != 0) _buildSevereEffects(),
      if (widget.med.misc != '') _getMisc(),
      if (widget.med.cat == 'Antipsychotic' && widget.med.subCat == 'Typical')
        _getAntipsychoticChart(),
      if (widget.med.cat == 'Antipsychotic' &&
          (widget.med.subCat == 'Typical' || widget.med.subCat == 'Atypical'))
        _getEquivChart(),
      if (widget.med.subCat == 'Benzodiazepines') _getBenzoChart(),
      if (widget.med.cat == 'ADHD') _getADHDChart(),
      if (widget.med.cat == 'Mood Stabilizer') _getMoodChart(),
      if (widget.med.amphWorkUp != '' || widget.med.mphWorkUp != '')
        _getWorkup(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _medProfileAppBar(),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _medProfileBody(),
            ),
          ),
        ],
      ),
    );
  }
}
