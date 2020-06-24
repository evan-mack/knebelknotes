import 'dart:ui';

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

  doseProfile(String title, String content, {String comment}) {
    return Container(
      child: ListTile(
        title: Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Card(
                elevation: 0,
                color: Colors.blue,
                child: Container(
                  margin: EdgeInsets.all(8),
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
            ),
            Flexible(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  content,
                ),
              ),
            ),
          ],
        ),
        subtitle: comment != null
            ? Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 3),
                child: Text(comment),
              )
            : null,
        dense: true,
      ),
    );
  }

  _getBlackBoxWarning() {
    return ExpansionTile(
      initiallyExpanded: true,
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
      title: Text('Miscellaneous Info.'),
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

  _getDoseInfo() {
    return ExpansionTile(
      title: Text('Dose Information'),
      initiallyExpanded: true,
      children: <Widget>[
        if (widget.med.doseInit != "")
          doseProfile('Initial Dose', widget.med.doseInit,
              comment: widget.med.doseInitComment != ""
                  ? widget.med.doseInitComment
                  : null),
        if (widget.med.maxDose != "")
          doseProfile('Max Dose', widget.med.maxDose),
        if (widget.med.maxDoseForKids != "")
          doseProfile('Max Dose For Kids', widget.med.maxDoseForKids),
        if (widget.med.doseRange != "")
          doseProfile('Dose Range', widget.med.doseRange),
        if (widget.med.frequency != "")
          doseProfile('Frequency', widget.med.frequency),
        if (widget.med.equiv != "") doseProfile('Equivalency', widget.med.equiv)
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

  _buildIndications() {
    String title =
        widget.med.indications.length > 1 ? 'Indications' : 'Indication';
    return ExpansionTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          '${widget.med.indications.length}',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      children: <Widget>[
        for (var ind in widget.med.indications)
          ListTile(
            leading: _getIconColor(ind.modifier),
            title: Text(ind.indication),
            dense: true,
          ),
      ],
    );
  }

  _buildSideEffects() {
    String title =
        widget.med.sideEffects.length > 1 ? 'Side Effects' : 'Side Effect';
    return ExpansionTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          '${widget.med.sideEffects.length}',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      children: <Widget>[
        for (var sideEffect in widget.med.sideEffects)
          ListTile(
            leading: _getIconColor(sideEffect.modifier),
            title: Text(sideEffect.sideEffect),
            dense: true,
          )
      ],
    );
  }

  _buildSevereEffects() {
    String title = widget.med.severeEffects.length > 1
        ? 'Severe Effects'
        : 'Severe Effect';
    return ExpansionTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          '${widget.med.severeEffects.length}',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      children: <Widget>[
        for (var severeEffect in widget.med.severeEffects)
          ListTile(
              leading: _getIconColor(severeEffect.modifier),
              title: Text(severeEffect.severeEffect),
              dense: true)
      ],
    );
  }

  _medProfileAppBar() {
    return PlatformAppBar(
      material: (_, __) => MaterialAppBarData(centerTitle: true),
      cupertino: (_, __) =>
          CupertinoNavigationBarData(previousPageTitle: 'Meds'),
      title: Column(
        children: <Widget>[
          Text(widget.med.medName),
          widget.med.subCat != ""
              ? Text(
                  widget.med.subCat + ' ' + widget.med.cat,
                  style: TextStyle(fontSize: 14),
                )
              : Text(
                  widget.med.cat,
                  style: TextStyle(fontSize: 14),
                )
        ],
      ),
      trailingActions: <Widget>[
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
                              Text('Indicates a positive interaction')
                            ],
                          ),
                          Divider(),
                          Row(
                            children: <Widget>[
                              Icon(Icons.priority_high, color: Colors.red),
                              Text('Indicates a negative interaction')
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
      if (widget.med.amphWorkUp != '' || widget.med.mphWorkUp != '')
        _getWorkup(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
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
