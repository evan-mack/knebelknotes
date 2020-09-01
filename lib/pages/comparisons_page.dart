import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/pages/comparison_tables/adhd_table.dart';

import 'package:knebelknotes/pages/comparison_tables/antipsychotic_chart.dart';
import 'package:knebelknotes/pages/comparison_tables/benzo_comparison.dart';
import 'package:knebelknotes/pages/comparison_tables/antipsychotic_equiv_table.dart';
import 'package:knebelknotes/pages/comparison_tables/mood_stabilizertable.dart';

class ComparisonsPage extends StatelessWidget {
  _buildSideEffectComparisonList(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            title: Text('Antipsychotics'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => Navigator.of(context).push(
                  platformPageRoute(
                    context: context,
                    builder: (_) => AntipsychoticChart(),
                  ),
                )),
        Divider(),
        ListTile(
          title: Text('Mood Stabilizers'),
          trailing: Icon(Icons.navigate_next),
          onTap: () => Navigator.of(context).push(
            platformPageRoute(
              context: context,
              builder: (_) => MoodChart(),
            ),
          ),
        )
      ],
    );
  }

  _buildEquivalencyComparisonList(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
            title: Text('Antipsychotics'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => Navigator.of(context).push(
                  platformPageRoute(
                    context: context,
                    builder: (_) => AntipsychoticEquiv(),
                  ),
                )),
        Divider(),
        ListTile(
            title: Text('Benzodiazapines'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => Navigator.of(context).push(
                  platformPageRoute(
                    context: context,
                    builder: (_) => BenzoComparison(),
                  ),
                )),
        Divider(),
        ListTile(
            title: Text('Stimulants (for ADHD)'),
            trailing: Icon(Icons.navigate_next),
            onTap: () => Navigator.of(context).push(
                  platformPageRoute(
                    context: context,
                    builder: (_) => ADHDChart(),
                  ),
                )),
      ],
    );
  }

  double tabBarHeight = 40;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(56),
            child: AppBar(
              title: Text('Comparisons By'),
              centerTitle: true,
            ),
          ),
          body: Column(children: [
            Container(
                height: tabBarHeight,
                child: TabBar(
                  labelColor: Colors.blue,
                  tabs: <Widget>[
                    Container(
                      child: Center(child: Text('Side Effects')),
                      height: tabBarHeight,
                    ),
                    Container(
                      child: Center(child: Text('Equivalency')),
                      height: tabBarHeight,
                    )
                  ],
                )),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  _buildSideEffectComparisonList(context),
                  _buildEquivalencyComparisonList(context)
                ],
              ),
            ),
          ])),
    );
  }
}
