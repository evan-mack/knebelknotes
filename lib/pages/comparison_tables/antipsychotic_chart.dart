import 'package:flutter/material.dart';
import 'package:knebelknotes/data/medication_dao.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/pages/med_profile_page2.dart';

class AntipsychoticChart extends StatelessWidget {
  _buildLeftSide() {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

          
          Text('High Potency'),
          Text(''),
          Text(''),
          Row(
            children: <Widget>[
              Icon(Icons.arrow_upward),
              Icon(Icons.arrow_upward),
              Icon(Icons.arrow_upward),
            ],
          ),
          Text('Side Effect'),
          Text('Spectrum From'),
          Text('High to Low'),
          Text('Potency'),
          Row(
            children: <Widget>[
              Icon(Icons.arrow_downward),
              Icon(Icons.arrow_downward),
              Icon(Icons.arrow_downward),
            ],
          ),
          Text(''),
          Text(''),
          Text('Low Potency'),
        ],
      ),
    );
  }

  _customListTile(String drugName, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10),
      child: SizedBox(
        height: 30,
        child: InkWell(
          onTap: () {
            MedicationDao.md.getMedByName(drugName).then((med) {
              Navigator.of(context).push(platformPageRoute(
                  context: context, builder: (_) => MedProfilePage(med)));
            });
          },
          child: Container(
            child: Row(
              children: <Widget>[
                Text(drugName),
                Spacer(),
                Icon(Icons.navigate_next)
              ],
            ),
          ),
        ),
      ),
    );
  }

  var medList = [
    'Haloperidol (Haldol)',
    'Flupenthixol (Fluanxol)',
    'Fluphenazine (Prolixin)',
    'Perphenazine (Trilafon)',
    'Prochloperazine',
    'Pericyazine (Neuleptil)',
    'Zuclopenthixol (Clopixol)',
    'Loxapine (Loxapac)',
    'Methotrimeprazine (Nozinan)',
    'Chlorpromazine (Largactil)'
  ];
  _buildRightSide(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        for (var drug in medList) _customListTile(drug, context)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Antipsychotic Comparison'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[300],
              border: Border(
                bottom: BorderSide(width: 1),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'EPS: acute dystonia, parkinsonism, akithisia, tardive dyskiniesia',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.blue[300], Colors.yellow[300]],
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    _buildLeftSide(),
                    VerticalDivider(),
                    Expanded(child: _buildRightSide(context))
                  ],
                )),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.yellow[300],
              border: Border(
                top: BorderSide(width: 1),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  'Anti-cholinergic, Anti-adrenergic, Anti-histamine',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
