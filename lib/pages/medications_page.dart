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
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: !isSearching
            ? Center(
                child: Text('Medications'),
              )
            : TextField(
              autofocus: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  icon: Icon(Icons.search),
                  hintText: 'Search Medications',
                ),
                controller: _controller,
              ),
        trailingActions: <Widget>[
          isSearching
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                      height: 30,
                      child: FlatButton(
                        padding: EdgeInsets.all(8),
                        textColor: Colors.blue,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('Clear'),
                        onPressed: () {
                          setState(() {
                            _searchItem = null;
                            _controller.text = "";
                          });
                        },
                      ),
                    ),
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
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return _searchItem == null || _searchItem == ""
                    ? Card(
                        child: ListTile(
                            title: Text('${snapshot.data[index].medName}'),
                            subtitle: snapshot.data[index].subCat == ""
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text('${snapshot.data[index].cat}'),
                                      Text('')
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text('${snapshot.data[index].subCat}'),
                                      Text('${snapshot.data[index].cat}'),
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
                            dense: true),
                      )
                    : snapshot.data[index].medName
                            .toLowerCase()
                            .contains(_searchItem.toLowerCase())
                        ? Card(
                            child: ListTile(
                                title: Text('${snapshot.data[index].medName}'),
                                subtitle: snapshot.data[index].subCat == ""
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text('${snapshot.data[index].cat}'),
                                          Text('')
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                              '${snapshot.data[index].subCat}'),
                                          Text('${snapshot.data[index].cat}'),
                                        ],
                                      ),
                                trailing: Icon(Icons.navigate_next),
                                onTap: () => Navigator.of(context).push(
                                      platformPageRoute(
                                        context: context,
                                        builder: (_) => MedProfilePage(
                                            snapshot.data[index]),
                                      ),
                                    ),
                                dense: true),
                          )
                        : Container();
              },
            );
        },
      ),
    );
  }
}
