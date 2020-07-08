import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class GuidelinesPage extends StatelessWidget {
  _buildMoodDisorders() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Major Depressive Disorder(MDD)'),
          trailing: Icon(Icons.navigate_next),
        ),
        Divider(),
        ListTile(
          title: Text('Bipolar I Disorder'),
          trailing: Icon(Icons.navigate_next),
        ),
        Divider(),
        ListTile(
          title: Text('Bipolar II Disorder'),
          trailing: Icon(Icons.navigate_next),
        )
      ],
    );
  }

  _buildAnxietyDisorders() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Generalized Anxiety Disorder (GAD)'),
          trailing: Icon(Icons.navigate_next),
        ),
        Divider(),
        ListTile(
          title: Text('Seasonal Affective Disorder (SAD)'),
          trailing: Icon(Icons.navigate_next),
        ),
        Divider(),
        ListTile(
          title: Text('Panic Disorder'),
          trailing: Icon(Icons.navigate_next),
        ),
        Divider(),
        ListTile(
          title: Text('Phobic Disorder'),
          trailing: Icon(Icons.navigate_next),
        )
      ],
    );
  }

  
  _buildPsychoticDisorders() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Schizophrenia'),
          trailing: Icon(Icons.navigate_next),
        )
      ],
    );
  }

   _buildStressDisorders() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Post-Traumatic Stress Disorder (PTSD)'),
          trailing: Icon(Icons.navigate_next),
        ),
        Divider(),
        ListTile(
          title: Text('Adjustment Disorder'),
          trailing: Icon(Icons.navigate_next),
        )
      ],
    );
  }
   _buildOtherDisorders() {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Obsessive-Compulsive Disorder (OCD)'),
          trailing: Icon(Icons.navigate_next),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: PlatformAppBar(
            title: Text('Disorders'),
            material: (_, __) => MaterialAppBarData(
              bottom: TabBar(
                isScrollable: true,
                tabs: [
                  Text('Mood'),
                  Text('Anxiety'),
                  Text('Psychotic'),
                  Text('Stress'),
                  Text('Other'),
                ],
              ),
              centerTitle: true,
            ),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            _buildMoodDisorders(),
            _buildAnxietyDisorders(),
            _buildPsychoticDisorders(),
            _buildStressDisorders(),
            _buildOtherDisorders()
          ],
        ),
      ),
    );
  }
}
