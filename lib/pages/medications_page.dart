import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:knebelknotes/data/medication_dao.dart';
import 'package:knebelknotes/pages/med_profile_page.dart';

class MedicationsPage extends StatefulWidget {
  createState() => MedicationsPageState();
}

class MedicationsPageState extends State<MedicationsPage> {
  //Search Bar
  bool isSearching = false;
  TextEditingController _controller = new TextEditingController();
  String _searchItem;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _searchItem = _controller.text;
      });
    });
  }

  _searching() {
    setState(() {
      isSearching == false
          ? _searchItem = _controller.text
          : _searchItem = null;
      isSearching = !isSearching;
    });
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
                )
        ],
      ),
      body: FutureBuilder(
        future: MedicationDao.md.getAllSortedByName(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: PlatformCircularProgressIndicator(),
            );
          else
            return Scrollbar(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return _searchItem == null || _searchItem == ""
                      ? ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('${snapshot.data[index].medName}'),
                              if ('${snapshot.data[index].subCat}' != "")
                                Text(
                                  '${snapshot.data[index].subCat}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              Text(
                                '${snapshot.data[index].cat}',
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
                              builder: (_) =>
                                  MedProfilePage(snapshot.data[index]),
                            ),
                          ),
                        )
                      : snapshot.data[index].medName
                              .toLowerCase()
                              .contains(_searchItem.toLowerCase())
                          ? ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${snapshot.data[index].medName}'),
                                  if ('${snapshot.data[index].subCat}' != "")
                                    Text(
                                      '${snapshot.data[index].subCat}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  Text(
                                    '${snapshot.data[index].cat}',
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
                                  builder: (_) =>
                                      MedProfilePage(snapshot.data[index]),
                                ),
                              ),
                            )
                          : Container();
                },
              ),
            );
        },
      ),
    );
  }
}
