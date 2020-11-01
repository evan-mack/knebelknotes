import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/data/medication.dart';

import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/med_profile_page2.dart';

class ClassList extends StatelessWidget {
  final String cat;
  ClassList(this.cat);

  _getTitle(String medName) {
    var title;
    if (medName.contains('(') && medName.contains(')')) {
      title = medName.split('(');
      if (title[1].length < 4) {
        title[0] = medName;
        title[1] = ' ';
      }
      return Center(
        child: Row(
          children: <Widget>[
            Text(title[0]),
            Spacer(),
            Text(title[1].substring(0, title[1].length - 1),
                style: TextStyle(
                  color: Colors.grey[800],
                  fontSize: 14,
                ))
          ],
        ),
      );
    } else
      return Text(medName);
  }

  _getSubTitle(List<Indication> indications, String medName) {
    List<String> items = [];
    for (var ind in indications) {
      items.add(ind.indication);
    }
    items.sort((a, b) => a.compareTo(b));
    List<Widget> result = [];
    List<Widget> result2 = [];

    items.forEach((element) {
      result2.add(Text(element));
    });
    items.forEach((element) {
      result.add(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          margin: EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.grey[300],
          ),
          child: Center(
            child: Text(
              element,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
      );
    });
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _getTitle(medName),
          Row(
            children: result,
          )
        ]);
  }

  _buildMedBySubClassList(String cat, String item) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(
        item,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w500, color: Colors.blue),
      ),
      children: <Widget>[
        FutureBuilder(
            future: MedicationDao.md.getMedBySubCategory(cat, item),
            builder: (BuildContext context, AsyncSnapshot snapshot2) {
              if (!snapshot2.hasData) {
                return Center(
                  child: PlatformCircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot2.data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: _getTitle(snapshot2.data[index].medName),
                        trailing: Icon(Icons.navigate_next),
                        onTap: () => Navigator.of(context).push(
                          platformPageRoute(
                            context: context,
                            builder: (_) =>
                                MedProfilePage(snapshot2.data[index]),
                          ),
                        ),
                      );
                    });
              }
            })
      ],
    );
  }

  _buildMedBySubClass() {
    return FutureBuilder(
      future: MedicationDao.md.getAllSubCategories(cat),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: PlatformCircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                if (snapshot.data.length == 1)
                  _buildMedByClass()
                else
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (var item in snapshot.data)
                        _buildMedBySubClassList(cat, item)
                    ],
                  )
              ],
            ),
          );
        }
      },
    );
  }

  _buildAntipsychoticList() {
    return [
      FutureBuilder(
        future: MedicationDao.md.getAllSubCategories('Antipsychotic'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: PlatformCircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
                child: Column(children: [
              for (var item in snapshot.data)
                if (item == 'Typical' || item == 'Atypical')
                  _buildMedBySubClassList(cat, item)
            ]));
          }
        },
      ),
      FutureBuilder(
        future: MedicationDao.md.getAllSubCategories('Antipsychotic'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: PlatformCircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
                child: Column(children: [
              for (var item in snapshot.data)
                if (item != 'Typical' && item != 'Atypical')
                  _buildMedBySubClassList(cat, item)
            ]));
          }
        },
      ),
    ];
  }

  _buildMedByClass() {
    return FutureBuilder(
      future: MedicationDao.md.getMedByClass(cat),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: PlatformCircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return snapshot.data[index].cat == 'Side Effect Meds'
                  ? ListTile(
                      title: _getSubTitle(snapshot.data[index].indications,
                          snapshot.data[index].medName),
                      trailing: Icon(Icons.navigate_next),
                      onTap: () => Navigator.of(context).push(
                        platformPageRoute(
                          context: context,
                          builder: (_) => MedProfilePage(snapshot.data[index]),
                        ),
                      ),
                    )
                  : ListTile(
                      title: _getTitle(snapshot.data[index].medName),
                      trailing: Icon(Icons.navigate_next),
                      onTap: () => Navigator.of(context).push(
                        platformPageRoute(
                          context: context,
                          builder: (_) => MedProfilePage(snapshot.data[index]),
                        ),
                      ),
                    );
            },
          );
        }
      },
    );
  }

  _antipsychoticList() {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(56),
              child: AppBar(
                title: Text('Antipsychotics'),
                centerTitle: true,
              ),
            ),
            body: Column(children: [
              TabBar(tabs: [
                Container(
                  child: Center(
                      child: Text(
                    'Oral',
                    style: TextStyle(color: Colors.blue),
                  )),
                  height: 40,
                ),
                Container(
                  child: Center(
                      child: Text('Injectable',
                          style: TextStyle(color: Colors.blue))),
                  height: 40,
                ),
              ]),
              Expanded(
                child: TabBarView(children: _buildAntipsychoticList()),
              )
            ])));
  }

  _otherList() {
    return Scaffold(
      appBar: AppBar(
        title: cat == 'Addiction Med'
            ? Text('Mood Stabilizers')
            : cat == 'Side Effect Meds'
                ? Text('Medications for Side Effects')
                : cat == 'Antidepressant' ? Text('Antidepressants') : Text(cat),
        centerTitle: true,
      ),
      body: _buildMedBySubClass(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return cat == 'Antipsychotic' ? _antipsychoticList() : _otherList();
  }
}
