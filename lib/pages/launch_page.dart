import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:knebelknotes/pages/home_page.dart';
import 'package:knebelknotes/repo/medications_repo.dart';
import 'package:knebelknotes/pages/medications_page.dart';
import 'package:knebelknotes/pages/comparisons_page.dart';

final materialThemeData = ThemeData();

final cupertinoThemeData = CupertinoThemeData();

class LaunchPage extends StatefulWidget {
  createState() => LaunchPageState();
}

class LaunchPageState extends State<LaunchPage> {
  //Used for persistent nav bar
  PersistentTabController _controller;
  List<Widget> _buildScreens() {
    return [
      HomePage(_goToPage),
      Text('Guidlines'),
      Text('Classes'),
      ComparisonsPage(),
      MedicationsPage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: ('Home'),
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
          isTranslucent: false),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.content_copy),
          title: ('Guidelines'),
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
          isTranslucent: false),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.local_pharmacy),
          title: ('Classes'),
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
          isTranslucent: false),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.compare_arrows),
          title: ('Comparisons'),
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
          isTranslucent: false),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.search),
          title: ('Meds'),
          activeColor: Colors.blue,
          inactiveColor: Colors.grey,
          isTranslucent: false),
    ];
  }

  //Loading data from JSON
  _loadFromApi() async {
    var apiProvider = MedicationsRepo();
    await apiProvider.fetchMedicationData();
  }

  //Change page when list item clicked function
  void _goToPage(int index) {
    setState(() {
      _controller.jumpToTab(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFromApi();

    //persistentNavBar
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        onItemSelected: (int index) {
          print(index);
          setState(() {});
        },
        navBarStyle: NavBarStyle.style9,
        itemCount: 5,
      
    );

  }
}
