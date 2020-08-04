import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:knebelknotes/custom_plugins/filter_list/fiter_list.dart';

import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/med_profile_page.dart';
import 'package:knebelknotes/data/medication.dart';

class MedicationsPage extends StatefulWidget {
  createState() => MedicationsPageState();
}

class MedicationsPageState extends State<MedicationsPage> {
  //Search Bar
  bool isSearching = false;
  TextEditingController _controller = new TextEditingController();
  String _searchItem;

  List<String> _indications = [];
  List<String> _selectedIndications = [];

  List<String> _sideEffects = [];
  List<String> _selectedSideEffects = [];

  List<String> _severeEffects = [];
  List<String> _selectedSevereEffects = [];

  Color indicationColor = Colors.green;
  Color sideEffectColor = Colors.yellow;
  Color severeEffectColor = Colors.orange;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _searchItem = _controller.text;
      });
    });
    if (_indications.isEmpty) {
      MedicationDao.md.getMedIndications().then((value) => setState(() {
            _indications = value;
          }));
    }
    if (_sideEffects.isEmpty) {
      MedicationDao.md.getMedSideEffects().then((value) => setState(() {
            _sideEffects = value;
          }));
    }

    if (_severeEffects.isEmpty) {
      MedicationDao.md.getMedSevereEffects().then((value) {
        _severeEffects = value;
      });
    }
  }

  _searching() {
    setState(() {
      isSearching == false
          ? _searchItem = _controller.text
          : _searchItem = null;
      isSearching = !isSearching;
    });
  }

  void _openIndicationFilterList() async {
    var list = await FilterList.showFilterList(context,
        selectedTextColor: Colors.black,
        hideSelectedTextCount: true,
        color: indicationColor,
        allTextList: _indications,
        hideheaderText: true,
        hidecloseIcon: true,
        searchFieldHintText: 'Search Indications',
        selectedTextList: _selectedIndications);

    if (list != null) {
      setState(() {
        _selectedIndications = List.from(list);
      });
    }
  }

  void _openSideEffectFilterList() async {
    var list = await FilterList.showFilterList(context,
        selectedTextColor: Colors.black,
        hideSelectedTextCount: true,
        color: sideEffectColor,
        allTextList: _sideEffects,
        hideheaderText: true,
        hidecloseIcon: true,
        searchFieldHintText: 'Search Side Effects',
        selectedTextList: _selectedSideEffects);

    if (list != null) {
      setState(() {
        _selectedSideEffects = List.from(list);
      });
    }
  }

  void _openSevereEffectFilterList() async {
    var list = await FilterList.showFilterList(context,
        selectedTextColor: Colors.black,
        hideSelectedTextCount: true,
        color: severeEffectColor,
        allTextList: _severeEffects,
        hideheaderText: true,
        hidecloseIcon: true,
        searchFieldHintText: 'Search Severe Effects',
        selectedTextList: _selectedSevereEffects);

    if (list != null) {
      setState(() {
        _selectedSevereEffects = List.from(list);
      });
    }
  }

  _buildChip(String title, Color color, List<String> currentList) {
    return Padding(
      padding: EdgeInsets.only(top: 5),
      child: Chip(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        deleteIcon: Icon(
          Icons.cancel,
          color: Colors.white,
        ),
        onDeleted: () => {
          setState(() => {currentList.remove(title)})
        },
        backgroundColor: color,
        label: Text(title),
      ),
    );
  }

  _getChipList() {
    List<Widget> filters = [];
    for (var ind in _selectedIndications) {
      filters.add(_buildChip(ind, indicationColor, _selectedIndications));
    }
    for (var sideEffect in _selectedSideEffects) {
      filters.add(_buildChip(sideEffect, sideEffectColor, _selectedSideEffects));
    }
    for (var severeEffect in _selectedSevereEffects) {
      filters
          .add(_buildChip(severeEffect, severeEffectColor, _selectedSevereEffects));
    }
    return Wrap(alignment: WrapAlignment.center,spacing: 4,children: filters);
  }

  _listTile(Medication med) {
    return ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(med.medName),
          if (med.subCat != "")
            Text(
              med.subCat,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          Text(
            med.cat,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      trailing: Icon(Icons.navigate_next),
      onTap: () => Navigator.of(context).push(
        platformPageRoute(
          context: context,
          builder: (_) => MedProfilePage(med),
        ),
      ),
    );
  }

  _searchResults(AsyncSnapshot snapshot, int index) {
    Medication result;
    if (_searchItem == null || _searchItem == "") {
      result = snapshot.data[index];
    } else if (snapshot.data[index].medName
        .toLowerCase()
        .contains(_searchItem.toLowerCase())) result = snapshot.data[index];

    if (_selectedIndications.isNotEmpty && result != null) {
      int counter = 0;
      for (var selInd in _selectedIndications) {
        bool contained = false;
        for (var ind in snapshot.data[index].indications) {
          if (ind.indication.toUpperCase().contains(selInd)) {
            contained = true;
            break;
          }
        }
        if (contained) counter++;
      }

      if (_selectedIndications.length != counter) result = null;
    }

    if (_selectedSideEffects.isNotEmpty && result != null) {
      int counter = 0;
      for (var selSideEffect in _selectedSideEffects) {
        bool contained = false;
        for (var se in snapshot.data[index].sideEffects) {
          if (se.sideEffect.toUpperCase().contains(selSideEffect)) {
            contained = true;
            break;
          }
        }
        if (contained) counter++;
      }
      if (_selectedSideEffects.length != counter) result = null;
    }

    if (_selectedSevereEffects.isNotEmpty && result != null) {
      int counter = 0;
      for (var selSevereEffect in _selectedSevereEffects) {
        bool contained = false;
        for (var se in snapshot.data[index].severeEffects) {
          if (se.severeEffect.toUpperCase().contains(selSevereEffect)) {
            contained = true;
            break;
          }
        }
        if (contained) counter++;
      }
      if (_selectedSevereEffects.length != counter) result = null;
    }
    if (result != null)
      return _listTile(result);
    else
      return Container();
  }

  void popUpMenuChoiceAction(String choice) {
    if (choice == Constants.Indications)
      _openIndicationFilterList();
    else if (choice == Constants.SideEffects)
      _openSideEffectFilterList();
    else if (choice == Constants.SevereEffects) _openSevereEffectFilterList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: !isSearching
              ? Text('Medications')
              : TextField(
                  autofocus: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search Medications',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchItem = null;
                        _controller.text = "";
                      },
                    ),
                  ),
                  controller: _controller,
                ),
          centerTitle: true,
          actions: <Widget>[
            isSearching
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            _searching();
                          }),
                    ],
                  )
                : IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      _searching();
                    },
                  ),
            PopupMenuButton(
              offset: Offset(0, 100),
              icon: Icon(Icons.filter_list),
              onSelected: popUpMenuChoiceAction,
              itemBuilder: (BuildContext context) {
                return Constants.choices.map((String choice) {
                  return PopupMenuItem<String>(
                      value: choice, child: Text(choice));
                }).toList();
              },
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            _getChipList(),
            Expanded(
              child: FutureBuilder(
                future: MedicationDao.md.getAllSortedByName(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: PlatformCircularProgressIndicator(),
                    );
                  else
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return _searchResults(snapshot, index);
                      },
                    );
                },
              ),
            )
          ],
        ));
  }
}

class Constants {
  static const String Indications = 'Indications';
  static const String SideEffects = 'Side Effects';
  static const String SevereEffects = 'Severe Effects';

  static const List<String> choices = [Indications, SideEffects, SevereEffects];
}
