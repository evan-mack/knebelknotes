import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/pages/disorders/adjustment_list.dart';
import 'package:knebelknotes/pages/disorders/bipolar1_list.dart';
import 'package:knebelknotes/pages/disorders/bipolar2_list.dart';
import 'package:knebelknotes/pages/disorders/gad_list.dart';
import 'package:knebelknotes/pages/disorders/mdd_list.dart';
import 'package:knebelknotes/pages/disorders/ocd_list.dart';
import 'package:knebelknotes/pages/disorders/panic_list.dart';
import 'package:knebelknotes/pages/disorders/phobia_list.dart';
import 'package:knebelknotes/pages/disorders/ptsd_ist.dart';
import 'package:knebelknotes/pages/disorders/sad_list.dart';
import 'package:knebelknotes/pages/disorders/schizophrenia_list.dart';

class GuidelinesPage extends StatelessWidget {
  _buildMoodDisorders(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Major Depressive Disorder(MDD)'),
          trailing: Icon(Icons.navigate_next),
          onTap: () => {
            Navigator.of(context).push(
                platformPageRoute(context: context, builder: (_) => MDDList()))
          },
        ),
        ListTile(
            title: Text('Bipolar I Disorder'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => Bipolar1List()))
                }),
        ListTile(
            title: Text('Bipolar II Disorder'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => Bipolar2List()))
                })
      ],
    );
  }

  _buildAnxietyDisorders(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            title: Text('Generalized Anxiety Disorder (GAD)'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => GADList()))
                }),
        ListTile(
            title: Text('Seasonal Affective Disorder (SAD)'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => SADList()))
                }),
        ListTile(
            title: Text('Panic Disorder'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => PanicList()))
                }),
        ListTile(
            title: Text('Phobic Disorder'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => PhobiaList()))
                }),
        ListTile(
            title: Text('Obsessive-Compulsive Disorder (OCD)'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => OCDList()))
                }),
        ListTile(
            title: Text('Post-Traumatic Stress Disorder (PTSD)'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => PTSDList()))
                }),
        ListTile(
            title: Text('Adjustment Disorder'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => AdjustmentList()))
                })
      ],
    );
  }

  _buildPsychoticDisorders(context) {
    return Column(
      children: <Widget>[
        ListTile(
            title: Text('Schizophrenia'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => SchizophreniaList()))
                })
      ],
    );
  }

  _buildStressDisorders(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            title: Text('Post-Traumatic Stress Disorder (PTSD)'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => PTSDList()))
                }),
        Divider(),
        ListTile(
            title: Text('Adjustment Disorder'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => AdjustmentList()))
                })
      ],
    );
  }

  _buildOtherDisorders(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            title: Text('Obsessive-Compulsive Disorder (OCD)'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => {
                  Navigator.of(context).push(platformPageRoute(
                      context: context, builder: (_) => OCDList()))
                })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: AppBar(
            title: Text('Disorders'),
            bottom: TabBar(
              tabs: [
                Text('Mood'),
                Text('Anxiety'),
                Text('Psychotic'),
              ],
            ),
            centerTitle: true,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _buildMoodDisorders(context),
            _buildAnxietyDisorders(context),
            _buildPsychoticDisorders(context),
          ],
        ),
      ),
    );
  }
}
